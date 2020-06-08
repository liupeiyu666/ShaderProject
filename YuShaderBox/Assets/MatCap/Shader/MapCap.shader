Shader "TJia/Matcap_Photorealistic" {
	Properties{

		_Color("Main Color", Color) = (1,1,1,1)
		_MetalRef("MetalRef", Range(0,1)) = 0

		_MainTex("Main Tex", 2D) = "white" {}
		_BumpMap("Bumpmap (RGB)", 2D) = "bump" {}
		_BumpValue("BumpValue", Range(0,3)) = 1

		_MatCap("MatCapDiffuse (RGB)", 2D) = "white" {}
		_MatCapValue("MatcapValue", Range(0,3)) = 1
		_MatCapSpec("MatCapSpec (RGB)", 2D) = "black" {}
		_SpecValue("SpecValue", Range(0,3)) = 0

		_RoughnessTex("Roughness texture", 2D) = "grey" {}
		_Roughness("Roughness", float) = 0

		_DetailGreyTex("DetailGreyTex",2D) = "grey" {}
		_DetailValue("DetailValue", Range(0,3)) = 1
		_DetailBumpTex("DetailBump",2D) = "bump" {}
		_DetailBumpValue("DetailBumpValue", Range(0,3)) = 1

		_ShadowColor("Shadow Color", Color) = (0,0,0,1)
		_ShadowMin("Shadow Range", Range(0,1)) = 0
		_ShadowRange("Soft Shadow", Range(0.001,0.999)) = 0.2
		_Shadow("Shadow Value", Range(0,1)) = 1

		_RotDiff("Rot Diff", Range(0, 6.28)) = 0
		_RotSpec("Rot Spec", Range(0, 6.28)) = 0
		_RotShadow("Shadow Rot",Range(0,6.28)) = 0
	}

		Subshader{
			Tags { "RenderType" = "Opaque" }
			Fog { Color[_AddFog] }

			Pass {
				Name "BASE"
				Tags { "LightMode" = "Always" }

				CGPROGRAM
					#pragma vertex vert
					#pragma fragment frag
					/*#pragma fragmentoption ARB_fog_exp2
					#pragma fragmentoption ARB_precision_hint_fastest*/
					#include "UnityCG.cginc"

			//#define _Shadow 1
			//#define _ShadowRange 0.25

			struct v2f {
				float4 pos : SV_POSITION;
				float4	uv : TEXCOORD0;
				float3	TtoV0 : TEXCOORD1;
				float3	TtoV1 : TEXCOORD2;
				float3 visual : TEXCORRD3;
				float4	duv : TEXCOORD4;
			};

			uniform float4 _BumpMap_ST, _DetailGreyTex_ST, _DetailBumpTex_ST;
			uniform float4 _MainTex_ST;

			v2f vert(appdata_tan v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv.xy = TRANSFORM_TEX(v.texcoord,_MainTex);
				o.uv.zw = TRANSFORM_TEX(v.texcoord,_BumpMap);

				o.duv.xy = TRANSFORM_TEX(v.texcoord, _DetailGreyTex);
				o.duv.zw = TRANSFORM_TEX(v.texcoord, _DetailBumpTex);


				TANGENT_SPACE_ROTATION;
				o.TtoV0 = normalize(mul(rotation, UNITY_MATRIX_IT_MV[0].xyz));
				o.TtoV1 = normalize(mul(rotation, UNITY_MATRIX_IT_MV[1].xyz));

				o.visual = normalize(mul(rotation, -ObjSpaceViewDir(v.vertex)));

				return o;
			}

			uniform fixed4 _Color, _ShadowColor;
			uniform sampler2D _BumpMap, _DetailGreyTex, _DetailBumpTex;
			uniform sampler2D _MatCap;
			uniform sampler2D _MainTex;
			uniform sampler2D _MatCapSpec;
			uniform fixed _SpecValue;
			uniform fixed _BumpValue;
			uniform sampler2D _RoughnessTex;
			uniform fixed _Roughness;
			uniform fixed _MatCapValue, _DetailValue, _DetailBumpValue;
			uniform float _ShadowRange, _Shadow;

			uniform fixed _ShadowMin, _RotShadow, _RotDiff, _RotSpec, _MetalRef;

			float3 lum(fixed3 c)
			{
				return c.r * 0.2 + c.g * 0.7 + c.b * 0.1;
			}

			float4 frag(v2f i) : COLOR
			{
				fixed4 c = tex2D(_MainTex, i.uv.xy);
				float3 normal = UnpackNormal(tex2D(_BumpMap, i.uv.zw));
				normal.xy *= _BumpValue;
				normal = normalize(normal);

				float3 correctiveNormal = normalize(reflect(i.visual, normal));
				normal = lerp(normal, correctiveNormal, _MetalRef);

				float3 dnormal = UnpackNormal(tex2D(_DetailBumpTex, i.duv.zw));
				dnormal.xy *= _DetailBumpValue;
				normal = normalize(float3(normal.xy + dnormal.xy,normal.z));

				half2 vn;
				vn.x = dot(i.TtoV0, normal);
				vn.y = dot(i.TtoV1, normal);

				fixed2x2 rotDiff =
				{
					cos(_RotDiff),-sin(_RotDiff),
					sin(_RotDiff), cos(_RotDiff)
				};
				half2 vnd = mul(rotDiff, vn);

				fixed4 matcapLookup = saturate(tex2D(_MatCap, vnd * 0.495 + 0.505) * _Color * _MatCapValue);
				matcapLookup.a = 1;

				float roughness = tex2D(_RoughnessTex, i.uv.xy).r;
				fixed2x2 rotSpec =
				{
					cos(_RotSpec),-sin(_RotSpec),
					sin(_RotSpec), cos(_RotSpec)
				};
				half2 vnsp = mul(rotSpec, vn);
				fixed4 matcapSpec = tex2D(_MatCapSpec, vnsp*0.495 + 0.505);
				matcapSpec = lerp(matcapSpec,0,lerp(0,roughness, _Roughness));
				matcapSpec.a = 1;

				fixed2x2 rot =
				{
					-cos(_RotShadow),  sin(_RotShadow),
					-sin(_RotShadow), -cos(_RotShadow)
				};

				half2 vns = mul(rot, vn);

				fixed4 shadow = tex2D(_MatCap, vns*0.495 + 0.505);
				shadow.rgb = saturate((1 - lum(shadow.rgb) - _ShadowMin) / _ShadowRange);
				shadow.rgb = lerp(1, _ShadowColor.rgb, 1 - shadow.rgb);

				fixed4 diff = c * matcapLookup;

				fixed4 finalColor = clamp(diff + matcapSpec * _SpecValue, 0, 1);

				finalColor *= 2 * lerp(fixed4(0.5, 0.5, 0.5, 1), tex2D(_DetailGreyTex, i.duv.xy), _DetailValue);

				finalColor = finalColor * lerp(1, shadow, _Shadow);// * step(0.00001, _ShadowMin));

				finalColor.a = 1.0;

				return finalColor;
			}
		ENDCG
	}
		}
			Fallback "VertexLit"
}