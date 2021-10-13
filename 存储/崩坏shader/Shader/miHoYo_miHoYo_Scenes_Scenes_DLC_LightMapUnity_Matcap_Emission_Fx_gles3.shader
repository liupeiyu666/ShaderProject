//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/LightMapUnity_Matcap_Emission_Fx" {
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
_EmissionMask ("Emission Mask", 2D) = "black" { }
[Enum(R,0,G,1,B,2)] _UseChannel ("Use Channel", Float) = 1
[Enum(UV1st,0,UV2nd,1)] _UseSet ("UV Set", Float) = 1
_Emission ("Emission Mask Color", Color) = (0,0,0,0.5)
_EmissionMaskIntensity ("Emission Mask Intensity", Float) = 1
_EmissionGIIntensity ("Emission GI Intensity", Range(0, 10)) = 2
[MHYHeaderBox(ADDLIGHT)] _AdditiveLightPower ("Additive Light Power", Range(0.1, 5)) = 1
_AdditiveLightIntensity ("Additive Light Intensity", Range(0, 1)) = 1
[MHYHeaderBox(EMISSIONMASKTEX)] _EmissionMaskTex ("Emission MaskTex", 2D) = "white" { }
_EmissionMaskTexSpeed ("Emission MaskTex Speed", Vector) = (0,0,0,0)
_EmissionMaskTexIntensity ("EmissionMask Tex Intensity", Float) = 1
_Transparent ("_Trans", Range(0, 1)) = 1
}
SubShader {
 Tags { "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 24431
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_17 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat3.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_17 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat3.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_17 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat3.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_17 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat3.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_17 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat3.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_17 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat3.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5.x = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5.x * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_17 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat3.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5.x = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5.x * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_17 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat3.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5.x = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5.x * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_17 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat3.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5.x = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5.x * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_17 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat3.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5.x = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5.x * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_17 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat3.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5.x = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5.x * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_17 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat3.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5.x = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5.x * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5.x = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5.x * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5.x = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5.x * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5.x = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5.x * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5.x = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5.x * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5.x = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5.x * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb2 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat10_2 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_16 = u_xlat10_2;
    } else {
        u_xlat16_16 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_3.x = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = (-u_xlat16_3.x) * u_xlat16_16 + 1.0;
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat2.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat2.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat2.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb2 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat10_2 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_16 = u_xlat10_2;
    } else {
        u_xlat16_16 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_3.x = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = (-u_xlat16_3.x) * u_xlat16_16 + 1.0;
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat2.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat2.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat2.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb2 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat10_2 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_16 = u_xlat10_2;
    } else {
        u_xlat16_16 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_3.x = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = (-u_xlat16_3.x) * u_xlat16_16 + 1.0;
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat2.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat2.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat2.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb2 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat10_2 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_16 = u_xlat10_2;
    } else {
        u_xlat16_16 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_3.x = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = (-u_xlat16_3.x) * u_xlat16_16 + 1.0;
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat2.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat2.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat2.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb2 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat10_2 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_16 = u_xlat10_2;
    } else {
        u_xlat16_16 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_3.x = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = (-u_xlat16_3.x) * u_xlat16_16 + 1.0;
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat2.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat2.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat2.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb2 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat10_2 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_16 = u_xlat10_2;
    } else {
        u_xlat16_16 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_3.x = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = (-u_xlat16_3.x) * u_xlat16_16 + 1.0;
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_16 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_16 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_16;
    u_xlat0.x = u_xlat16_16 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat2.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat2.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat2.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
bvec2 u_xlatb12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb18 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb18){
        u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat10_18 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_18;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_9.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_4.x = u_xlat10_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat6.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_UseChannel==2);
#else
    u_xlatb18 = _UseChannel==2;
#endif
    u_xlat16_21 = float(_UseChannel);
    u_xlat16_22 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_22 + u_xlat10_0.x;
    u_xlat16_21 = (u_xlatb18) ? u_xlat10_0.z : u_xlat16_21;
    u_xlat0.x = u_xlat16_21 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_18 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_18 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_5.xyz;
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
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
bvec2 u_xlatb12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb18 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb18){
        u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat10_18 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_18;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_9.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_4.x = u_xlat10_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat6.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_UseChannel==2);
#else
    u_xlatb18 = _UseChannel==2;
#endif
    u_xlat16_21 = float(_UseChannel);
    u_xlat16_22 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_22 + u_xlat10_0.x;
    u_xlat16_21 = (u_xlatb18) ? u_xlat10_0.z : u_xlat16_21;
    u_xlat0.x = u_xlat16_21 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_18 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_18 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_5.xyz;
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
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
bvec2 u_xlatb12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb18 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb18){
        u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat10_18 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_18;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_9.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_4.x = u_xlat10_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat6.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_UseChannel==2);
#else
    u_xlatb18 = _UseChannel==2;
#endif
    u_xlat16_21 = float(_UseChannel);
    u_xlat16_22 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_22 + u_xlat10_0.x;
    u_xlat16_21 = (u_xlatb18) ? u_xlat10_0.z : u_xlat16_21;
    u_xlat0.x = u_xlat16_21 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_18 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_18 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_5.xyz;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
bvec2 u_xlatb12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb18 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb18){
        u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat10_18 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_18;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_9.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_4.x = u_xlat10_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat6.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_UseChannel==2);
#else
    u_xlatb18 = _UseChannel==2;
#endif
    u_xlat16_21 = float(_UseChannel);
    u_xlat16_22 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_22 + u_xlat10_0.x;
    u_xlat16_21 = (u_xlatb18) ? u_xlat10_0.z : u_xlat16_21;
    u_xlat0.x = u_xlat16_21 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_18 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_18 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_5.xyz;
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
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
bvec2 u_xlatb12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb18 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb18){
        u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat10_18 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_18;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_9.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_4.x = u_xlat10_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat6.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_UseChannel==2);
#else
    u_xlatb18 = _UseChannel==2;
#endif
    u_xlat16_21 = float(_UseChannel);
    u_xlat16_22 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_22 + u_xlat10_0.x;
    u_xlat16_21 = (u_xlatb18) ? u_xlat10_0.z : u_xlat16_21;
    u_xlat0.x = u_xlat16_21 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_18 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_18 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_5.xyz;
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
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
bvec2 u_xlatb12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb18 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb18){
        u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat10_18 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_18;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_9.xyz = u_xlat10_0.xyz * _ShadowColor.xyz;
    u_xlat16_4.x = u_xlat10_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat6.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_UseChannel==2);
#else
    u_xlatb18 = _UseChannel==2;
#endif
    u_xlat16_21 = float(_UseChannel);
    u_xlat16_22 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_22 + u_xlat10_0.x;
    u_xlat16_21 = (u_xlatb18) ? u_xlat10_0.z : u_xlat16_21;
    u_xlat0.x = u_xlat16_21 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_18 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_18 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_5.xyz;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
lowp float u_xlat10_10;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat10.xy * vec2(0.25, 0.25);
    u_xlat10.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat10.x * 0.0625 + unity_LODFade.y;
    u_xlat10_10 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat10.x = u_xlat10_10 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(u_xlat10.x<0.0);
#else
    u_xlatb10.x = u_xlat10.x<0.0;
#endif
    if((int(u_xlatb10.x) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb10.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb10.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_17 = u_xlat10_0.x;
    } else {
        u_xlat16_17 = 1.0;
    //ENDIF
    }
    u_xlat16_2.xyz = u_xlat16_2.xyz * _ShadowColor.xyz;
    u_xlat16_3.x = unity_Lightmap_HDR.x * u_xlat16_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_17 = (-u_xlat16_17) + 1.0;
    u_xlat16_17 = (-u_xlat16_3.x) * u_xlat16_17 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat10_6.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
lowp float u_xlat10_10;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat10.xy * vec2(0.25, 0.25);
    u_xlat10.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat10.x * 0.0625 + unity_LODFade.y;
    u_xlat10_10 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat10.x = u_xlat10_10 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(u_xlat10.x<0.0);
#else
    u_xlatb10.x = u_xlat10.x<0.0;
#endif
    if((int(u_xlatb10.x) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb10.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb10.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_17 = u_xlat10_0.x;
    } else {
        u_xlat16_17 = 1.0;
    //ENDIF
    }
    u_xlat16_2.xyz = u_xlat16_2.xyz * _ShadowColor.xyz;
    u_xlat16_3.x = unity_Lightmap_HDR.x * u_xlat16_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_17 = (-u_xlat16_17) + 1.0;
    u_xlat16_17 = (-u_xlat16_3.x) * u_xlat16_17 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat10_6.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
lowp float u_xlat10_10;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat10.xy * vec2(0.25, 0.25);
    u_xlat10.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat10.x * 0.0625 + unity_LODFade.y;
    u_xlat10_10 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat10.x = u_xlat10_10 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(u_xlat10.x<0.0);
#else
    u_xlatb10.x = u_xlat10.x<0.0;
#endif
    if((int(u_xlatb10.x) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb10.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb10.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_17 = u_xlat10_0.x;
    } else {
        u_xlat16_17 = 1.0;
    //ENDIF
    }
    u_xlat16_2.xyz = u_xlat16_2.xyz * _ShadowColor.xyz;
    u_xlat16_3.x = unity_Lightmap_HDR.x * u_xlat16_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_17 = (-u_xlat16_17) + 1.0;
    u_xlat16_17 = (-u_xlat16_3.x) * u_xlat16_17 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat10_6.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
lowp float u_xlat10_10;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat10.xy * vec2(0.25, 0.25);
    u_xlat10.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat10.x * 0.0625 + unity_LODFade.y;
    u_xlat10_10 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat10.x = u_xlat10_10 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(u_xlat10.x<0.0);
#else
    u_xlatb10.x = u_xlat10.x<0.0;
#endif
    if((int(u_xlatb10.x) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb10.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb10.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_17 = u_xlat10_0.x;
    } else {
        u_xlat16_17 = 1.0;
    //ENDIF
    }
    u_xlat16_2.xyz = u_xlat16_2.xyz * _ShadowColor.xyz;
    u_xlat16_3.x = unity_Lightmap_HDR.x * u_xlat16_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_17 = (-u_xlat16_17) + 1.0;
    u_xlat16_17 = (-u_xlat16_3.x) * u_xlat16_17 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat10_6.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
lowp float u_xlat10_10;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat10.xy * vec2(0.25, 0.25);
    u_xlat10.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat10.x * 0.0625 + unity_LODFade.y;
    u_xlat10_10 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat10.x = u_xlat10_10 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(u_xlat10.x<0.0);
#else
    u_xlatb10.x = u_xlat10.x<0.0;
#endif
    if((int(u_xlatb10.x) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb10.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb10.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_17 = u_xlat10_0.x;
    } else {
        u_xlat16_17 = 1.0;
    //ENDIF
    }
    u_xlat16_2.xyz = u_xlat16_2.xyz * _ShadowColor.xyz;
    u_xlat16_3.x = unity_Lightmap_HDR.x * u_xlat16_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_17 = (-u_xlat16_17) + 1.0;
    u_xlat16_17 = (-u_xlat16_3.x) * u_xlat16_17 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat10_6.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
lowp float u_xlat10_10;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
mediump float u_xlat16_17;
mediump float u_xlat16_18;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat10.xy * vec2(0.25, 0.25);
    u_xlat10.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat10.x * 0.0625 + unity_LODFade.y;
    u_xlat10_10 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat10.x = u_xlat10_10 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(u_xlat10.x<0.0);
#else
    u_xlatb10.x = u_xlat10.x<0.0;
#endif
    if((int(u_xlatb10.x) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb10.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb10.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_17 = u_xlat10_0.x;
    } else {
        u_xlat16_17 = 1.0;
    //ENDIF
    }
    u_xlat16_2.xyz = u_xlat16_2.xyz * _ShadowColor.xyz;
    u_xlat16_3.x = unity_Lightmap_HDR.x * u_xlat16_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_17 = (-u_xlat16_17) + 1.0;
    u_xlat16_17 = (-u_xlat16_3.x) * u_xlat16_17 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat10_6.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UseChannel==2);
#else
    u_xlatb15 = _UseChannel==2;
#endif
    u_xlat16_17 = float(_UseChannel);
    u_xlat16_18 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_18 + u_xlat10_0.x;
    u_xlat16_17 = (u_xlatb15) ? u_xlat10_0.z : u_xlat16_17;
    u_xlat0.x = u_xlat16_17 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_15 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
lowp float u_xlat10_12;
bvec2 u_xlatb12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat12.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat12.xy * vec2(0.25, 0.25);
    u_xlat12.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat12.x * 0.0625 + unity_LODFade.y;
    u_xlat10_12 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat12.x = u_xlat10_12 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(u_xlat12.x<0.0);
#else
    u_xlatb12.x = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12.x) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_3.x = u_xlat10_0.x;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_9.xyz = u_xlat10_1.xyz * _ShadowColor.xyz;
    u_xlat16_4.x = u_xlat10_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat6.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_UseChannel==2);
#else
    u_xlatb18 = _UseChannel==2;
#endif
    u_xlat16_21 = float(_UseChannel);
    u_xlat16_22 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_22 + u_xlat10_0.x;
    u_xlat16_21 = (u_xlatb18) ? u_xlat10_0.z : u_xlat16_21;
    u_xlat0.x = u_xlat16_21 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_18 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_18 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_5.xyz;
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
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
lowp float u_xlat10_12;
bvec2 u_xlatb12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat12.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat12.xy * vec2(0.25, 0.25);
    u_xlat12.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat12.x * 0.0625 + unity_LODFade.y;
    u_xlat10_12 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat12.x = u_xlat10_12 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(u_xlat12.x<0.0);
#else
    u_xlatb12.x = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12.x) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_3.x = u_xlat10_0.x;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_9.xyz = u_xlat10_1.xyz * _ShadowColor.xyz;
    u_xlat16_4.x = u_xlat10_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat6.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_UseChannel==2);
#else
    u_xlatb18 = _UseChannel==2;
#endif
    u_xlat16_21 = float(_UseChannel);
    u_xlat16_22 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_22 + u_xlat10_0.x;
    u_xlat16_21 = (u_xlatb18) ? u_xlat10_0.z : u_xlat16_21;
    u_xlat0.x = u_xlat16_21 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_18 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_18 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_5.xyz;
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
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[16];
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
lowp float u_xlat10_12;
bvec2 u_xlatb12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat12.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat12.xy * vec2(0.25, 0.25);
    u_xlat12.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat12.x * 0.0625 + unity_LODFade.y;
    u_xlat10_12 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat12.x = u_xlat10_12 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(u_xlat12.x<0.0);
#else
    u_xlatb12.x = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12.x) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_3.x = u_xlat10_0.x;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_9.xyz = u_xlat10_1.xyz * _ShadowColor.xyz;
    u_xlat16_4.x = u_xlat10_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat6.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_UseChannel==2);
#else
    u_xlatb18 = _UseChannel==2;
#endif
    u_xlat16_21 = float(_UseChannel);
    u_xlat16_22 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_22 + u_xlat10_0.x;
    u_xlat16_21 = (u_xlatb18) ? u_xlat10_0.z : u_xlat16_21;
    u_xlat0.x = u_xlat16_21 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_18 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_18 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_5.xyz;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
lowp float u_xlat10_12;
bvec2 u_xlatb12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat12.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat12.xy * vec2(0.25, 0.25);
    u_xlat12.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat12.x * 0.0625 + unity_LODFade.y;
    u_xlat10_12 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat12.x = u_xlat10_12 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(u_xlat12.x<0.0);
#else
    u_xlatb12.x = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12.x) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_3.x = u_xlat10_0.x;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_9.xyz = u_xlat10_1.xyz * _ShadowColor.xyz;
    u_xlat16_4.x = u_xlat10_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat6.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_UseChannel==2);
#else
    u_xlatb18 = _UseChannel==2;
#endif
    u_xlat16_21 = float(_UseChannel);
    u_xlat16_22 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_22 + u_xlat10_0.x;
    u_xlat16_21 = (u_xlatb18) ? u_xlat10_0.z : u_xlat16_21;
    u_xlat0.x = u_xlat16_21 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_18 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_18 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_5.xyz;
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
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
lowp float u_xlat10_12;
bvec2 u_xlatb12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat12.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat12.xy * vec2(0.25, 0.25);
    u_xlat12.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat12.x * 0.0625 + unity_LODFade.y;
    u_xlat10_12 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat12.x = u_xlat10_12 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(u_xlat12.x<0.0);
#else
    u_xlatb12.x = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12.x) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_3.x = u_xlat10_0.x;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_9.xyz = u_xlat10_1.xyz * _ShadowColor.xyz;
    u_xlat16_4.x = u_xlat10_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat6.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_UseChannel==2);
#else
    u_xlatb18 = _UseChannel==2;
#endif
    u_xlat16_21 = float(_UseChannel);
    u_xlat16_22 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_22 + u_xlat10_0.x;
    u_xlat16_21 = (u_xlatb18) ? u_xlat10_0.z : u_xlat16_21;
    u_xlat0.x = u_xlat16_21 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_18 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_18 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_5.xyz;
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
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	float _EmissionMaskIntensity;
uniform 	vec4 _EmissionMaskTex_ST;
uniform 	vec2 _EmissionMaskTexSpeed;
uniform 	float _EmissionMaskTexIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseChannel;
uniform 	int _UseSet;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _EmissionMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
uint u_xlatu0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
lowp float u_xlat10_12;
bvec2 u_xlatb12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
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
        u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat12.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat1.xy = u_xlat12.xy * vec2(0.25, 0.25);
    u_xlat12.x = fract(u_xlat1.y);
    u_xlat1.z = u_xlat12.x * 0.0625 + unity_LODFade.y;
    u_xlat10_12 = texture(_DitherMaskLOD2D, u_xlat1.xz).w;
    u_xlat12.x = u_xlat10_12 + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(u_xlat12.x<0.0);
#else
    u_xlatb12.x = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12.x) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12.x){
        u_xlat10_0.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat0.xy).x;
        u_xlat16_3.x = u_xlat10_0.x;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_9.xyz = u_xlat10_1.xyz * _ShadowColor.xyz;
    u_xlat16_4.x = u_xlat10_1.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-u_xlat16_4.x) * u_xlat16_3.x + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat0.x = float(_UseSet);
    u_xlat6.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_UseChannel==2);
#else
    u_xlatb18 = _UseChannel==2;
#endif
    u_xlat16_21 = float(_UseChannel);
    u_xlat16_22 = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_22 + u_xlat10_0.x;
    u_xlat16_21 = (u_xlatb18) ? u_xlat10_0.z : u_xlat16_21;
    u_xlat0.x = u_xlat16_21 * _EmissionMaskIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _Emission.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Emission.www;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EmissionMaskTex_ST.xy + _EmissionMaskTex_ST.zw;
    u_xlat1.xy = _Time.yy * _EmissionMaskTexSpeed.xy + u_xlat1.xy;
    u_xlat10_18 = texture(_EmissionMaskTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_18 * _EmissionMaskTexIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_5.xyz;
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
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Meta/META"
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}