Shader "Unlit/miHoYo_Avatar_Avatar(not use tangent)"
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
		[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha("UsingDitherAlpha", Float) = 0
		_DitherAlpha("Dither Alpha Value", Range(0, 1)) = 1
    }
		SubProgram "gles3 hw_tier01 " {
		Keywords{ "ALPHA_B" "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
			out highp vec3 worldNormal;
			out highp vec3 worldPos;
			out highp vec4 vs_TEXCOORD3;
			out highp vec4 vs_TEXCOORD4;
			vec4 u_xlat0;
			bool u_xlatb0;
			vec4 baseTexColor;
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
				baseTexColor = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
				u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
				worldPos.xyz = u_xlat0.xyz / u_xlat0.www;
				u_xlat0 = baseTexColor.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
				u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * baseTexColor.xxxx + u_xlat0;
				u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * baseTexColor.zzzz + u_xlat0;
				u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * baseTexColor.wwww + u_xlat0;
				//----mul( in.pos , MVP ) 
				gl_Position = u_xlat0;
				//--设置顶点颜色
				vs_COLOR0 = in_COLOR0;
				//设置UV信息
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				//---
				baseTexColor.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
				baseTexColor.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
				baseTexColor.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
				//法线normalize
				u_xlat8 = dot(baseTexColor.xyz, baseTexColor.xyz);
				u_xlat8 = inversesqrt(u_xlat8);
				baseTexColor.xyz = vec3(u_xlat8) * baseTexColor.xyz;
				//---世界空间的法线，
				worldNormal.xyz = baseTexColor.xyz;
				//--在这之前u_xlat0是经过mvp转换后的点
				u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
				u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
				u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
	#ifdef UNITY_ADRENO_ES3
				u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0) != vec4(_UsingDitherAlpha));
	#else
				u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0) != vec4(_UsingDitherAlpha);
	#endif
				
				//---u_xlat0:世界空间的位置坐标
				//mix为lerp(vec3(0.0, 0.0, 0.0),wordPos,bvec3(u_xlatb8))
				vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
				vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
				//对xyz进行缩放
				u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
				//
				u_xlat4 = u_xlat0.w + u_xlat0.y;
				//x位置的平方得一半--u_xlat12=in_POSITION0.x*in_POSITION0.x*0.5
				u_xlat12 = u_xlat0.x * in_POSITION0.x;
				//-uv的x为：in_POSITION0.z*in_POSITION0.z*0.5*0.5+in_POSITION0.x*0.5
				u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
				//--uv的y为：in_POSITION0.x*0.5*in_POSITION0.x*0.25+in_POSITION0.z*0.25+in_POSITION0.y*0.5
				u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
				//记录噪声uv，记录特殊效果uv---
				//注意到噪声的uv的获取是通过局部坐标的转换而来的。转换的公式
				vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
				vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;

	#ifdef UNITY_ADRENO_ES3
				u_xlatb0 = !!(0.5 < _CustomLightDir.w);
	#else
				u_xlatb0 = 0.5 < _CustomLightDir.w;
	#endif
				//--自定义的灯光方向，计算lambert光照，有个自定义光照的取值、
				u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
				u_xlat16_3.x = dot(baseTexColor.xyz, u_xlat16_3.xyz);
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
			uniform 	vec4 _indexTex_TexelSize;
			uniform 	float _UsingDitherAlpha;
			uniform lowp sampler2D _LightMapTex;
			uniform lowp sampler2D _factorTex;
			uniform lowp sampler2D _indexTex;
			uniform lowp sampler2D _tableTex;
			uniform lowp sampler2D _SPTex;
			uniform lowp sampler2D _SPNoiseTex;
			uniform lowp samplerCube _SPCubeMap;
			in mediump vec4 vs_COLOR0;
			in highp vec2 vs_TEXCOORD0;
			in mediump float vs_COLOR1;
			in highp vec3 worldNormal;
			in highp vec3 worldPos;
			in highp vec4 vs_TEXCOORD3;
			in highp vec4 vs_TEXCOORD4;
			layout(location = 0) out mediump vec4 SV_Target0;
			vec4 u_xlat0;
			mediump vec3 u_xlat16_0;
			lowp vec4 FlightMaptex;
			int u_xlati0;
			uvec2 u_xlatu0;
			bool u_xlatb0;
			vec4 baseTexColor;
			mediump vec3 u_xlat16_1;
			lowp vec3 u_xlat10_1;
			vec4 u_xlat2;
			lowp vec3 u_xlat10_2;
			ivec2 u_xlati2;
			vec4 FviewDir;
			mediump vec3 u_xlat16_3;
			lowp vec3 u_xlat10_3;
			vec4 u_xlat4;
			lowp vec3 spNoiseTexColor;
			vec3 FhalfDir;
			lowp vec3 u_xlat10_5;
			lowp vec3 u_xlat10_6;
			mediump vec3 shadowEndColor;
			mediump vec3 FirstShadowColor;
			mediump vec3 u_xlat16_9;
			mediump vec3 u_xlat16_10;
			vec3 u_xlat11;
			ivec3 u_xlati11;
			mediump vec3 SecondShadowColor;
			float u_xlat22;
			mediump float u_xlat16_22;
			int u_xlati22;
			bvec2 u_xlatb22;
			float temp;
			lowp float u_xlat10_33;
			float u_xlat34;
			int u_xlati34;
			bool u_xlatb34;
			mediump float spec;
			void main()
			{
				//消隐功能
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
						u_xlatb22.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
						u_xlat0.xy = fract(abs(u_xlat0.xy));
						u_xlat0.x = (u_xlatb22.x) ? u_xlat0.x : (-u_xlat0.x);
						u_xlat0.y = (u_xlatb22.y) ? u_xlat0.y : (-u_xlat0.y);
						u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
						u_xlatu0.xy = uvec2(u_xlat0.xy);
						baseTexColor.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
						baseTexColor.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
						baseTexColor.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
						baseTexColor.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
						u_xlat0.x = dot(baseTexColor, ImmCB_0_0_0[int(u_xlatu0.x)]);
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
				FlightMaptex.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
				baseTexColor = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
				u_xlat2.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
				FviewDir = floor(u_xlat2.xyxy);
				u_xlat2.xy = fract(u_xlat2.xy);
				u_xlat4 = vec4(FviewDir.z + float(0.5), FviewDir.w + float(0.5), FviewDir.z + float(1.5), FviewDir.w + float(0.5));
				u_xlat4 = baseTexColor * u_xlat4;
				u_xlat10_33 = texture(_factorTex, u_xlat4.xy).x;
				FhalfDir.x = texture(_indexTex, u_xlat4.xy).w;
				FhalfDir.y = float(0.0);
				FhalfDir.z = float(1.0);
				u_xlat10_6.xyz = texture(_tableTex, FhalfDir.xy).xyz;
				u_xlat10_5.xyz = texture(_tableTex, FhalfDir.xz).xyz;
				shadowEndColor.xyz = (-u_xlat10_6.xyz) + u_xlat10_5.xyz;
				shadowEndColor.xyz = vec3(u_xlat10_33) * shadowEndColor.xyz + u_xlat10_6.xyz;
				u_xlat10_33 = texture(_factorTex, u_xlat4.zw).x;
				u_xlat4.x = texture(_indexTex, u_xlat4.zw).w;
				u_xlat4.y = float(0.0);
				u_xlat4.z = float(1.0);
				u_xlat10_5.xyz = texture(_tableTex, u_xlat4.xy).xyz;
				spNoiseTexColor.xyz = texture(_tableTex, u_xlat4.xz).xyz;
				FirstShadowColor.xyz = (-u_xlat10_5.xyz) + spNoiseTexColor.xyz;
				FirstShadowColor.xyz = vec3(u_xlat10_33) * FirstShadowColor.xyz + u_xlat10_5.xyz;
				FviewDir = FviewDir + vec4(0.5, 1.5, 1.5, 1.5);
				baseTexColor = baseTexColor * FviewDir;
				u_xlat10_33 = texture(_factorTex, baseTexColor.xy).x;
				FviewDir.x = texture(_indexTex, baseTexColor.xy).w;
				FviewDir.y = float(0.0);
				FviewDir.z = float(1.0);
				spNoiseTexColor.xyz = texture(_tableTex, FviewDir.xy).xyz;
				u_xlat10_3.xyz = texture(_tableTex, FviewDir.xz).xyz;
				u_xlat16_9.xyz = (-spNoiseTexColor.xyz) + u_xlat10_3.xyz;
				u_xlat16_9.xyz = vec3(u_xlat10_33) * u_xlat16_9.xyz + spNoiseTexColor.xyz;
				u_xlat10_33 = texture(_factorTex, baseTexColor.zw).x;
				baseTexColor.x = texture(_indexTex, baseTexColor.zw).w;
				baseTexColor.y = float(0.0);
				baseTexColor.z = float(1.0);
				u_xlat10_3.xyz = texture(_tableTex, baseTexColor.xy).xyz;
				u_xlat10_1.xyz = texture(_tableTex, baseTexColor.xz).xyz;
				u_xlat16_10.xyz = (-u_xlat10_3.xyz) + u_xlat10_1.xyz;
				u_xlat16_10.xyz = vec3(u_xlat10_33) * u_xlat16_10.xyz + u_xlat10_3.xyz;
				u_xlat16_1.xyz = (-shadowEndColor.xyz) + FirstShadowColor.xyz;
				baseTexColor.xyz = u_xlat2.xxx * u_xlat16_1.xyz + shadowEndColor.xyz;
				u_xlat16_3.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
				u_xlat2.xzw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_9.xyz;
				u_xlat2.xzw = (-baseTexColor.xyz) + u_xlat2.xzw;
				baseTexColor.xyz = u_xlat2.yyy * u_xlat2.xzw + baseTexColor.xyz;
				//--遮罩图g通道*顶点颜色
				shadowEndColor.x = FlightMaptex.y * vs_COLOR0.x;
				//--阴影倾向
				temp = vs_COLOR0.x * FlightMaptex.y + 0.909999967;
				//向下取整，小于1取0
				temp = floor(temp);
				//u_xlat11.z表示了阴影倾向，不加lambert
				u_xlat11.z = max(temp, 0.0);
				//---顶点颜色*遮罩图通道 +lambert        COLOR1:lambert
				SecondShadowColor.x = vs_COLOR0.x * FlightMaptex.y + vs_COLOR1;
				//---计算出阴影面，小于<0的就是处在了暗面，大于0就是亮面---这个我们可以平滑处理，他这里没有做平滑过渡
				SecondShadowColor.x = SecondShadowColor.x * 0.5 + (-_SecondShadow);
				SecondShadowColor.x = SecondShadowColor.x + 1.0;
				//---0就是暗面  1为亮面
				SecondShadowColor.x = floor(SecondShadowColor.x);
				SecondShadowColor.x = max(SecondShadowColor.x, 0.0);
				//---0就是暗面  1为亮面
				u_xlati34 = int(SecondShadowColor.x);


				SecondShadowColor.xyz = baseTexColor.xyz * _SecondShadowMultColor.xyz;
				FirstShadowColor.xyz = baseTexColor.xyz * _FirstShadowMultColor.xyz;
				//根据判断当前片元处于亮面还是暗面获取对应的颜色--
				//亮暗面判断到此结束了。。亮面为First暗面为Second
				SecondShadowColor.xyz = (int(u_xlati34) != 0) ? FirstShadowColor.xyz : SecondShadowColor.xyz;
				//--将顶点颜色以0.5边界区分
				u_xlat11.x = (-vs_COLOR0.x) * FlightMaptex.y + 1.5;
				u_xlat11.x = floor(u_xlat11.x);
				//--u_xlat11.x对其进行了分界设定为0,1
				u_xlat11.x = max(u_xlat11.x, 0.0);

				u_xlati11.xz = ivec2(u_xlat11.xz);
				//---进行阴影映射
				u_xlat2.xy = shadowEndColor.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
				//---判断映射之后的取值
				shadowEndColor.x = (u_xlati11.x != 0) ? u_xlat2.y : u_xlat2.x;
				//---对应增加范围后再次加上lambert数据
				shadowEndColor.x = shadowEndColor.x + vs_COLOR1;

				shadowEndColor.x = shadowEndColor.x * 0.5 + (-_LightArea);
				shadowEndColor.x = shadowEndColor.x + 1.0;
				//---向下取整，暗面为0，亮面为1。
				shadowEndColor.x = floor(shadowEndColor.x);
				shadowEndColor.x = max(shadowEndColor.x, 0.0);
				//暗面为0，亮面为1。
				u_xlati11.x = int(shadowEndColor.x);
				//---1.0f - step(_LightArea, t1)
				//-----扩展后u_xlati11的x表示高光处，暗面为0，亮面为1。--如果为暗面FirstShadowColor.xyz，如果为亮面则为默认颜色
				//-----u_xlati11.z表示顶点的阴影倾向图
				//----如果为暗面则为亮面的颜色，如果是亮面则是基础颜色。。。
				FirstShadowColor.xyz = (u_xlati11.x != 0) ? baseTexColor.xyz : FirstShadowColor.xyz;
				//----u_xlati11.z阴影倾向图，顶点颜色为0或者遮罩图的g通道为0，则使用第一次计算的信息，也就是说这个地方是不希望有
				//LightArea的，通过这可以达到美术控制的效果
				//----如果为不为零，那就说明这个地方
				shadowEndColor.xyz = (u_xlati11.z != 0) ? FirstShadowColor.xyz : SecondShadowColor.xyz;


				u_xlat11.x = dot(worldNormal.xyz, worldNormal.xyz);
				u_xlat11.x = inversesqrt(u_xlat11.x);
				//---baseTexColor---表示归一化法线  又一次对法线做了归一化
				baseTexColor.xyz = u_xlat11.xxx * worldNormal.xyz;

				u_xlat2.xyz = (-worldPos.xyz) + _WorldSpaceCameraPos.xyz;
				u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
				u_xlat11.x = inversesqrt(u_xlat11.x);
				//---viewDir
				FviewDir.xyz = u_xlat11.xxx * u_xlat2.xyz;
				u_xlat4.xyz = u_xlat2.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
				temp = dot(u_xlat4.xyz, u_xlat4.xyz);
				temp = inversesqrt(temp);
				//---LightDir
				FhalfDir.xyz = vec3(temp) * u_xlat4.xyz;
	#ifdef UNITY_ADRENO_ES3
				u_xlatb34 = !!(0.5 < _CustomLightDir.w);
	#else
				u_xlatb34 = 0.5 < _CustomLightDir.w;
	#endif

				u_xlat4.xyz = u_xlat4.xyz * vec3(temp) + (-_WorldSpaceLightPos0.xyz);
				temp = dot(u_xlat4.xyz, u_xlat4.xyz);
				//---半角
				temp = inversesqrt(temp);
				FirstShadowColor.xyz = u_xlat4.xyz * vec3(temp) + _CustomLightDir.xyz;
				spec = dot(FirstShadowColor.xyz, FirstShadowColor.xyz);
				spec = inversesqrt(spec);
				FirstShadowColor.xyz = vec3(spec) * FirstShadowColor.xyz;
				FirstShadowColor.xyz = (bool(u_xlatb34)) ? FirstShadowColor.xyz : FhalfDir.xyz;
				spec = dot(baseTexColor.xyz, FirstShadowColor.xyz);
				spec = max(spec, 0.0);
				spec = log2(spec);
				spec = spec * _Shininess;
				//---
				spec = exp2(spec);
				u_xlat16_22 = (-FlightMaptex.z) + 1.0;
				u_xlat16_22 = (-spec) + u_xlat16_22;
				u_xlat22 = u_xlat16_22 + 1.0;
				u_xlat22 = floor(u_xlat22);
				u_xlat22 = max(u_xlat22, 0.0);
				//---小于高光的限定的没有高光，大于的有高光，也就是光照图的b通道确定了，高中的倾向性。[1-0],1表示高光可能0,
				//0表示不受限制
				u_xlati22 = int(u_xlat22);
				//---这个就是加上高光颜色
				//---计算高光颜色
				FirstShadowColor.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
				//---同时r通道，则显示了如果此区域有高光，那么高光系数为多少
				FirstShadowColor.xyz = FlightMaptex.xxx * FirstShadowColor.xyz;
				FirstShadowColor.xyz = (int(u_xlati22) != 0) ? vec3(0.0, 0.0, 0.0) : FirstShadowColor.xyz;
				shadowEndColor.xyz = shadowEndColor.xyz + FirstShadowColor.xyz;



				FlightMaptex.xzw = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
				spNoiseTexColor.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
				spec = spNoiseTexColor.x * 1.99000001;
				//---这个操作---进行缩放后范围就到了[-1,1.999_SPNoiseScaler-1]了，有可能是负数啊，下限固定，上限
				u_xlat34 = spec * _SPNoiseScaler + -1.0;
				//---u_xlat2--viewdir--（u_xlat2.xyz = (-worldPos.xyz) + _WorldSpaceCameraPos.xyz;）
				u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + (-_WorldSpaceCameraPos.xyz);
				u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
				u_xlat11.x = inversesqrt(u_xlat11.x);
				u_xlat4.xyz = spNoiseTexColor.xyz * vec3(_SPCubeMapNoiseIntensity);
				u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + u_xlat4.xyz;
				u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
				//--此时basecolor表示世界法线----u_xlat2应该为worldviewDir
				//---反射reflect(u_xlat2,baseTexColor)
				u_xlat11.x = dot(u_xlat2.xyz, baseTexColor.xyz);
				u_xlat11.x = u_xlat11.x + u_xlat11.x;
				u_xlat2.xyz = baseTexColor.xyz * (-u_xlat11.xxx) + u_xlat2.xyz;
				//采样CubeMap
				cubeMapColor.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
				//---
				FirstShadowColor.xyz = FlightMaptex.xzw * _SPOldColor.xyz;
				//---特殊状态的颜色混合
				u_xlat16_9.xyz = cubeMapColor.xyz * _SPCubeMapColor.xyz;
				//---颜色*亮度-遮罩图的颜色叠加
				u_xlat0.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-FirstShadowColor.xyz);
				//---颜色*密度+遮罩图颜色
				u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + FirstShadowColor.xyz;
				//--噪声系数*流动系数
				temp = _SPNoiseScaler * _SPTransition;
				//---_SPNoiseScaler * _SPTransition* vec2(1.70000005, 1.5)-(1.99*spNoiseTexColor.x*_SPNoiseScaler-1)
				u_xlat2.xy = vec2(temp) * vec2(1.70000005, 1.5) + (-vec2(u_xlat34));
				//---    max(0,step( 1 , u_xlat2 ) )
				u_xlat2.xy = u_xlat2.xy + vec2(1.0, 1.0);
				u_xlat2.xy = floor(u_xlat2.xy);

				u_xlat2.xy = max(u_xlat2.xy, vec2(0.0, 0.0));
				u_xlati2.xy = ivec2(u_xlat2.xy);
				temp = temp * 1.70000005 + (-u_xlat34);
				temp = temp * 10.0;
	#ifdef UNITY_ADRENO_ES3
				temp = min(max(temp, 0.0), 1.0);
	#else
				temp = clamp(temp, 0.0, 1.0);
	#endif

				u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
				u_xlat34 = _SPTransitionBloomFactor + (-_BloomFactor);
				u_xlat4.xyz = vec3(temp) * u_xlat4.xyz + u_xlat0.xyz;
				temp = temp * u_xlat34 + _BloomFactor;
				FirstShadowColor.xyz = (u_xlati2.y != 0) ? u_xlat0.xyz : u_xlat4.xyz;
				spec = (u_xlati2.y != 0) ? _BloomFactor : temp;
				temp = (u_xlati2.x != 0) ? _SPIntensity : 0.0;
				FirstShadowColor.xyz = (u_xlati2.x != 0) ? FirstShadowColor.xyz : u_xlat0.xyz;
				SV_Target0.w = (u_xlati2.x != 0) ? spec : _BloomFactor;
				u_xlat16_0.xyz = (-shadowEndColor.xyz) + FirstShadowColor.xyz;
				u_xlat0.xyz = vec3(temp) * u_xlat16_0.xyz + shadowEndColor.xyz;
				shadowEndColor.xyz = _Color.xyz * _EnvColor.xyz;
				shadowEndColor.xyz = u_xlat0.xyz * shadowEndColor.xyz;
				u_xlat0.x = dot(FviewDir.xyz, baseTexColor.xyz);
				u_xlat0.x = (-u_xlat0.x) + 1.00100005;
				u_xlat0.x = max(u_xlat0.x, 0.00100000005);
				u_xlat0.x = min(u_xlat0.x, 1.0);
				u_xlat0.x = log2(u_xlat0.x);
				u_xlat0.x = u_xlat0.x * _RGShininess;
				u_xlat0.x = exp2(u_xlat0.x);
				u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
				spec = u_xlat0.x;
	#ifdef UNITY_ADRENO_ES3
				spec = min(max(spec, 0.0), 1.0);
	#else
				spec = clamp(spec, 0.0, 1.0);
	#endif
				u_xlat11.x = spec * _RGRatio;
				u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-shadowEndColor.xyz);
				u_xlat0.xyz = u_xlat11.xxx * u_xlat0.xzw + shadowEndColor.xyz;
				SV_Target0.xyz = u_xlat0.xyz;
				return;
			}

#endif
		"
	}
}
