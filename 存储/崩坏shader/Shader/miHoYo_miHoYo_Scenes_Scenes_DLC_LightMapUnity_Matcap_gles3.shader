//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/LightMapUnity_Matcap" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "gray" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (0,0,0,0)
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
_ShadowIntegration ("Shadow Integration", Range(0, 1)) = 0.2
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
_LightMapIntensity ("Light Map Intensity", Range(0, 5)) = 1.5
_FogTune ("Fog Tune", Range(0, 1)) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
[MHYHeaderBox(MATCAP)] [Toggle(MATCAP_ON)] _EnableMatcap ("Enable Matcap", Float) = 0
_MatcapMaskMap ("MatcapMask Map", 2D) = "white" { }
[Toggle(BUMPMAP_ON)] _EnableBumpMap ("Enable Bump Map", Float) = 0
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
[MHYHeaderBox(MATCAP SPECULAR)] [Toggle(SPECULAR_ON)] _EnableMatcapSpecular ("Enable Matcap Specular", Float) = 0
_SpecularMap ("Specular MatCap", 2D) = "black" { }
_SpecularIntensity ("Specular Intensity", Range(0, 1)) = 0
_LightmapThreshold ("Lightmap Threshold", Range(0, 1)) = 0.5
_IntensityInLightmap ("Intensity In Lightmap", Range(0, 1)) = 0.1
[MHYHeaderBox(LIGHTMAP)] [Toggle(LIGHTMAPCOLOR_ON)] _EnableLightmapColor ("Enable LightmapColor Change", Float) = 0
_LightmapColorScale ("LightmapColorScale", Range(0, 4)) = 1.85
_LightmapColorIns ("LightmapColorIns", Range(0, 2)) = 0.9
_LightmapColorChange ("LightmapColorChange (RGB)", 2D) = "white" { }
_LightmapColorLerp ("LightmapColorLerp", Range(0, 1)) = 1
_Transparent ("_Trans", Range(0, 1)) = 1
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 14106
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" "MATCAP_ON" "BUMPMAP_ON" "SPECULAR_ON" "LIGHTMAPCOLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat21 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat21 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat21 = (u_xlatb2) ? u_xlat22 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor3.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat22 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat14 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat9.x = u_xlat22 * -1.44269502;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat9.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat22) + 2.0;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat22 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat9.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat7.xxx * u_xlat9.xyz + u_xlat1.xyz;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb2) ? u_xlat21 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat14 * -1.44269502;
    u_xlat7.z = exp2(u_xlat21);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat7.z / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump float _LightmapColorScale;
uniform 	mediump float _LightmapColorIns;
uniform 	mediump float _LightmapColorLerp;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform 	float _LightmapThreshold;
uniform 	float _IntensityInLightmap;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _LightmapColorChange;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SpecularMap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
int u_xlati1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_10;
vec2 u_xlat14;
lowp float u_xlat10_14;
bvec2 u_xlatb14;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
void main()
{
	ImmCB_0_0_0[0] = 0.0588235296;
	ImmCB_0_0_0[1] = 0.529411793;
	ImmCB_0_0_0[2] = 0.176470593;
	ImmCB_0_0_0[3] = 0.647058845;
	ImmCB_0_0_0[4] = 0.764705896;
	ImmCB_0_0_0[5] = 0.294117659;
	ImmCB_0_0_0[6] = 0.882352948;
	ImmCB_0_0_0[7] = 0.411764711;
	ImmCB_0_0_0[8] = 0.235294119;
	ImmCB_0_0_0[9] = 0.70588237;
	ImmCB_0_0_0[10] = 0.117647059;
	ImmCB_0_0_0[11] = 0.588235319;
	ImmCB_0_0_0[12] = 0.941176474;
	ImmCB_0_0_0[13] = 0.470588237;
	ImmCB_0_0_0[14] = 0.823529422;
	ImmCB_0_0_0[15] = 0.352941185;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Transparent<0.949999988);
#else
    u_xlatb0 = _Transparent<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb14.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb14.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb14.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(16.0, 4.0);
        u_xlat0.x = u_xlat0.y + u_xlat0.x;
        u_xlatu0 = uint(u_xlat0.x);
        u_xlat0.x = _Transparent + (-ImmCB_0_0_0[int(u_xlatu0)]);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(u_xlat0.x<0.0);
#else
        u_xlatb0 = u_xlat0.x<0.0;
#endif
        if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat14.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat14.xy * vec2(0.25, 0.25);
    u_xlat14.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat14.x * 0.0625 + unity_LODFade.y;
    u_xlat10_14 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat14.x = u_xlat10_14 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14.x = !!(u_xlat14.x<0.0);
#else
    u_xlatb14.x = u_xlat14.x<0.0;
#endif
    if((int(u_xlatb14.x) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb14.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb14.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_3.x = u_xlat10_0.x;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_10.xyz = u_xlat10_1.xyz * _ShadowColor.xyz;
    u_xlat16_0.x = dot(u_xlat16_10.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.x = u_xlat16_0.x * _LightmapColorScale;
    u_xlat0.y = 0.5;
    u_xlat10_0.xyz = texture(_LightmapColorChange, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(vec3(_LightmapColorIns, _LightmapColorIns, _LightmapColorIns));
    u_xlat16_10.xyz = u_xlat16_0.xyz * _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * _ShadowColor.xyz + (-u_xlat16_10.xyz);
    u_xlat16_10.xyz = vec3(vec3(_LightmapColorLerp, _LightmapColorLerp, _LightmapColorLerp)) * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat16_4.x = u_xlat10_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_24 = dot(vs_TEXCOORD4.xyz, u_xlat16_6.xyz);
    u_xlat16_25 = dot(vs_TEXCOORD5.xyz, u_xlat16_6.xyz);
    u_xlat16_26 = dot(vs_TEXCOORD6.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = vec3(u_xlat16_25) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_24) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * vec3(u_xlat16_26) + u_xlat0.xyz;
    u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat14.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat14.xy = u_xlat0.xy * (-u_xlat14.xx) + u_xlat2.xy;
    u_xlat14.xy = (-u_xlat0.xy) + u_xlat14.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat14.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_14 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_2.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat0.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
    u_xlat10_0.xyw = texture(_SpecularMap, u_xlat0.xy).xyz;
    u_xlat0.xyw = u_xlat10_0.xyw * vec3(_SpecularIntensity);
    u_xlat16_24 = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat1.x = (-u_xlat16_24) + _LightmapThreshold;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat1.x = (u_xlati1 != 0) ? 0.0 : 1.0;
    u_xlat1.x = u_xlat1.x + _IntensityInLightmap;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat0.xyw;
    u_xlat16_0.xyw = (-u_xlat16_4.xyz) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_0.xyz = vec3(u_xlat10_14) * u_xlat16_0.xyw + u_xlat16_5.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" "MATCAP_ON" "BUMPMAP_ON" "SPECULAR_ON" "LIGHTMAPCOLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat21 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat21 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat21 = (u_xlatb2) ? u_xlat22 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor3.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat22 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat14 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat9.x = u_xlat22 * -1.44269502;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat9.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat22) + 2.0;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat22 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat9.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat7.xxx * u_xlat9.xyz + u_xlat1.xyz;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb2) ? u_xlat21 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat14 * -1.44269502;
    u_xlat7.z = exp2(u_xlat21);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat7.z / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump float _LightmapColorScale;
uniform 	mediump float _LightmapColorIns;
uniform 	mediump float _LightmapColorLerp;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform 	float _LightmapThreshold;
uniform 	float _IntensityInLightmap;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _LightmapColorChange;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SpecularMap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
int u_xlati1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_10;
vec2 u_xlat14;
lowp float u_xlat10_14;
bvec2 u_xlatb14;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
void main()
{
	ImmCB_0_0_0[0] = 0.0588235296;
	ImmCB_0_0_0[1] = 0.529411793;
	ImmCB_0_0_0[2] = 0.176470593;
	ImmCB_0_0_0[3] = 0.647058845;
	ImmCB_0_0_0[4] = 0.764705896;
	ImmCB_0_0_0[5] = 0.294117659;
	ImmCB_0_0_0[6] = 0.882352948;
	ImmCB_0_0_0[7] = 0.411764711;
	ImmCB_0_0_0[8] = 0.235294119;
	ImmCB_0_0_0[9] = 0.70588237;
	ImmCB_0_0_0[10] = 0.117647059;
	ImmCB_0_0_0[11] = 0.588235319;
	ImmCB_0_0_0[12] = 0.941176474;
	ImmCB_0_0_0[13] = 0.470588237;
	ImmCB_0_0_0[14] = 0.823529422;
	ImmCB_0_0_0[15] = 0.352941185;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Transparent<0.949999988);
#else
    u_xlatb0 = _Transparent<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb14.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb14.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb14.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(16.0, 4.0);
        u_xlat0.x = u_xlat0.y + u_xlat0.x;
        u_xlatu0 = uint(u_xlat0.x);
        u_xlat0.x = _Transparent + (-ImmCB_0_0_0[int(u_xlatu0)]);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(u_xlat0.x<0.0);
#else
        u_xlatb0 = u_xlat0.x<0.0;
#endif
        if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat14.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat14.xy * vec2(0.25, 0.25);
    u_xlat14.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat14.x * 0.0625 + unity_LODFade.y;
    u_xlat10_14 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat14.x = u_xlat10_14 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14.x = !!(u_xlat14.x<0.0);
#else
    u_xlatb14.x = u_xlat14.x<0.0;
#endif
    if((int(u_xlatb14.x) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb14.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb14.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_3.x = u_xlat10_0.x;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_10.xyz = u_xlat10_1.xyz * _ShadowColor.xyz;
    u_xlat16_0.x = dot(u_xlat16_10.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.x = u_xlat16_0.x * _LightmapColorScale;
    u_xlat0.y = 0.5;
    u_xlat10_0.xyz = texture(_LightmapColorChange, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(vec3(_LightmapColorIns, _LightmapColorIns, _LightmapColorIns));
    u_xlat16_10.xyz = u_xlat16_0.xyz * _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * _ShadowColor.xyz + (-u_xlat16_10.xyz);
    u_xlat16_10.xyz = vec3(vec3(_LightmapColorLerp, _LightmapColorLerp, _LightmapColorLerp)) * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat16_4.x = u_xlat10_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_24 = dot(vs_TEXCOORD4.xyz, u_xlat16_6.xyz);
    u_xlat16_25 = dot(vs_TEXCOORD5.xyz, u_xlat16_6.xyz);
    u_xlat16_26 = dot(vs_TEXCOORD6.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = vec3(u_xlat16_25) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_24) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * vec3(u_xlat16_26) + u_xlat0.xyz;
    u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat14.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat14.xy = u_xlat0.xy * (-u_xlat14.xx) + u_xlat2.xy;
    u_xlat14.xy = (-u_xlat0.xy) + u_xlat14.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat14.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_14 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_2.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat0.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
    u_xlat10_0.xyw = texture(_SpecularMap, u_xlat0.xy).xyz;
    u_xlat0.xyw = u_xlat10_0.xyw * vec3(_SpecularIntensity);
    u_xlat16_24 = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat1.x = (-u_xlat16_24) + _LightmapThreshold;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat1.x = (u_xlati1 != 0) ? 0.0 : 1.0;
    u_xlat1.x = u_xlat1.x + _IntensityInLightmap;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat0.xyw;
    u_xlat16_0.xyw = (-u_xlat16_4.xyz) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_0.xyz = vec3(u_xlat10_14) * u_xlat16_0.xyw + u_xlat16_5.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" "MATCAP_ON" "BUMPMAP_ON" "SPECULAR_ON" "LIGHTMAPCOLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat21 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat21 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat21 = (u_xlatb2) ? u_xlat22 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor3.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat22 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat14 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat9.x = u_xlat22 * -1.44269502;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat9.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat22) + 2.0;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat22 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat9.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat7.xxx * u_xlat9.xyz + u_xlat1.xyz;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb2) ? u_xlat21 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat14 * -1.44269502;
    u_xlat7.z = exp2(u_xlat21);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat7.z / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump float _LightmapColorScale;
uniform 	mediump float _LightmapColorIns;
uniform 	mediump float _LightmapColorLerp;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform 	float _LightmapThreshold;
uniform 	float _IntensityInLightmap;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _LightmapColorChange;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SpecularMap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
int u_xlati1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_10;
vec2 u_xlat14;
lowp float u_xlat10_14;
bvec2 u_xlatb14;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
void main()
{
	ImmCB_0_0_0[0] = 0.0588235296;
	ImmCB_0_0_0[1] = 0.529411793;
	ImmCB_0_0_0[2] = 0.176470593;
	ImmCB_0_0_0[3] = 0.647058845;
	ImmCB_0_0_0[4] = 0.764705896;
	ImmCB_0_0_0[5] = 0.294117659;
	ImmCB_0_0_0[6] = 0.882352948;
	ImmCB_0_0_0[7] = 0.411764711;
	ImmCB_0_0_0[8] = 0.235294119;
	ImmCB_0_0_0[9] = 0.70588237;
	ImmCB_0_0_0[10] = 0.117647059;
	ImmCB_0_0_0[11] = 0.588235319;
	ImmCB_0_0_0[12] = 0.941176474;
	ImmCB_0_0_0[13] = 0.470588237;
	ImmCB_0_0_0[14] = 0.823529422;
	ImmCB_0_0_0[15] = 0.352941185;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Transparent<0.949999988);
#else
    u_xlatb0 = _Transparent<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb14.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb14.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb14.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(16.0, 4.0);
        u_xlat0.x = u_xlat0.y + u_xlat0.x;
        u_xlatu0 = uint(u_xlat0.x);
        u_xlat0.x = _Transparent + (-ImmCB_0_0_0[int(u_xlatu0)]);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(u_xlat0.x<0.0);
#else
        u_xlatb0 = u_xlat0.x<0.0;
#endif
        if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat14.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat14.xy * vec2(0.25, 0.25);
    u_xlat14.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat14.x * 0.0625 + unity_LODFade.y;
    u_xlat10_14 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat14.x = u_xlat10_14 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14.x = !!(u_xlat14.x<0.0);
#else
    u_xlatb14.x = u_xlat14.x<0.0;
#endif
    if((int(u_xlatb14.x) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb14.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb14.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_3.x = u_xlat10_0.x;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_10.xyz = u_xlat10_1.xyz * _ShadowColor.xyz;
    u_xlat16_0.x = dot(u_xlat16_10.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.x = u_xlat16_0.x * _LightmapColorScale;
    u_xlat0.y = 0.5;
    u_xlat10_0.xyz = texture(_LightmapColorChange, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(vec3(_LightmapColorIns, _LightmapColorIns, _LightmapColorIns));
    u_xlat16_10.xyz = u_xlat16_0.xyz * _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * _ShadowColor.xyz + (-u_xlat16_10.xyz);
    u_xlat16_10.xyz = vec3(vec3(_LightmapColorLerp, _LightmapColorLerp, _LightmapColorLerp)) * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat16_4.x = u_xlat10_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_24 = dot(vs_TEXCOORD4.xyz, u_xlat16_6.xyz);
    u_xlat16_25 = dot(vs_TEXCOORD5.xyz, u_xlat16_6.xyz);
    u_xlat16_26 = dot(vs_TEXCOORD6.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = vec3(u_xlat16_25) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_24) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * vec3(u_xlat16_26) + u_xlat0.xyz;
    u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat14.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat14.xy = u_xlat0.xy * (-u_xlat14.xx) + u_xlat2.xy;
    u_xlat14.xy = (-u_xlat0.xy) + u_xlat14.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat14.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_14 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_2.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat0.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
    u_xlat10_0.xyw = texture(_SpecularMap, u_xlat0.xy).xyz;
    u_xlat0.xyw = u_xlat10_0.xyw * vec3(_SpecularIntensity);
    u_xlat16_24 = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat1.x = (-u_xlat16_24) + _LightmapThreshold;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat1.x = (u_xlati1 != 0) ? 0.0 : 1.0;
    u_xlat1.x = u_xlat1.x + _IntensityInLightmap;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat0.xyw;
    u_xlat16_0.xyw = (-u_xlat16_4.xyz) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_0.xyz = vec3(u_xlat10_14) * u_xlat16_0.xyw + u_xlat16_5.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" "MATCAP_ON" "BUMPMAP_ON" "SPECULAR_ON" "LIGHTMAPCOLOR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" "MATCAP_ON" "BUMPMAP_ON" "SPECULAR_ON" "LIGHTMAPCOLOR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" "MATCAP_ON" "BUMPMAP_ON" "SPECULAR_ON" "LIGHTMAPCOLOR_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}