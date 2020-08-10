Shader "Yu/ToonTest"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Main Texture", 2D) = "white" {}
		// Ambient light is applied uniformly to all surfaces on the object.
		[HDR]
		_AmbientColor("Ambient Color", Color) = (0.4,0.4,0.4,1)
		[HDR]
		_SpecularColor("Specular Color", Color) = (0.9,0.9,0.9,1)
		// Controls the size of the specular reflection.
		_Glossiness("Glossiness", Float) = 32

		_Smooth("_Smooth",  Range(0, 0.2)) = 0.1

		_LowSmooth("_LowSmooth",  Range(0, 1)) = 0
		_MaxSmooth("_MaxSmooth",  Range(0, 1)) = 0.01
		[HDR]
		_RimColor("Rim Color", Color) = (1,1,1,1)
		_RimAmount("Rim Amount", Range(0, 1)) = 0.716
		// Control how smoothly the rim blends when approaching unlit
		// parts of the surface.
		_RimThreshold("Rim Threshold", Range(0, 1)) = 0.1		
	}
	SubShader
	{
		Pass
		{
			// Setup our pass to use Forward rendering, and only receive
			// data on the main directional light and ambient light.
			Tags
			{
				"LightMode" = "ForwardBase"
				"PassFlags" = "OnlyDirectional"
			}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// Compile multiple versions of this shader depending on lighting settings.
			#pragma multi_compile_fwdbase
			
			#include "UnityCG.cginc"
			// Files below include macros and functions to assist
			// with lighting and shadows.
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

			struct appdata
			{
				float4 vertex : POSITION;				
				float4 uv : TEXCOORD0;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float3 worldNormal : NORMAL;
				float2 uv : TEXCOORD0;
				float3 viewDir : TEXCOORD1;	
				// Macro found in Autolight.cginc. Declares a vector4
				// into the TEXCOORD2 semantic with varying precision 
				// depending on platform target.
				//SHADOW_COORDS(2)
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Smooth;
			float _LowSmooth;
			float _MaxSmooth;
			v2f vert (appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(float4(v.vertex.xyz,1) );
				o.worldNormal = UnityObjectToWorldNormal(v.normal);		
				o.viewDir = WorldSpaceViewDir(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				// Defined in Autolight.cginc. Assigns the above shadow coordinate
				// by transforming the vertex from world space to shadow-map space.
				//TRANSFER_SHADOW(o)
				
				//对xyz进行缩放
				float4 u_xlat0 = v.vertex.xyzz * float4(0.5, 0.5, 0.5, 0.25);
				//
				float4 u_xlat4 = u_xlat0.w + u_xlat0.y;
				//x位置的平方得一半--u_xlat12=in_POSITION0.x*in_POSITION0.x*0.5
				float4 u_xlat12 = u_xlat0.x * v.vertex.x;
				//-uv的x为：in_POSITION0.z*in_POSITION0.z*0.5*0.5+in_POSITION0.x*0.5
				//o.uv.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
				//o.uv.y = u_xlat12 * 0.25 + u_xlat4;
				//o.uv = v.vertex.xy;

				
				return o;
			}
			
			float4 _Color;

			float4 _AmbientColor;

			float4 _SpecularColor;
			float _Glossiness;		

			float4 _RimColor;
			float _RimAmount;
			float _RimThreshold;	
			float4x4 _TempLightPos;

			float4 frag (v2f i) : SV_Target
			{
				//return float4(i.uv.x>0.5?1:0,0,0,1);//i.uv.y
				float3 normal = normalize(i.worldNormal);
				float3 viewDir = normalize(i.viewDir);
				
				//将灯光进行差值调整
				float3 lerpWorldPos = mul(_TempLightPos, _WorldSpaceLightPos0);
				//_WorldSpaceLightPos0世界空间灯光的位置。--平行光的话就是方向来了
				//计算法线与光线方向的夹角，注意方向
				float NdotL = dot(lerpWorldPos, normal);
				//卡通渲染，灯光交接没有过度。要么是阴影，要么不是。
				float lightIntensity = smoothstep(0, _Smooth, NdotL);
				// Multiply by the main directional light's intensity and color.
				float4 light = lightIntensity * _LightColor0;

				// 计算半角向量
				float3 halfVector = normalize(lerpWorldPos + viewDir);
				float NdotH = dot(normal, halfVector);
				// Multiply _Glossiness by itself to allow artist to use smaller
				// glossiness values in the inspector.
				//NdotH * lightIntensity--阴影部分没有高光--这个计算没有必要，可以使用smoothsetp来代替
				//float specularIntensity = pow(NdotH * lightIntensity, _Glossiness * _Glossiness);
				float specularIntensitySmooth = smoothstep(_LowSmooth, _MaxSmooth, NdotH * lightIntensity);
				float4 specular = specularIntensitySmooth * _SpecularColor;				

				//return specular;

				float4 sampleColor = tex2D(_MainTex, i.uv);

				////	return sampleColor;
				return (light + _AmbientColor+ specular) * sampleColor;

			//	// Calculate rim lighting.
			//	float rimDot = 1 - dot(viewDir, normal);
			//	// We only want rim to appear on the lit side of the surface,
			//	// so multiply it by NdotL, raised to a power to smoothly blend it.
			//	float rimIntensity = rimDot * pow(NdotL, _RimThreshold);
			//	rimIntensity = smoothstep(_RimAmount - 0.01, _RimAmount + 0.01, rimIntensity);
			//	float4 rim = rimIntensity * _RimColor;

			//	float4 sampleColor = tex2D(_MainTex, i.uv);

			////	return sampleColor;
			//	return (light + _AmbientColor + specular + rim) * sampleColor;
			}
			ENDCG
		}

		// Shadow casting support.
        UsePass "Legacy Shaders/VertexLit/SHADOWCASTER"
	}
}