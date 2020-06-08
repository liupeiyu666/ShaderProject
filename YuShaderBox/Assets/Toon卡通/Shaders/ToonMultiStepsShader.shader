Shader "Toon/Basic/MultiSteps"
{
    Properties
    {
        // Colors
        _Color ("Color", Color) = (1, 1, 1, 1)
        _HColor ("Highlight Color", Color) = (0.8, 0.8, 0.8, 1.0)
		//阴影颜色
        _SColor ("Shadow Color", Color) = (0.2, 0.2, 0.2, 1.0)
        
        // texture
        _MainTex ("Main Texture", 2D) = "white" { }
        
        // Toon的次数
        _ToonSteps ("Steps of Toon", range(1, 9)) = 2
        _RampThreshold ("Ramp Threshold", Range(0.1, 1)) = 0.5
        _RampSmooth ("Ramp Smooth", Range(0, 1)) = 0.1
        
        // 反射的颜色
        _SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
        _SpecSmooth ("Specular Smooth", Range(0, 1)) = 0.1
        _Shininess ("Shininess", Range(0.001, 10)) = 0.2
        
        // 边缘光的颜色
        _RimColor ("Rim Color", Color) = (0.8, 0.8, 0.8, 0.6)
        _RimThreshold ("Rim Threshold", Range(0, 1)) = 0.5
        _RimSmooth ("Rim Smooth", Range(0, 1)) = 0.1
    }
    
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        
        CGPROGRAM
        
        #pragma surface surf Toon addshadow fullforwardshadows exclude_path:deferred exclude_path:prepass
        #pragma target 3.0
        
        fixed4 _Color;
        fixed4 _HColor;
        fixed4 _SColor;
        
        sampler2D _MainTex;
        
        float _RampThreshold;
        float _RampSmooth;
        float _ToonSteps;
        
        float _SpecSmooth;
        fixed _Shininess;
        
        fixed4 _RimColor;
        fixed _RimThreshold;
        float _RimSmooth;
        
        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };
        
        float linearstep(float min, float max, float t)
        {
            return saturate((t - min) / (max - min));
        }
        
        inline fixed4 LightingToon(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
        {
            half3 normalDir = normalize(s.Normal);
            half3 halfDir = normalize(lightDir + viewDir);
            //法线与灯光的夹角
            float ndl = max(0, dot(normalDir, lightDir));
			//法线和半角向量的夹角
            float ndh = max(0, dot(normalDir, halfDir));
			//法线和视角的夹角
            float ndv = max(0, dot(normalDir, viewDir));
            
            //控制漫反射系数--由此可见漫反射系数和视角没有关系，取决于发现和灯光的夹角
			//t=(2*nd1-_RampThreshold)/2*nd1 ==>1-_RampThreshold/(2*nd1) 由此可以推出nd1越大，系数越大。但是
			//当_RampThreshold>(2*nd1)时，清除为0，当_RampThreshold<(2*nd1)时，呈平滑数据，但是这样做只能有一处
			//的明显分隔，我们要实现多层的阴影分割
            float diff = smoothstep(_RampThreshold - ndl, _RampThreshold + ndl, ndl);
			//取卡通次数的倒数，interval是干啥的？
            float interval = 1 / _ToonSteps;
            // float ramp = floor(diff * _ToonSteps) / _ToonSteps;
			//等级--round四舍五入取整---这里的操作在做什么？上面我们知道diff是在低于阀值的时候为0，高于阀值的时候是平滑数据
			//但是我们希望在高于的时候再次做划分，diff是0-1取值，假设_ToonSteps为3的时候，当diff为0-0.16的时候，level为0；当
			//diff为0.17-0.5时，level=1/3;当diff为0.5-0.83时，level=2/3；当diff为0.84-1时，level=1;这个手法不得不说太赞了，
			//高光做块状的同时还能将过度做分级处理
            float level = round(diff * _ToonSteps) / _ToonSteps;
            float ramp ;
			//接下来就赞了，对系数做平滑处理
            if (_RampSmooth == 1)
            {
				//差值线性平滑--->>linearstep(level - interval * 0.5, level + interval * 0.5, diff)
				//
                ramp = interval * linearstep(level - _RampSmooth * interval * 0.5, level + _RampSmooth * interval * 0.5, diff) + level - interval;
            }
            else
            {
				//（3-2*t）*t*t方式平滑
                ramp = interval * smoothstep(level - _RampSmooth * interval * 0.5, level + _RampSmooth * interval * 0.5, diff) + level - interval;
            }
            ramp = max(0, ramp);
            ramp *= atten;
            
            _SColor = lerp(_HColor, _SColor, _SColor.a);
            float3 rampColor = lerp(_SColor.rgb, _HColor.rgb, ramp);
            
            // specular
            float spec = pow(ndh, s.Specular * 128.0) * s.Gloss;
            spec *= atten;
            spec = smoothstep(0.5 - _SpecSmooth * 0.5, 0.5 + _SpecSmooth * 0.5, spec);
            
            // rim
            float rim = (1.0 - ndv) * ndl;
            rim *= atten;
            rim = smoothstep(_RimThreshold - _RimSmooth * 0.5, _RimThreshold + _RimSmooth * 0.5, rim);
            
            fixed3 lightColor = _LightColor0.rgb;
            
            fixed4 color;
            fixed3 diffuse = s.Albedo * lightColor * rampColor;
            fixed3 specular = _SpecColor.rgb * lightColor * spec;
            fixed3 rimColor = _RimColor.rgb * lightColor * _RimColor.a * rim;
            
            color.rgb = diffuse + specular + rimColor;
            color.a = s.Alpha;
			return  color;
        }
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 mainTex = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = mainTex.rgb * _Color.rgb;
            
            o.Alpha = mainTex.a * _Color.a;
            
            o.Specular = _Shininess;
            o.Gloss = mainTex.a;
        }
        
        ENDCG
        
    }
    FallBack "Diffuse"
}
