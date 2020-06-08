Shader "SSS/Skin_Pre"
{
	Properties
	{
		_Color("Color", Color) = (0,0,0,1)
		_MainTex("MainTexture", 2D) = "white" {}
		_MainNormalTex("NormalTex", 2D) = "white" {}
		_SmoothTex("SmoothTex", 2D) = "white" {}
		_ScatteringTex("ScatteringTex", 2D) = "white" {}
		_Smooth("Smooth",Range(0,1)) = 1
		_SSSLUT("SSSLUT", 2D) = "white" {}
		_KelemenLUT("KelemenLUT", 2D) = "white" {}
		_CurveFactor("CurveFactor",Range(0,5)) = 1
		[KeywordEnum(GGX,Kelemen)] Spec("Specular Mode",Float) = 1
		_SpecularColor("SpecularColor", Color) = (0,0,0,1)
		_SpecularScale("SpecularScale", Range(0,20)) = 1
		_Distortion("Distortion", Float) = 1
		_ScatteringPow("ScatteringPow", Float) = 1
		_ScatteringScale("ScatteringScale", Float) = 1
		_ScatteringColor("ScatteringColorColor", Color) = (0,0,0,1)
	}

		SubShader
		{
			Tags{"RenderType" = "Opaque"}
			Pass
			{
				Tags { "LightMode" = "ForwardBase"}
				CGPROGRAM
				#pragma target 3.0
				#pragma vertex vert_new
				#pragma fragment frag_new
				#pragma multi_compile_fwdbase
				#pragma multi_compile SPEC_GGX SPEC_KELEMEN

				#include "UnityStandardBRDF.cginc"
				#include "AutoLight.cginc"		

				fixed4 _Color;
				sampler2D _MainTex;
				float4 _MainTex_ST;
				sampler2D _MainNormalTex;
				float4 _MainNormalTex_ST;
				sampler2D _SmoothTex;
				sampler2D _SSSLUT;
				float _Smooth;
				sampler2D _KelemenLUT;
				float _SpecularScale;
				fixed4 _SpecularColor;
				float _CurveFactor;
				float _Distortion;
				sampler2D _ScatteringTex;
				float _ScatteringPow;
				float _ScatteringScale;
				fixed4 _ScatteringColor;

				struct v2f_new
				{
					float4 pos : SV_POSITION;
					float4 uv : TEXCOORD0;
					float4 T2W0 :TEXCOORD1;
					float4 T2W1 :TEXCOORD2;
					float4 T2W2 :TEXCOORD3;
					LIGHTING_COORDS(4, 5)
				};

				v2f_new vert_new(appdata_full v)
				{
					v2f_new o;
					o.pos = UnityObjectToClipPos(v.vertex);
					o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
					o.uv.zw = TRANSFORM_TEX(v.texcoord,_MainNormalTex);

					float3 worldPos = mul(unity_ObjectToWorld,v.vertex);
					float3 worldNormal = UnityObjectToWorldNormal(v.normal);
					float3 worldTangent = UnityObjectToWorldDir(v.tangent);
					float3 worldBitangent = cross(worldNormal ,worldTangent) * v.tangent.w;

					//tangent->world normal translate matrix
					o.T2W0 = float4 (worldTangent.x,worldBitangent.x,worldNormal.x,worldPos.x);
					o.T2W1 = float4 (worldTangent.y,worldBitangent.y,worldNormal.y,worldPos.y);
					o.T2W2 = float4 (worldTangent.z,worldBitangent.z,worldNormal.z,worldPos.z);

					TRANSFER_VERTEX_TO_FRAGMENT(o);

					return o;
				}


				half3 BentNormalsDiffuseLighting(float3 normal, float3 L, float Curvature, float nl)
				{
					float NdotLBlurredUnclamped = dot(normal, L);
					return tex2Dlod(_SSSLUT, float4((NdotLBlurredUnclamped * 0.5 + 0.5), Curvature, 0, 0));
				}

				float fresnelReflectance(float3 H, float3 V, float F0)
				{
					float base = 1.0 - dot(V, H);
					float exponential = pow(base, 5.0);
					return exponential + F0 * (1.0 - exponential);
				}

				half4 frag_new(v2f_new i) : SV_Target
				{
					//前项
					fixed4 ambient = UNITY_LIGHTMODEL_AMBIENT;//环境光
					fixed attenuation = LIGHT_ATTENUATION(i);//投影
					float4 albedo = tex2D(_MainTex,i.uv.xy);
					float3 lightColor = _LightColor0.rgb;
					float3 attenColor = attenuation * lightColor;
					float smoothness = tex2D(_SmoothTex, i.uv.xy).r * _Smooth;
					float perceptualRoughness = 1 - smoothness;
					float roughness = perceptualRoughness * perceptualRoughness;

					float3 worldPos = float3(i.T2W0.w,i.T2W1.w,i.T2W2.w);
					fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
					fixed3 viewDir = normalize(UnityWorldSpaceViewDir(worldPos));
					float3 halfVector = normalize(lightDir + viewDir);  //半角向量

					fixed4 tangentNormal = tex2D(_MainNormalTex,i.uv.zw);
					fixed3 bump = UnpackNormal(tangentNormal);
					fixed3 worldBump = normalize(half3(dot(i.T2W0.xyz,bump),
														dot(i.T2W1.xyz,bump),
														dot(i.T2W2.xyz,bump)));

					half3 ambient_contrib = ShadeSH9(float4(worldBump, 1));//采样Unity环境贴图

					fixed4 c = fixed4(0,0,0,1);

					//--------------------------------------------------------
					float NdotL = saturate(dot(worldBump, lightDir));
					float NdotV = saturate(dot(worldBump, viewDir));
					float NdotH = saturate(dot(worldBump, halfVector));
					float LdotH = saturate(dot(lightDir, halfVector));
					//curvature
					float deltaWorldNormal = length(fwidth(worldBump));
					float deltaWorldPos = length(fwidth(worldPos));
					float curvature = (deltaWorldNormal / deltaWorldPos) * _CurveFactor;

					//diffuse
					float3 directDiffuse = BentNormalsDiffuseLighting(worldBump, lightDir, curvature, NdotL);
					float3 indirectDiffuse = max(half3(0, 0, 0), albedo.rgb * 0.03 + ambient_contrib);
					float3 diffuseColor = (_Color.rgb * albedo.rgb);
					float3 diffuse = (directDiffuse * attenColor + indirectDiffuse) * diffuseColor;

					//specular
					#if SPEC_KELEMEN
					float3 kelemen = tex2D(_KelemenLUT, float2(NdotH, smoothness));
					float PH = pow(2.0 * kelemen, 10.0);
					fixed F = fresnelReflectance(halfVector, viewDir, 0.028);
					half3 specularColor = max(PH * F / dot(halfVector, halfVector), 0);
					#elif SPEC_GGX
					float alpha = roughness;
					float G_L = NdotL + sqrt((NdotL - NdotL * alpha) * NdotL + alpha);
					float G_V = NdotV + sqrt((NdotV - NdotV * alpha) * NdotV + alpha);
					float G = G_L * G_V;
					float3 F0 = 0.028;
					fixed F = fresnelReflectance(halfVector, viewDir, 0.028);
					float alpha2 = alpha * alpha;
					float denominator = (NdotH * NdotH) * (alpha2 - 1) + 1;
					float D = alpha2 / (UNITY_PI * denominator * denominator);
					half3 specularColor = D * G * NdotL * F;
					#endif
					half3 specular = specularColor * FresnelTerm(_SpecularColor, LdotH) * _SpecularScale;

					//Scatterting
					float3 translightDir = lightDir + worldBump * _Distortion;
					float scattering = tex2D(_ScatteringTex, i.uv.xy).r;
					float transDot = pow(saturate(dot(-translightDir, viewDir)) * scattering * scattering, _ScatteringPow) * _ScatteringScale;
					float3 lightScattering = transDot * _ScatteringColor * attenColor;

					c.rgb += diffuse + specular + lightScattering;

					return c;
				}
				ENDCG
			}
		}
			FallBack "Diffuse"
}