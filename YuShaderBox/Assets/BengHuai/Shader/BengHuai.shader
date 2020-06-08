Shader "NPR/NPR_BengHuai3"
{
	Properties
	{
		[Header(Main Texture Setting)]
		[Space(5)]
		_MainTex("Texture", 2D) = "white" {}
		_Color("Tint Color", color) = (0.5, 0.5, 0.5, 1.0)
		[Space(30)]

		[Header(Outline Setting)]
		[Space(5)]
		_OutlineColor("Outline Color", color) = (0.0, 0.0, 0.0, 1.0)
		_OutlineSize("Outline Size", range(0.0, 1.0)) = 0.1
		_ZBias("Z Bias", range(-1.0, 1.0)) = 0.0
		[Space(30)]

		[Header(Bloom Setting)]
		[Space(5)]
		_BloomTex("Bloom Map", 2D) = "black" {}
		_UsingBloomMask("Use Bloom", int) = 1
		_BloomFactor("Bloom Factor", range(0.0, 2.0)) = 1.0
		_Emission("Emission", range(0.0, 2.0)) = 1.0
		_EmissionColor("Emission Color", color) = (1.0, 1.0, 1.0, 1.0)
		_EmissionBloomFactor("Emission Bloom Factor", range(0.0, 2.0)) = 1.0
		[Space(30)]

		[Header(Shadow Setting)]
		[Space(5)]
		_LightMap("LightMap", 2D) = "black" {}
		_LightArea("Light Area", range(0.0, 1.0)) = 1.0
		_SecondShadow("Second Shadow", range(0.0, 1.0)) = 0.5
		_FirstShadowMultColor("First Shadow Color", color) = (1.0, 1.0, 1.0, 1.0)
		_SecondShadowMultColor("Second Shadow Color", color) = (0.5, 0.5, 0.5, 0.5)
		[Space(30)]

		[Header(Specular Setting)]
		[Space(5)]
		_LightSpecColor("Specular Color", color) = (1.0, 1.0, 1.0, 1.0)
		_Shininess("Shininess", range(0.0, 20.0)) = 0.1
		_SpecMulti("Multiple Factor", range(0.1, 1.0)) = 1
	}
		SubShader
		{
			Tags{
				"RenderType" = "Opaque"
				"Queue" = "Geometry"
			}

		//	UsePass "NPR/NPR_CelShading/OUTLINE"

			Pass
			{
				NAME "BENGHUAI3"

				Tags{ "LightMode" = "ForwardBase" }

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_fwdbase

				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "AutoLight.cginc"

				uniform sampler2D _MainTex;
				uniform float4 _MainTex_ST;
				uniform float4 _Color;

				uniform sampler2D _BloomTex;
				uniform float4 _BloomTex_ST;
				uniform int _UsingBloomMask;
				uniform float _BloomFactor;
				uniform float3 _EmissionColor;
				uniform float _Emission;
				uniform float _EmissionBloomFactor;

				uniform sampler2D _LightMap;
				uniform float4 _LightMap_ST;

				uniform float _LightArea;
				uniform float _SecondShadow;
				uniform float3 _FirstShadowMultColor;
				uniform float3 _SecondShadowMultColor;

				uniform float3 _LightSpecColor;
				uniform float _Shininess;
				uniform float _SpecMulti;

				struct v2f
				{
					float4 pos : POSITION0;
					float4 color : COLOR0;
					float4 texcoord : TEXCOORD0;
					float3 worldPos : TEXCOORD1;
					float3 worldNormal : TEXCOORD2;
					float lambert : TEXCOORD3;
					SHADOW_COORDS(6)
				};

				v2f vert(appdata_full i)
				{
					v2f o;
					o.pos = UnityObjectToClipPos(i.vertex);
					o.color = i.color;
					o.worldPos = mul(unity_ObjectToWorld, i.vertex);
					o.worldNormal = UnityObjectToWorldNormal(i.normal);

					float3 worldLightDir = UnityWorldSpaceLightDir(o.worldPos);
					float lambert = dot(o.worldNormal, worldLightDir);
					o.lambert = lambert * 0.5f + 0.5f;

					o.texcoord.xy = TRANSFORM_TEX(i.texcoord, _MainTex);
					o.texcoord.zw = TRANSFORM_TEX(i.texcoord, _BloomTex);

					TRANSFER_SHADOW(o);

					return o;
				}

				fixed4 frag(v2f i) : COLOR
				{
					fixed4 diffuseTexColor = tex2D(_MainTex, i.texcoord.xy);
					if (diffuseTexColor.a < 0.01f)
						discard;

					fixed useBloom = (_UsingBloomMask == 0 ? 0.0f : 1.0f);
					if (useBloom != 0)
					{
						diffuseTexColor.a = tex2D(_BloomTex, i.texcoord.zw).r * diffuseTexColor.a;
					}

					//Compute Dither Alpha？

					UNITY_LIGHT_ATTENUATION(atten, i, i.worldPos);

					//Compute Diffuse Color —— Choose 
					fixed3 lightTexColor = tex2D(_LightMap, i.texcoord.xy).rgb;
					fixed3 secondShadowColor = diffuseTexColor.rgb * _SecondShadowMultColor.rgb;
					fixed3 firstShadowColor = diffuseTexColor.rgb * _FirstShadowMultColor.rgb;

					fixed w = lightTexColor.g * i.color.r;
					fixed t1 = (w + i.lambert * atten) * 0.5f;
					t1 = 1.0f - step(_SecondShadow, t1);
					fixed t2 = 1.0f - step(0.09f, w);

					fixed4 outColor;
					outColor.w = 1.0f;

					secondShadowColor = t1 * secondShadowColor + (1.0f - t1) * firstShadowColor;
					//outColor.rgb = secondShadowColor.rgb;

					fixed2 tt = w * fixed2(1.2f, 1.25f) + fixed2(-0.1f,-0.125f);
					t1 = 1.0f - step(0.5f, w);
					t1 = t1 * tt.x + (1.0f - t1) * tt.y;
					t1 = (t1 + i.lambert * atten) * 0.5f;

					t1 = 1.0f - step(_LightArea, t1);

					firstShadowColor = t1 * firstShadowColor + (1.0f - t1) * secondShadowColor;
					//outColor.rgb = firstShadowColor;

					fixed3 diffuseColor = t2 * secondShadowColor + (1.0f - t2) * firstShadowColor;
					//outColor.rgb = diffuseColor.rgb;
					//return outColor;
					//return float4(diffuseColor,1);
					//Compute Specular Color —————— Blinn-Phong Lighting model
					fixed3 worldViewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
					fixed3 worldHalfVec = normalize(worldViewDir + _WorldSpaceLightPos0.xyz);
					fixed3 worldNormal = normalize(i.worldNormal);

					fixed spec = pow(saturate(dot(worldNormal, worldHalfVec)), _Shininess);
					spec = step(1.0f - lightTexColor.b, spec);
					fixed3 specularColor = _LightSpecColor * _SpecMulti * lightTexColor.r * spec;

					fixed4 fragColor0;
					fragColor0.rgb = specularColor + diffuseColor;
					fragColor0.rgb *= _Color.rgb;
					fragColor0.a = _BloomFactor * _Color.a;
					//return fragColor0;

					fixed4 fragColor1;
					fragColor1.rgb = diffuseTexColor.rgb * _Emission.x;
					fragColor1.rgb = fragColor1.rgb * _EmissionColor.rgb - fragColor0.rgb;
					fragColor1.a = _EmissionBloomFactor - _BloomFactor * _Color.a;
					//return fragColor1 * diffuseTexColor.a;

					fixed4 fragColor = diffuseTexColor.a * fragColor1 + fragColor0;
					return fragColor;
				}
				ENDCG
			}
		}
			FallBack "Diffuse"
}