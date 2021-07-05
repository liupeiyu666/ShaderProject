Shader "SG/SG_Character"
{
    Properties
    {
        _Color ("整体颜色Color", Color) = (1, 1, 1, 1)					// 主颜色
        _MainTex ("固有色贴图albedo(RGBA)", 2D) = "white" {}				// 固有色贴图
		_DiffuseIntensity("固有色部分强度DiffuseIntensity", float) = 1

        _NormalMap("法线贴图Normal Map",2D) = "bump"{}					// 法线贴图

		_Mask("遮罩图(G-阴影 B-高光)", 2D) = "black" {}

		_DarkSoft("阴影交界线软硬", Range(0,0.2)) = 0
		_ToonDrakColor("卡渲阴影颜色ToonDrakColor", color) = (1,1,1,1)		//卡通阴影颜色
		[Toggle]_DarkSwitch("是否两层阴影？", float) = 0
		_FirstDarkWidth("一层阴影宽度FirstDrak Width", Range(0, 1)) = 0		//第一层阴影的宽度
		_SecondDarkWidth("二层阴影宽度_SecondDarkWidth", Range(0, 1)) = 0		//第一层阴影的宽度
        _ThirdShadowThreshold("三层阴影宽度ThirdThreshold", Range(0, 1)) = 0.5		//第二层阴影颜色
		_FourShadowThreshold("四层阴影宽度FourdShadowThreshold", Range(0, 1)) = 0.6	//第二层阴影颜色
		
		_FirstDarkColor("一层阴影颜色FirstDrak Color", color) = (1,1,1,1)		//第一层阴影颜色
		_SecondDarkColor("二层阴影颜色SecondDrad Color", color) = (1,1,1,1)		//第二层阴影颜色
		_ThirdDarkColor("三层阴影颜色ThirdDarkColor", color) = (1,1,1,1)		//第二层阴影颜色
		_FourDarkColor("四层阴影颜色ThirdDarkColor", color) = (1,1,1,1)		//第二层阴影颜色

		[HDR]_Specular("高光颜色", Color) = (0,0,0,0)
		_Gloss("高光", float) = 0

        _EmissionIntensity("自发光强度Emission Intensity",float) = 0				// 自发光强度
		[HDR]_EmissionColor("自发光颜色Emission Color", Color) = (1,1,1,1)						// 自发光颜色

		[HDR]_RimColor("边缘高光颜色Rim Color", Color) = (1,1,1,1)
		_RimAmount("边缘高光范围Rim Amount", Range(0, 1)) = 0.9
		_RimThreshold("边缘高光次幂Rim Threshold", Range(0, 1)) = 0.1

		_OutlineWidth("描边宽度Outline Width", float) = 0
		_OutlineColor("描边颜色Outline Color", Color) = (1,1,1,1)

		[Toggle]_RampSwitch("是否使用上下渐变？", float) = 0
		_Up("上部分固有色强度Up", float) = 1
		_Down("下部分固有色强度Down", Range(0.5, 2)) = 1
		_RampThreshold("渐变过渡区域Ramp Threshold", float) = 0.5

		_CharacterAlpha("透明度", Range(0, 1)) = 1
		[Toggle] _Skinned ("Skinned", Float) = 0

		_ShadowOffset("阴影增量",vector)=(0,0.5,0,0.5)

    }

    SubShader
    {
		Tags { "Queue"="Geometry" "IgnoreProjector"="True" "RenderType"="Opaque" }
		//Tags { "Queue"="Geometry" "IgnoreProjector" = "False" "RenderType" = "Opaque" "NArtShadow" = "True"}
		
        Pass
        {
            Tags { "LightMode" = "ForwardBase" }
			Cull Off //不剔除 不然会出现角色靠近摄像头透明后有色块出现
			Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#pragma multi_compile_fwdbase

            #include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

			struct a2v
			{
				float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
			};

            struct v2f
            {
                float4 pos		: SV_POSITION;	// 裁剪空间位置输出
                float2 uv		: TEXCOORD0;	// 贴图UV
				float3 worldPos : TEXCOORD1;	// 世界坐标
                float4 TW0		: TEXCOORD2;	// TNB矩阵0
                float4 TW1		: TEXCOORD3;	// TNB矩阵1
                float4 TW2		: TEXCOORD4;	// TNB矩阵2

				float4 startPos : TEXCOORD5;
				UNITY_SHADOW_COORDS(6)
            };

            float4 _Color;

            sampler2D _MainTex;
            float4 _MainTex_ST;
			float _DiffuseIntensity;
			sampler2D _NormalMap;
			sampler2D _RampTex;
            float _EmissionIntensity;
            float4 _EmissionColor;

			float _DarkSoft;
			sampler2D _Mask;
			float3 _ToonDrakColor;
			float _DarkSwitch;
			float _FirstDarkWidth;
			float4 _FirstDarkColor;
			float _SecondDarkWidth;
			float4 _SecondDarkColor;

			float _ThirdShadowThreshold;
			float _FourShadowThreshold;
			float4 _ThirdDarkColor;
			float4 _FourDarkColor;

			float3 _Specular;
			float _Gloss;

			float4 _RimColor;
			float _RimAmount;
			float _RimThreshold;

			float _RampSwitch;
			float _Up;
			float _Down;
			float _RampThreshold;

			float _CharacterAlpha;
			float4 _ShadowOffset;

            v2f vert (a2v v)
            {
                v2f o = (v2f)0;
				float4 tempVer = v.vertex;
				float3 worldOrigin = float3(unity_ObjectToWorld[0].w, unity_ObjectToWorld[1].w, unity_ObjectToWorld[2].w);
				worldOrigin = worldOrigin + _ShadowOffset.xyz + UnityWorldSpaceLightDir(worldOrigin) *_ShadowOffset.w;
				v.vertex = mul(unity_WorldToObject, float4(worldOrigin, 1));
				TRANSFER_SHADOW(o);
				v.vertex = tempVer;
                o.uv  = TRANSFORM_TEX(v.uv, _MainTex);				
				o.pos = UnityObjectToClipPos(v.vertex);		

				o.worldPos = mul(unity_ObjectToWorld, v.vertex);			// 世界空间坐标
				o.startPos = mul(unity_ObjectToWorld,float4(0,0,0,1));		// 物体的世界坐标
				float3 worldNormal = UnityObjectToWorldNormal(v.normal);	// 世界空间法线
				float3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz); // 世界空间切线
				float tangentSign = v.tangent.w * unity_WorldTransformParams.w; 
				float3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;

                o.TW0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, o.worldPos.x);
				o.TW1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, o.worldPos.y);
				o.TW2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, o.worldPos.z);

                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
			// 数据准备
				float3 normalTex = UnpackNormal(tex2D(_NormalMap, i.uv));	// 使用法线的采样方式对法线贴图进行采样。
                // 法线 -> 切线空间转世界空间
                float3 worldNormal = normalize(float3(dot(i.TW0, normalTex), dot(i.TW1, normalTex), dot(i.TW2, normalTex)));

                float3 lightDir = normalize(UnityWorldSpaceLightDir(i.worldPos));	// 灯光向量
                float3 viewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));		// 视线向量
				float3 halfDir = normalize(lightDir + viewDir);						// 半角向量
				float3 worldRef = reflect(-viewDir, worldNormal);					// 计算反射方向
				
				float NdotV = abs(dot(worldNormal, viewDir));		 //世界法线点乘视线向量
				float NdotL = saturate(dot(worldNormal, lightDir));  //世界法线点乘世界灯光
				float NdotH = saturate(dot(worldNormal, halfDir));   //世界法线点乘半角向量
				
				float4 albedo = tex2D(_MainTex, i.uv);

				float emission = albedo.a; //自发光

				float3 MaskTex = tex2D(_Mask, i.uv);
				float shadowMask = MaskTex.g;	//阴影遮罩图
				float specularMask = MaskTex.b; //高光遮罩图
				float specularRadio = MaskTex.r;//高光系数

				fixed3 lightColor = saturate(_LightColor0.rgb);

			//自发光
				float3 emissionCol = _EmissionIntensity * emission *_EmissionColor.rgb;
			
			//边缘光
				float4 rimDot = 1 - NdotV;
				float rimIntensity =  rimDot * pow(NdotL, _RimThreshold);
				rimIntensity = smoothstep(_RimAmount - 0.01, _RimAmount + 0.01, rimIntensity);
				float4 rim = rimIntensity * _RimColor;

			//上下渐变
				float dis = length(i.worldPos - i.startPos + float4(0,1,0,0)); //点到模型原点距离
				float args = saturate(dis - _RampThreshold);

			//球谐
				float3 sh = saturate( max( float3(0.5,0.5,0.5), ShadeSH9(half4(float3(0,0,0), 1.0)) ) );

			//接受的阴影
				float shadow = SHADOW_ATTENUATION(i);
				shadow = smoothstep(0.1,0.3,shadow);

			//固有色
				float4 albedoToon = albedo * _Color;
				//fixed3 ambientToon = UNITY_LIGHTMODEL_AMBIENT.xyz * albedoToon;
				
			//阴影
				//shadowMask  0 一直为暗部 0.5 随NdotL 0-0.5 越小越容易成为阴影
				//NdotL = lerp(0, NdotL, saturate(shadowMask*2));
				//--Fixed LL
				NdotL = (NdotL + shadowMask)*0.5;
				float shadowNdotL = NdotL * shadow;
				

				//**************************************************************************************************
				//************************一层和二层只有阴影系数[1-0.3] 三层[0.3-0.1] 四层[0.1-0]
				//***********************1-4层的阀值应该是越来越大的

				//一层阴影算法
				fixed firstShadowRadio =1- smoothstep(_FirstDarkWidth, _FirstDarkWidth+ _DarkSoft, shadowNdotL);
				//两层阴影算法
				float secondShadowRadio = 1-smoothstep(_SecondDarkWidth, _SecondDarkWidth + _DarkSoft, shadowNdotL);				
				//--三层颜色
				float thirdShadowRadio = 1.0f - smoothstep(_ThirdShadowThreshold-0.05, _ThirdShadowThreshold, shadowNdotL);
				//--四层颜色
				float fourShadowRadio = 1.0f - smoothstep(_FourShadowThreshold-0.05, _FourShadowThreshold , shadowNdotL);

				float3 fourShadowColor = fourShadowRadio * _FourDarkColor + (1.0f - fourShadowRadio) * _ThirdDarkColor;
				float3 thirdShadowColor = thirdShadowRadio * _ThirdDarkColor + (1.0f - thirdShadowRadio)*_SecondDarkColor;
				//float3 secondShadowColor = secondShadowRadio * _SecondDarkColor + (1.0f - secondShadowRadio) * _FirstDarkColor;
				float3 firstShadowColor = secondShadowRadio * _SecondDarkColor +(firstShadowRadio- secondShadowRadio) * _FirstDarkColor+(1- firstShadowRadio)*float3(1,1,1);
				
				//****************通过shadowMask对3,4层进行颜色遮罩显示
				//--混色--规定好阴影遮罩图中对应的系数比如1-0.3为二层阴影  0.3-0.1为三层 0.1-0为四层
				float mixThird = 1 - step(0.3, shadowMask);
				float mixFour = 1 - step(0.1, shadowMask);
				float realThird = mixThird - mixFour;

				float3 diffuseColor = (1 - mixThird)*firstShadowColor + realThird * thirdShadowColor + mixFour * fourShadowColor;

				//
				//乘上阴影
				//fixed3 diffuseToon = albedoToon.rgb * lerp(brightAndDark, diffuseColor, _DarkSwitch);
				fixed3 diffuseToon = diffuseColor * albedoToon.rgb;
				return float4(diffuseToon, 1);
			//高光
				fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(max(0,NdotH), _Gloss);
				//--Fixed  Lpy 修正高光通过遮罩和系数控制
				specular= smoothstep(0.9f - specularMask, 1.0f - specularMask, specular);
				specular *= specularRadio; //遮罩控制区域
				return float4(diffuseToon + specular, 1);//
			//漫反射
				float ToonInte = lerp(_DiffuseIntensity, lerp(_DiffuseIntensity * _Down, _DiffuseIntensity*_Up, args), _RampSwitch);
				fixed3 finishColorToon =  diffuseToon * ToonInte * lightColor.rgb;// + ambientToon;
			
				float3 finishColor = finishColorToon + emissionCol + rim.rgb + specular;
				finishColor *= sh;

				return float4(finishColor, albedo.a * _CharacterAlpha);
            }
            ENDCG
        }
		
		//向其他物体投影pass
		Pass{
            Name "ShadowCaster"
            Tags{"LightMode" = "ShadowCaster"}
			
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #include "UnityCG.cginc" 
            struct v2f
            {
                V2F_SHADOW_CASTER;
            }; 
            v2f vert( appdata_base  v)
            {
                v2f o;
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
                return o;
            }
            float4  frag(v2f i):SV_Target
            {
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
		
		//平均法线描边
		Pass
		{
			Cull Front

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			#pragma shader_feature _SKINNED_ON

			half _OutlineWidth;
			half4 _OutlineColor;

			struct a2v
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
				float3 vertexColor : COLOR;
			};

			struct v2f
			{
				float4 pos:SV_POSITION;
				float4 vertexColor : COLOR;
				float3 normal:TEXCOORD0;
				float3 viewDir:TEXCOORD1;
			};

			float4 vert(float4 vertex : POSITION, float3 uv1 : TEXCOORD1, float3 normal : NORMAL, float4 tangent : TANGENT ,float4 vertexColor : COLOR) : SV_POSITION
			{
				// 把uv.zw float2[0-1]解码成float3[-1,1]
                float3 decoded = uv1 * 2 - 1;

				// 计算副切线 tangent.w代表朝向，跟DCC有关（DCC是数字资产工具的意思，建模软件）
				float3 binormal = cross(normal, tangent.xyz) * tangent.w;

				// Tangent -> Object
				decoded = decoded.x * normal + decoded.y * tangent.xyz + decoded.z * binormal;

				//用于蒙皮前描边效果测试用
				#if _SKINNED_ON
					decoded = uv1 * 2 - 1;
				#endif
				
				float y_over_x_2 = (1/ unity_CameraProjection[1].y);
				float tmpvar_3 = min(abs(y_over_x_2), 1.0) / max(abs(y_over_x_2), 1.0);
				float tmpvar_4 = tmpvar_3 * tmpvar_3;
				tmpvar_4 = ((((((((((-0.01213232 * tmpvar_4 + 0.05368138) * tmpvar_4) - 0.1173503)
							* tmpvar_4) + 0.1938925) * tmpvar_4) - 0.3326756)
							* tmpvar_4) + 0.9999793) * tmpvar_3);
				tmpvar_4 = (tmpvar_4 + (float((abs(y_over_x_2) > 1.0)) * ((tmpvar_4 * -2.0) + 1.570796)));
				float4 tmpvar_5 = float4(vertex.xyz,1);

				float3 tmpvar_6 = mul(unity_ObjectToWorld, tmpvar_5).xyz;
				float3 tmpvar_8 = (_WorldSpaceCameraPos - tmpvar_6);
				float cameraDistance_1 = sqrt(dot(tmpvar_8, tmpvar_8));
				float tmpvar_10;
				tmpvar_10 = pow(max(0.004, (cameraDistance_1 - 0.15)), 0.5);
				float tmpvar_11;
				tmpvar_11 = max(_OutlineWidth, 0.004);
				float4 tmpvar_12;
				tmpvar_12.w = 1.0;
				tmpvar_12.xyz = (tmpvar_6 + (((((normalize(UnityObjectToWorldNormal(decoded)) * 0.002 * vertexColor.g)) * tmpvar_10)*
								pow((1.0 - ((60.0 -(114.5916 * (tmpvar_4 * sign(y_over_x_2)))) / 60.0)), 0.5)) * tmpvar_11));
				float4 clipPosition = mul(unity_MatrixVP , tmpvar_12);
				return clipPosition;
			}

			float4 frag(float4 pos : SV_POSITION) : SV_TARGET
			{
				return _OutlineColor;
			}

			ENDCG
		}
    }
	FallBack "Transparent/Cutout/VertexLit"
}
