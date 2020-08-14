// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "LiYuan/Standard"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo", 2D) = "white" {}

		_Cutoff("Alpha Cutoff", Range(0.0, 1.0)) = 0.5

		_Glossiness("Smoothness", Range(0.0, 1.0)) = 0.5
		_GlossMapScale("Smoothness Scale", Range(0.0, 1.0)) = 1.0
		[Enum(Metallic Alpha,0,Albedo Alpha,1)] _SmoothnessTextureChannel("Smoothness texture channel", Float) = 0

		[Gamma] _Metallic("Metallic", Range(0.0, 1.0)) = 0.0
		_MetallicGlossMap("Metallic", 2D) = "white" {}

		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Glossy Reflections", Float) = 1.0

		_BumpScale("Scale", Float) = 1.0
		_BumpMap("Normal Map", 2D) = "bump" {}

		_Parallax("Height Scale", Range(0.005, 0.08)) = 0.02
		_ParallaxMap("Height Map", 2D) = "black" {}

		_OcclusionStrength("Strength", Range(0.0, 1.0)) = 1.0
		_OcclusionMap("Occlusion", 2D) = "white" {}

		_EmissionColor("Color", Color) = (0,0,0)
		_EmissionMap("Emission", 2D) = "white" {}

		_DetailMask("Detail Mask", 2D) = "white" {}

		_DetailAlbedoMap("Detail Albedo x2", 2D) = "grey" {}
		_DetailNormalMapScale("Scale", Float) = 1.0
		_DetailNormalMap("Normal Map", 2D) = "bump" {}

		_OutlineWidth("lineWidth", Float)=1.0
		_OutlineColor("lineColor", Color) = (0, 0, 0)

		[Enum(UV0,0,UV1,1)] _UVSec("UV Set for secondary textures", Float) = 0


			// Blending state
			[HideInInspector] _Mode("__mode", Float) = 0.0
			[HideInInspector] _SrcBlend("__src", Float) = 1.0
			[HideInInspector] _DstBlend("__dst", Float) = 0.0
			[HideInInspector] _ZWrite("__zw", Float) = 1.0
	}

		CGINCLUDE
#define UNITY_SETUP_BRDF_INPUT MetallicSetup
			ENDCG

			SubShader
		{
			Tags { "RenderType" = "Opaque" "PerformanceChecks" = "False" }
			LOD 300


			// ------------------------------------------------------------------
			//  Base forward pass (directional light, emission, lightmaps, ...)
			Pass
			{
				Name "FORWARD"
				Tags { "LightMode" = "ForwardBase" }

				Blend[_SrcBlend][_DstBlend]
				ZWrite[_ZWrite]

				CGPROGRAM
				#pragma target 3.0

			// -------------------------------------

			#pragma shader_feature _NORMALMAP
			#pragma shader_feature _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
			#pragma shader_feature _EMISSION
			#pragma shader_feature _METALLICGLOSSMAP
			#pragma shader_feature ___ _DETAIL_MULX2
			#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
			#pragma shader_feature _ _SPECULARHIGHLIGHTS_OFF
			#pragma shader_feature _ _GLOSSYREFLECTIONS_OFF
			#pragma shader_feature _PARALLAXMAP

			#pragma multi_compile_fwdbase
			#pragma multi_compile_fog
			#pragma multi_compile_instancing
			// Uncomment the following line to enable dithering LOD crossfade. Note: there are more in the file to uncomment for other passes.
			//#pragma multi_compile _ LOD_FADE_CROSSFADE

			#pragma vertex vertBase
			#pragma fragment fragBase
			#include "UnityStandardCoreForward.cginc"

			ENDCG
		}
			// ------------------------------------------------------------------
			//  Additive forward pass (one light per pass)
			Pass
			{
				Name "FORWARD_DELTA"
				Tags { "LightMode" = "ForwardAdd" }
				Blend[_SrcBlend] One
				Fog { Color(0,0,0,0) } // in additive pass fog should be black
				ZWrite Off
				ZTest LEqual

				CGPROGRAM
				#pragma target 3.0

			// -------------------------------------


			#pragma shader_feature _NORMALMAP
			#pragma shader_feature _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
			#pragma shader_feature _METALLICGLOSSMAP
			#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
			#pragma shader_feature _ _SPECULARHIGHLIGHTS_OFF
			#pragma shader_feature ___ _DETAIL_MULX2
			#pragma shader_feature _PARALLAXMAP

			#pragma multi_compile_fwdadd_fullshadows
			#pragma multi_compile_fog
			// Uncomment the following line to enable dithering LOD crossfade. Note: there are more in the file to uncomment for other passes.
			//#pragma multi_compile _ LOD_FADE_CROSSFADE

			#pragma vertex vertAdd
			#pragma fragment fragAdd
			#include "UnityStandardCoreForward.cginc"

			ENDCG
		}
				pass {
			Tags{ "LightMode" = "Always" }
				Cull Front
				CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
				float _OutlineWidth;
			fixed4 _OutlineColor;
			float _OutLineAngle;
			struct a2v
			{

				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
				float4 vertexColor : COLOR;

			};
			struct v2f
			{
				float4 pos:SV_POSITION;
				float4 vertexColor : COLOR;
				float3 normal:TEXCOORD0;
				float3 viewDir:TEXCOORD1;
			};


			//描边

			v2f vert(a2v v)
			{
				v2f o;
				//unity_CameraProjection[1].y摄像机FOV正切值一半
				float y_over_x_2 = (1 / unity_CameraProjection[1].y);

				float tmpvar_3 = min(abs(y_over_x_2), 1.0) / max(abs(y_over_x_2), 1.0);

				float tmpvar_4 = tmpvar_3 * tmpvar_3;
				tmpvar_4 = ((((((((((-0.01213232 * tmpvar_4 + 0.05368138) * tmpvar_4) - 0.1173503)
					* tmpvar_4) + 0.1938925) * tmpvar_4) - 0.3326756)
					* tmpvar_4) + 0.9999793) * tmpvar_3);
				tmpvar_4 = (tmpvar_4 + (float(
					(abs(y_over_x_2) > 1.0)
					) * (
					(tmpvar_4 * -2.0)
						+ 1.570796)));

				float4 tmpvar_5 = float4(v.vertex.xyz, 1);

				float3 tmpvar_6 = mul(unity_ObjectToWorld, tmpvar_5).xyz;
				float3 tmpvar_8 = (_WorldSpaceCameraPos - tmpvar_6);
				float cameraDistance_1 = sqrt(dot(tmpvar_8, tmpvar_8));
				float tmpvar_10;
				tmpvar_10 = pow(max(0.004, (cameraDistance_1 - 0.15)), 0.5);
				float tmpvar_11;
				tmpvar_11 = max(_OutlineWidth, 0.004);
				float4 tmpvar_12;
				tmpvar_12.w = 1.0;
				tmpvar_12.xyz = (tmpvar_6 + ((
					(((normalize(UnityObjectToWorldNormal(v.normal)) * 0.002) * v.vertexColor.x) * tmpvar_10)
					*
					pow((1.0 - ((60.0 -
					(114.5916 * (tmpvar_4 * sign(y_over_x_2)))
						) / 60.0)), 0.5)
					) * tmpvar_11));
				o.pos = mul(unity_MatrixVP, tmpvar_12);
				o.normal = UnityObjectToWorldNormal(v.normal);
				o.viewDir = WorldSpaceViewDir(v.vertex);
				return o;


			}
			float4 frag(v2f i) :COLOR
			{
				float4 c = _OutlineColor;
				UNITY_APPLY_FOG(i.fogCoord, c);
				return c;

			}
				ENDCG

		}
		// ------------------------------------------------------------------
		//  Shadow rendering pass
		Pass {
			Name "ShadowCaster"
			Tags { "LightMode" = "ShadowCaster" }

			ZWrite On ZTest LEqual

			CGPROGRAM
			#pragma target 3.0

			// -------------------------------------


			#pragma shader_feature _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
			#pragma shader_feature _METALLICGLOSSMAP
			#pragma shader_feature _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
			#pragma shader_feature _PARALLAXMAP
			#pragma multi_compile_shadowcaster
			#pragma multi_compile_instancing
			// Uncomment the following line to enable dithering LOD crossfade. Note: there are more in the file to uncomment for other passes.
			//#pragma multi_compile _ LOD_FADE_CROSSFADE

			#pragma vertex vertShadowCaster
			#pragma fragment fragShadowCaster

			#include "UnityStandardShadow.cginc"

			ENDCG
		}

			// ------------------------------------------------------------------
			// Extracts information for lightmapping, GI (emission, albedo, ...)
			// This pass it not used during regular rendering.
			Pass
			{
				Name "META"
				Tags { "LightMode" = "Meta" }

				Cull Off

				CGPROGRAM
				#pragma vertex vert_meta
				#pragma fragment frag_meta

				#pragma shader_feature _EMISSION
				#pragma shader_feature _METALLICGLOSSMAP
				#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
				#pragma shader_feature ___ _DETAIL_MULX2
				#pragma shader_feature EDITOR_VISUALIZATION

				#include "UnityStandardMeta.cginc"
				ENDCG
			}
		}

			SubShader
		{
			Tags { "RenderType" = "Opaque" "PerformanceChecks" = "False" }
			LOD 150

			// ------------------------------------------------------------------
			//  Base forward pass (directional light, emission, lightmaps, ...)
			Pass
			{
				Name "FORWARD"
				Tags { "LightMode" = "ForwardBase" }

				Blend[_SrcBlend][_DstBlend]
				ZWrite[_ZWrite]

				CGPROGRAM
				#pragma target 2.0

				#pragma shader_feature _NORMALMAP
				#pragma shader_feature _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
				#pragma shader_feature _EMISSION
				#pragma shader_feature _METALLICGLOSSMAP
				#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
				#pragma shader_feature _ _SPECULARHIGHLIGHTS_OFF
				#pragma shader_feature _ _GLOSSYREFLECTIONS_OFF
			// SM2.0: NOT SUPPORTED shader_feature ___ _DETAIL_MULX2
			// SM2.0: NOT SUPPORTED shader_feature _PARALLAXMAP

			#pragma skip_variants SHADOWS_SOFT DIRLIGHTMAP_COMBINED

			#pragma multi_compile_fwdbase
			#pragma multi_compile_fog

			#pragma vertex vertBase
			#pragma fragment fragBase
			#include "UnityStandardCoreForward.cginc"

			ENDCG
		}
			// ------------------------------------------------------------------
			//  Additive forward pass (one light per pass)
			Pass
			{
				Name "FORWARD_DELTA"
				Tags { "LightMode" = "ForwardAdd" }
				Blend[_SrcBlend] One
				Fog { Color(0,0,0,0) } // in additive pass fog should be black
				ZWrite Off
				ZTest LEqual

				CGPROGRAM
				#pragma target 2.0

				#pragma shader_feature _NORMALMAP
				#pragma shader_feature _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
				#pragma shader_feature _METALLICGLOSSMAP
				#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
				#pragma shader_feature _ _SPECULARHIGHLIGHTS_OFF
				#pragma shader_feature ___ _DETAIL_MULX2
			// SM2.0: NOT SUPPORTED shader_feature _PARALLAXMAP
			#pragma skip_variants SHADOWS_SOFT

			#pragma multi_compile_fwdadd_fullshadows
			#pragma multi_compile_fog

			#pragma vertex vertAdd
			#pragma fragment fragAdd
			#include "UnityStandardCoreForward.cginc"

			ENDCG
		}
				pass {
			Tags{ "LightMode" = "Always" }
				Cull Front
				CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
				float _OutlineWidth;
			fixed4 _OutlineColor;
			struct a2v
			{

				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
				float4 vertexColor : COLOR;

			};
			struct v2f
			{
				float4 pos:SV_POSITION;
				float4 vertexColor : COLOR;
				float3 normal:TEXCOORD0;
				float3 viewDir:TEXCOORD1;
			};


			//描边

			v2f vert(a2v v)
			{
				v2f o;
				//unity_CameraProjection[1].y摄像机FOV正切值一半
				float y_over_x_2 = (1 / unity_CameraProjection[1].y);

				float tmpvar_3 = min(abs(y_over_x_2), 1.0) / max(abs(y_over_x_2), 1.0);

				float tmpvar_4 = tmpvar_3 * tmpvar_3;
				tmpvar_4 = ((((((((((-0.01213232 * tmpvar_4 + 0.05368138) * tmpvar_4) - 0.1173503)
					* tmpvar_4) + 0.1938925) * tmpvar_4) - 0.3326756)
					* tmpvar_4) + 0.9999793) * tmpvar_3);
				tmpvar_4 = (tmpvar_4 + (float(
					(abs(y_over_x_2) > 1.0)
					) * (
					(tmpvar_4 * -2.0)
						+ 1.570796)));

				float4 tmpvar_5 = float4(v.vertex.xyz, 1);

				float3 tmpvar_6 = mul(unity_ObjectToWorld, tmpvar_5).xyz;
				float3 tmpvar_8 = (_WorldSpaceCameraPos - tmpvar_6);
				float cameraDistance_1 = sqrt(dot(tmpvar_8, tmpvar_8));
				float tmpvar_10;
				tmpvar_10 = pow(max(0.004, (cameraDistance_1 - 0.15)), 0.5);
				float tmpvar_11;
				tmpvar_11 = max(_OutlineWidth, 0.004);
				float4 tmpvar_12;
				tmpvar_12.w = 1.0;
				tmpvar_12.xyz = (tmpvar_6 + ((
					(((normalize(UnityObjectToWorldNormal(v.normal)) * 0.002) * v.vertexColor.x) * tmpvar_10)
					*
					pow((1.0 - ((60.0 -
					(114.5916 * (tmpvar_4 * sign(y_over_x_2)))
						) / 60.0)), 0.5)
					) * tmpvar_11));
				o.pos = mul(unity_MatrixVP, tmpvar_12);
				o.normal = UnityObjectToWorldNormal(v.normal);
				o.viewDir = WorldSpaceViewDir(v.vertex);
				return o;


			}
			float4 frag(v2f i) :COLOR
			{
				float4 c = _OutlineColor;
				UNITY_APPLY_FOG(i.fogCoord, c);
				return c;
			}
				ENDCG

		}
		// ------------------------------------------------------------------
		//  Shadow rendering pass
		Pass {
			Name "ShadowCaster"
			Tags { "LightMode" = "ShadowCaster" }

			ZWrite On ZTest LEqual

			CGPROGRAM
			#pragma target 2.0

			#pragma shader_feature _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
			#pragma shader_feature _METALLICGLOSSMAP
			#pragma shader_feature _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
			#pragma skip_variants SHADOWS_SOFT
			#pragma multi_compile_shadowcaster

			#pragma vertex vertShadowCaster
			#pragma fragment fragShadowCaster

			#include "UnityStandardShadow.cginc"

			ENDCG
		}

			// ------------------------------------------------------------------
			// Extracts information for lightmapping, GI (emission, albedo, ...)
			// This pass it not used during regular rendering.
			Pass
			{
				Name "META"
				Tags { "LightMode" = "Meta" }

				Cull Off

				CGPROGRAM
				#pragma vertex vert_meta
				#pragma fragment frag_meta

				#pragma shader_feature _EMISSION
				#pragma shader_feature _METALLICGLOSSMAP
				#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
				#pragma shader_feature ___ _DETAIL_MULX2
				#pragma shader_feature EDITOR_VISUALIZATION

				#include "UnityStandardMeta.cginc"
				ENDCG
			}
		}


			FallBack "VertexLit"
			CustomEditor "SStandardShaderGUI"
}
