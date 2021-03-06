﻿Shader "miHoYo/miHoYo_Character/Character_Avatar/Avatar_DualFace"
{
    Properties
    {
	    _Color("Main Color", Color) = (1,1,1,1)
		_EnvColor("Env Color", Color) = (1,1,1,1)
		_Scale("Scale Compared to Maya", Float) = 0.01
		_BloomFactor("Bloom Factor", Float) = 1
		_MainTex("Main Tex (RGB)", 2D) = "white" { }
		_LightMapTex("Light Map Tex (RGB)", 2D) = "gray" { }
		_LightSpecColor("Light Specular Color", Color) = (1,1,1,1)
		_LightArea("Light Area Threshold", Range(0, 1)) = 0.51
		_SecondShadow("Second Shadow Threshold", Range(0, 1)) = 0.51
		_FirstShadowMultColor("First Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
		_SecondShadowMultColor("Second Shadow Multiply Color", Color) = (0.75,0.6,0.65,1)
		_Shininess("Specular Shininess", Range(0.1, 100)) = 10
		_SpecMulti("Specular Multiply Factor", Range(0, 1)) = 0.1
		_BackFaceColor("Back Face Color", Color) = (1,1,1,1)
		_OutlineWidth("Outline Width", Range(0, 100)) = 0.2
		_OutlineColor("Outline Color", Color) = (0,0,0,1)
		_MaxOutlineZOffset("Max Outline Z Offset", Range(0, 100)) = 1
		_OutlineCamStart("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
		_FadeDistance("Fade Start Distance", Range(0.1, 10)) = 0.5
		_FadeOffset("Fade Start Offset", Range(0, 10)) = 1
		[Toggle(LOOKUP_COLOR)] _LookupColor("Lookup Color", Float) = 0
		[Toggle(LOOKUP_COLOR_BILINEAR)] _LookupColorBilinear("Lookup Color Bilinear", Float) = 0
		_factorTex("Factor Tex", 2D) = "white" { }
		_indexTex("Index Tex", 2D) = "white" { }
		_tableTex("Lookup Tex", 2D) = "white" { }
		[Toggle(SPECIAL_STATE)] _SpecialState("Special State", Float) = 0
		_SPTex("SP Tex", 2D) = "white" { }
		_SPNoiseTex("SP Noise Tex", 2D) = "white" { }
		_SPNoiseScaler("SP Noise Scaler", Range(0, 10)) = 1
		_SPIntensity("SP Intensity", Range(0, 1)) = 0.5
		_SPTransition("SP Transition", Range(0, 1)) = 0
		_SPTransitionColor("SP Transition Color", Color) = (1,1,1,1)
		_SPOpaqueness("SP Opaqueness", Range(0, 1)) = 1
		_SPOutlineColor("SP Outline Color", Color) = (1,1,1,1)
		_SPTransitionEmissionScaler("SP Transition Emission Scaler", Range(1, 100)) = 1
		_SPTransitionBloomFactor("SP Transition Bloom Factor", Float) = 1
		_SPCubeMap("SP CubeMap", Cube) = "white" { }
		_SPCubeMapColor("SP CubeMap Color", Color) = (1,1,1,0)
		_SPCubeMapOffset("SP CubeMap Offset", Vector) = (0,0,0,0)
		_SPCubeMapIntensity("SP CubeMap Intensity", Range(0, 1)) = 0
		_SPCubeMapNoiseIntensity("SP CubeMap Noise Intensity", Range(0, 5)) = 0
		_SPCubeMapBrightness("SP CubeMap Brightness", Float) = 1.26
		_SPOldColor("SP Old Color", Color) = (1,1,1,0)
		[Toggle(RIM_GLOW)] _RimGlow("Rim Glow", Float) = 0
		_RGColor("Rim Glow Color", Color) = (1,1,1,1)
		_RGShininess("Rim Glow Shininess", Float) = 1
		_RGScale("Rim Glow Scale", Float) = 1
		_RGBias("Rim Glow Bias", Float) = 0
		_RGRatio("Rim Glow Ratio", Range(0, 1)) = 0.5
		_RGBloomFactor("Rim Glow Bloom Factor", Float) = 1
		[Toggle(DISTORTION)] _Distortion("Distortion", Float) = 0
		_DTTex("Distortion Tex", 2D) = "gray" { }
		_DTIntensity("Distortion Intensity", Range(1, 9)) = 5
		_DTPlaySpeed("Distortion Play Speed", Float) = 0
		_DTNormalDisplacment("Distortion Normal Displacment", Float) = 0
		_DTUVScaleInX("Distortion UV Scale in X", Float) = 1
		_DTUVScaleInY("Distortion UV Scale in Y", Float) = 1
		_DTFresnel("Distortion Fresnel Params", Vector) = (1,1,0,0)
		_Opaqueness("Opaqueness", Range(0, 1)) = 1
		_VertexAlphaFactor("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
		_OffestFactor("OFfset Factor", Range(-100, 100)) = 0
		_OffestUnit("OFfset Unit", Range(-100, 100)) = 0
		[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha("UsingDitherAlpha", Float) = 0
		_DitherAlpha("Dither Alpha Value", Range(0, 1)) = 1
    }
		SubProgram "gles3 hw_tier02 " {
			Keywords{ "ALPHA_ORIG" "SPECIAL_STATE" "RIM_GLOW" }
				"#ifdef VERTEX
				#version 300 es

				uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
			uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
			uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
			uniform 	vec4 _SPTex_ST;
			uniform 	vec4 _SPNoiseTex_ST;
			uniform 	vec4 _MainTex_ST;
			uniform 	mediump vec4 _CustomLightDir;
			uniform 	float _UsingDitherAlpha;
			uniform 	float _DitherAlpha;
			in highp vec4 in_POSITION0;
			in highp vec3 in_NORMAL0;
			in highp vec4 in_TEXCOORD0;
			in mediump vec4 in_COLOR0;
			out mediump vec4 vs_COLOR0;
			out highp vec2 vs_TEXCOORD0;
			out mediump float vs_COLOR1;
			out highp vec3 vs_TEXCOORD1;
			out highp vec3 vs_TEXCOORD2;
			out highp vec4 vs_TEXCOORD3;
			out highp vec4 vs_TEXCOORD4;
			vec4 u_xlat0;
			bool u_xlatb0;
			vec4 u_xlat1;
			vec4 u_xlat2;
			mediump vec3 u_xlat16_3;
			float u_xlat4;
			float u_xlat8;
			bool u_xlatb8;
			vec2 u_xlat10;
			float u_xlat12;
			void main()
			{
				u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
				u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
				u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
				u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
				u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
				vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
				u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
				u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
				u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
				u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
				gl_Position = u_xlat0;
				vs_COLOR0 = in_COLOR0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
				u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
				u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
				u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
				u_xlat8 = inversesqrt(u_xlat8);
				u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
				vs_TEXCOORD1.xyz = u_xlat1.xyz;
				u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
				u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
				u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
				u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0) != vec4(_UsingDitherAlpha));
#else
				u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0) != vec4(_UsingDitherAlpha);
#endif
				vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
				vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
				u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
				u_xlat4 = u_xlat0.w + u_xlat0.y;
				u_xlat12 = u_xlat0.x * in_POSITION0.x;
				u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
				u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
				vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
				vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
				u_xlatb0 = !!(0.5 < _CustomLightDir.w);
#else
				u_xlatb0 = 0.5 < _CustomLightDir.w;
#endif
				u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
				u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
				u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
				vs_COLOR1 = u_xlat0.x;
				return;
			}

#endif
#ifdef FRAGMENT
			#version 300 es

				precision highp int;
			vec4 ImmCB_0_0_0[4];
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	mediump float _lightProbToggle;
			uniform 	mediump vec4 _lightProbColor;
			uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
			uniform 	float _SPNoiseScaler;
			uniform 	float _SPIntensity;
			uniform 	float _SPTransition;
			uniform 	mediump vec4 _SPTransitionColor;
			uniform 	float _SPTransitionEmissionScaler;
			uniform 	float _SPTransitionBloomFactor;
			uniform 	vec3 _SPCubeMapOffset;
			uniform 	float _SPCubeMapIntensity;
			uniform 	float _SPCubeMapNoiseIntensity;
			uniform 	float _SPCubeMapBrightness;
			uniform 	mediump vec4 _SPOldColor;
			uniform 	mediump vec4 _SPCubeMapColor;
			uniform 	mediump vec4 _RGColor;
			uniform 	float _RGShininess;
			uniform 	float _RGScale;
			uniform 	float _RGBias;
			uniform 	float _RGRatio;
			uniform 	mediump vec4 _Color;
			uniform 	mediump vec4 _EnvColor;
			uniform 	mediump float _LightArea;
			uniform 	mediump float _SecondShadow;
			uniform 	mediump vec3 _FirstShadowMultColor;
			uniform 	mediump vec3 _SecondShadowMultColor;
			uniform 	mediump float _BloomFactor;
			uniform 	mediump float _Shininess;
			uniform 	mediump float _SpecMulti;
			uniform 	mediump vec3 _LightSpecColor;
			uniform 	mediump vec4 _CustomLightDir;
			uniform 	float _UsingDitherAlpha;
			uniform lowp sampler2D _LightMapTex;
			uniform lowp sampler2D _MainTex;
			uniform lowp sampler2D _SPTex;
			uniform lowp sampler2D _SPNoiseTex;
			uniform lowp samplerCube _SPCubeMap;
			in mediump vec4 vs_COLOR0;
			in highp vec2 vs_TEXCOORD0;
			in mediump float vs_COLOR1;
			in highp vec3 vs_TEXCOORD1;
			in highp vec3 vs_TEXCOORD2;
			in highp vec4 vs_TEXCOORD3;
			in highp vec4 vs_TEXCOORD4;
			layout(location = 0) out mediump vec4 SV_Target0;
			vec3 u_xlat0;
			mediump vec3 u_xlat16_0;
			lowp vec4 u_xlat10_0;
			int u_xlati0;
			uvec2 u_xlatu0;
			bool u_xlatb0;
			vec4 u_xlat1;
			mediump vec3 u_xlat16_2;
			mediump vec3 u_xlat16_3;
			vec3 u_xlat4;
			lowp vec3 u_xlat10_4;
			ivec2 u_xlati4;
			vec3 u_xlat5;
			vec3 u_xlat6;
			lowp vec3 u_xlat10_6;
			vec3 u_xlat7;
			mediump vec3 u_xlat16_8;
			vec3 u_xlat9;
			ivec3 u_xlati9;
			vec3 u_xlat10;
			mediump vec3 u_xlat16_11;
			float u_xlat18;
			mediump float u_xlat16_18;
			int u_xlati18;
			bvec2 u_xlatb18;
			float u_xlat27;
			float u_xlat28;
			int u_xlati28;
			bool u_xlatb28;
			mediump float u_xlat16_29;
			void main()
			{
				ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
				ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
				ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
				ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
				u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0) != vec4(_UsingDitherAlpha));
#else
				u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0) != vec4(_UsingDitherAlpha);
#endif
				if (u_xlatb0) {
#ifdef UNITY_ADRENO_ES3
					u_xlatb0 = !!(vs_TEXCOORD3.z < 0.949999988);
#else
					u_xlatb0 = vs_TEXCOORD3.z < 0.949999988;
#endif
					if (u_xlatb0) {
						u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
						u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
						u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
						u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
						u_xlat0.xy = fract(abs(u_xlat0.xy));
						u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
						u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
						u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
						u_xlatu0.xy = uvec2(u_xlat0.xy);
						u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
						u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
						u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
						u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
						u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
						u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
						u_xlat0.x = u_xlat0.x + 0.99000001;
						u_xlat0.x = floor(u_xlat0.x);
						u_xlat0.x = max(u_xlat0.x, 0.0);
						u_xlati0 = int(u_xlat0.x);
						if ((u_xlati0) == 0) { discard; }
						//ENDIF
					}
					//ENDIF
				}
				u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
				u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
				u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
				u_xlat27 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
				u_xlat27 = floor(u_xlat27);
				u_xlat9.z = max(u_xlat27, 0.0);
				u_xlat16_11.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
				u_xlat16_11.x = u_xlat16_11.x * 0.5 + (-_SecondShadow);
				u_xlat16_11.x = u_xlat16_11.x + 1.0;
				u_xlat16_11.x = floor(u_xlat16_11.x);
				u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
				u_xlati28 = int(u_xlat16_11.x);
				u_xlat16_11.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
				u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
				u_xlat16_11.xyz = (int(u_xlati28) != 0) ? u_xlat16_3.xyz : u_xlat16_11.xyz;
				u_xlat9.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
				u_xlat9.x = floor(u_xlat9.x);
				u_xlat9.x = max(u_xlat9.x, 0.0);
				u_xlati9.xz = ivec2(u_xlat9.xz);
				u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
				u_xlat16_2.x = (u_xlati9.x != 0) ? u_xlat4.y : u_xlat4.x;
				u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
				u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
				u_xlat16_2.x = u_xlat16_2.x + 1.0;
				u_xlat16_2.x = floor(u_xlat16_2.x);
				u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
				u_xlati9.x = int(u_xlat16_2.x);
				u_xlat16_3.xyz = (u_xlati9.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
				u_xlat16_2.xyz = (u_xlati9.z != 0) ? u_xlat16_3.xyz : u_xlat16_11.xyz;
				u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
				u_xlat9.x = inversesqrt(u_xlat9.x);
				u_xlat1.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
				u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
				u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
				u_xlat9.x = inversesqrt(u_xlat9.x);
				u_xlat5.xyz = u_xlat9.xxx * u_xlat4.xyz;
				u_xlat6.xyz = u_xlat4.xyz * u_xlat9.xxx + _WorldSpaceLightPos0.xyz;
				u_xlat27 = dot(u_xlat6.xyz, u_xlat6.xyz);
				u_xlat27 = inversesqrt(u_xlat27);
				u_xlat7.xyz = vec3(u_xlat27) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
				u_xlatb28 = !!(0.5 < _CustomLightDir.w);
#else
				u_xlatb28 = 0.5 < _CustomLightDir.w;
#endif
				u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat27) + (-_WorldSpaceLightPos0.xyz);
				u_xlat27 = dot(u_xlat6.xyz, u_xlat6.xyz);
				u_xlat27 = inversesqrt(u_xlat27);
				u_xlat16_3.xyz = u_xlat6.xyz * vec3(u_xlat27) + _CustomLightDir.xyz;
				u_xlat16_29 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
				u_xlat16_29 = inversesqrt(u_xlat16_29);
				u_xlat16_3.xyz = vec3(u_xlat16_29) * u_xlat16_3.xyz;
				u_xlat16_3.xyz = (bool(u_xlatb28)) ? u_xlat16_3.xyz : u_xlat7.xyz;
				u_xlat16_29 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
				u_xlat16_29 = max(u_xlat16_29, 0.0);
				u_xlat16_29 = log2(u_xlat16_29);
				u_xlat16_29 = u_xlat16_29 * _Shininess;
				u_xlat16_29 = exp2(u_xlat16_29);
				u_xlat16_18 = (-u_xlat10_0.z) + 1.0;
				u_xlat16_18 = (-u_xlat16_29) + u_xlat16_18;
				u_xlat18 = u_xlat16_18 + 1.0;
				u_xlat18 = floor(u_xlat18);
				u_xlat18 = max(u_xlat18, 0.0);
				u_xlati18 = int(u_xlat18);
				u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
				u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
				u_xlat16_3.xyz = (int(u_xlati18) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
				u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
				u_xlat10_0.xzw = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
				u_xlat10_6.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
				u_xlat16_29 = u_xlat10_6.x * 1.99000001;
				u_xlat28 = u_xlat16_29 * _SPNoiseScaler + -1.0;
				u_xlat4.xyz = u_xlat4.xyz * u_xlat9.xxx + (-_WorldSpaceCameraPos.xyz);
				u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
				u_xlat9.x = inversesqrt(u_xlat9.x);
				u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SPCubeMapNoiseIntensity);
				u_xlat4.xyz = u_xlat4.xyz * u_xlat9.xxx + u_xlat6.xyz;
				u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
				u_xlat9.x = dot(u_xlat4.xyz, u_xlat1.xyz);
				u_xlat9.x = u_xlat9.x + u_xlat9.x;
				u_xlat4.xyz = u_xlat1.xyz * (-u_xlat9.xxx) + u_xlat4.xyz;
				u_xlat10_4.xyz = texture(_SPCubeMap, u_xlat4.xyz).xyz;
				u_xlat16_3.xyz = u_xlat10_0.xzw * _SPOldColor.xyz;
				u_xlat16_8.xyz = u_xlat10_4.xyz * _SPCubeMapColor.xyz;
				u_xlat0.xyz = u_xlat16_8.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_3.xyz);
				u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_3.xyz;
				u_xlat27 = _SPNoiseScaler * _SPTransition;
				u_xlat4.xy = vec2(u_xlat27) * vec2(1.70000005, 1.5) + (-vec2(u_xlat28));
				u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
				u_xlat4.xy = floor(u_xlat4.xy);
				u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
				u_xlati4.xy = ivec2(u_xlat4.xy);
				u_xlat27 = u_xlat27 * 1.70000005 + (-u_xlat28);
				u_xlat27 = u_xlat27 * 10.0;
#ifdef UNITY_ADRENO_ES3
				u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
				u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
				u_xlat6.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
				u_xlat28 = _SPTransitionBloomFactor + (-_BloomFactor);
				u_xlat6.xyz = vec3(u_xlat27) * u_xlat6.xyz + u_xlat0.xyz;
				u_xlat27 = u_xlat27 * u_xlat28 + _BloomFactor;
				u_xlat16_3.xyz = (u_xlati4.y != 0) ? u_xlat0.xyz : u_xlat6.xyz;
				u_xlat16_29 = (u_xlati4.y != 0) ? _BloomFactor : u_xlat27;
				u_xlat27 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
				u_xlat16_3.xyz = (u_xlati4.x != 0) ? u_xlat16_3.xyz : u_xlat0.xyz;
				SV_Target0.w = (u_xlati4.x != 0) ? u_xlat16_29 : _BloomFactor;
				u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_3.xyz;
				u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + u_xlat16_2.xyz;
				u_xlat27 = dot(u_xlat5.xyz, u_xlat1.xyz);
				u_xlat27 = (-u_xlat27) + 1.00100005;
				u_xlat27 = max(u_xlat27, 0.00100000005);
				u_xlat27 = min(u_xlat27, 1.0);
				u_xlat27 = log2(u_xlat27);
				u_xlat27 = u_xlat27 * _RGShininess;
				u_xlat27 = exp2(u_xlat27);
				u_xlat27 = u_xlat27 * _RGScale + _RGBias;
				u_xlat16_2.x = u_xlat27;
#ifdef UNITY_ADRENO_ES3
				u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
				u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
				u_xlat1.x = u_xlat16_2.x * _RGRatio;
				u_xlat10.xyz = vec3(u_xlat27) * _RGColor.xyz + (-u_xlat0.xyz);
				u_xlat0.xyz = u_xlat1.xxx * u_xlat10.xyz + u_xlat0.xyz;
				u_xlat16_2.xyz = _Color.xyz * _EnvColor.xyz;
				u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
				u_xlatb0 = !!(0.5 < _lightProbToggle);
#else
				u_xlatb0 = 0.5 < _lightProbToggle;
#endif
				u_xlat16_3.xyz = (bool(u_xlatb0)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
				SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
				return;
			}

#endif
			"
		}


		//------------------描边--------------------------

		uniform 	vec4 _ProjectionParams;
		uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
		uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
		uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
		uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
		uniform 	mediump float _OutlineWidth;
		uniform 	mediump vec4 _OutlineColor;
		uniform 	mediump float _MaxOutlineZOffset;
		uniform 	mediump float _Scale;
		uniform 	float _UsingDitherAlpha;
		uniform 	float _DitherAlpha;
		in highp vec4 in_POSITION0;
		in highp vec4 in_TANGENT0;
		in mediump vec4 in_COLOR0;
		out mediump vec4 vs_COLOR0;
		out highp vec4 vs_TEXCOORD3;
		vec4 u_xlat0;
		vec4 u_xlat1;
		vec4 u_xlat2;
		mediump vec2 u_xlat16_3;
		bool u_xlatb8;
		mediump float u_xlat16_11;
		float u_xlat13;
		void main()
		{
			u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
			u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
			u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
			u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
			u_xlat1.xy = u_xlat0.xy * in_TANGENT0.yy;
			u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
			u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
			u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
			u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
			u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
			u_xlat1.xy = u_xlat2.xy * in_TANGENT0.xx + u_xlat1.xy;
			u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
			u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
			u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
			u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
			u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
			u_xlat1.xy = u_xlat2.xy * in_TANGENT0.zz + u_xlat1.xy;
			u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
			u_xlat1.z = 0.00999999978;
			u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
			u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
			u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
			u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
			u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
			u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
			u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
			u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
			u_xlat0 = u_xlat0 / u_xlat0.wwww;
			u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
			u_xlat1.x = inversesqrt(u_xlat1.x);
			u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
			u_xlat1.xyz = u_xlat1.xyz * vec3(_MaxOutlineZOffset);
			u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Scale, _Scale, _Scale));
			u_xlat13 = in_COLOR0.z + -0.5;
			u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat13) + u_xlat0.xyz;
			u_xlat0.x = (-u_xlat0.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
			u_xlat16_11 = u_xlat0.x / _Scale;
			u_xlat0.x = inversesqrt(u_xlat16_11);
			u_xlat0.x = float(1.0) / u_xlat0.x;
			u_xlat16_11 = _OutlineWidth * _Scale;
			u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
			u_xlat16_11 = u_xlat0.x * u_xlat16_11;
			u_xlat0.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat1.xy;
			u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
			u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
			u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
			u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
			gl_Position = u_xlat0;
			vs_COLOR0.xyz = _OutlineColor.xyz;
			vs_COLOR0.w = 1.0;
			u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
			u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
			u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
			u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0) != vec4(_UsingDitherAlpha));
#else
			u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0) != vec4(_UsingDitherAlpha);
#endif
			vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
			vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
			return;
		}

#endif
#ifdef FRAGMENT
		#version 300 es

			precision highp int;
		vec4 ImmCB_0_0_0[4];
		uniform 	vec4 _ScreenParams;
		uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
		uniform 	mediump vec4 _Color;
		uniform 	float _UsingDitherAlpha;
		in mediump vec4 vs_COLOR0;
		in highp vec4 vs_TEXCOORD3;
		layout(location = 0) out mediump vec4 SV_Target0;
		vec2 u_xlat0;
		int u_xlati0;
		uvec2 u_xlatu0;
		bool u_xlatb0;
		vec4 u_xlat1;
		bvec2 u_xlatb4;
		void main()
		{
			ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
			ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
			ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
			ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
			u_xlat0.x = vs_COLOR0.w + 0.99000001;
			u_xlat0.x = floor(u_xlat0.x);
			u_xlat0.x = max(u_xlat0.x, 0.0);
			u_xlati0 = int(u_xlat0.x);
			if ((u_xlati0) == 0) { discard; }
#ifdef UNITY_ADRENO_ES3
			u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0) != vec4(_UsingDitherAlpha));
#else
			u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0) != vec4(_UsingDitherAlpha);
#endif
			if (u_xlatb0) {
#ifdef UNITY_ADRENO_ES3
				u_xlatb0 = !!(vs_TEXCOORD3.z < 0.949999988);
#else
				u_xlatb0 = vs_TEXCOORD3.z < 0.949999988;
#endif
				if (u_xlatb0) {
					u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
					u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
					u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
					u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
					u_xlat0.xy = fract(abs(u_xlat0.xy));
					u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
					u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
					u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
					u_xlatu0.xy = uvec2(u_xlat0.xy);
					u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
					u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
					u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
					u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
					u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
					u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
					u_xlat0.x = u_xlat0.x + 0.99000001;
					u_xlat0.x = floor(u_xlat0.x);
					u_xlat0.x = max(u_xlat0.x, 0.0);
					u_xlati0 = int(u_xlat0.x);
					if ((u_xlati0) == 0) { discard; }
					//ENDIF
				}
				//ENDIF
			}
			SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
			SV_Target0.w = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
			SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
			SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
			return;
		}

#endif
		"
}

}
