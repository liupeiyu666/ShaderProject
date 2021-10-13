//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/Lightmap_Prop_AddLight_Transparent" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_LightMapIntensity ("Light Map Intensity", Float) = 1
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
_FogTune ("Fog Tune", Range(0, 1)) = 1
[MHYHeaderBox(MATCAP)] _MatcapMaskMap ("MatcapMask Map", 2D) = "white" { }
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
[MHYHeaderBox(MATCAP SPECULAR)] [Toggle(_SEPARATE_SPECULAR_ON)] _EnableMatcapSpecular ("Enable Sperate Specular", Float) = 0
_SpecularMap ("Specular MatCap", 2D) = "black" { }
_SpecularIntensity ("Specular Intensity", Range(0, 1)) = 0
[MHYHeaderBox(ADDLIGHT)] _AdditiveLightPower ("Additive Light Power", Range(0.1, 5)) = 1
_AdditiveLightIntensity ("Additive Light Intensity", Range(0, 1)) = 1
_Transparent ("_Trans", Float) = 1
}
SubShader {
 Tags { "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARDONLY"
  Tags { "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 9253
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	mediump float _EnableMatcapSpecular;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _MetalRef;
uniform 	vec4 _SpecularMap_ST;
uniform 	float _SpecularIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _SpecularMap;
uniform lowp sampler2D _MatCap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat5 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat5 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.x = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat10_6.xyz = texture(_ShadowTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_17 = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat16_3.x = dot(vs_TEXCOORD5.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(vs_TEXCOORD6.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = u_xlat16_3.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_17) + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat10_0.w * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_6.xyz + u_xlat10_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat0.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat0.xy = u_xlat4.xy * (-u_xlat10.xx) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat4.xy) + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_MetalRef, _MetalRef)) * u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_EnableMatcapSpecular);
#else
    u_xlatb10 = 0.0<_EnableMatcapSpecular;
#endif
    if(u_xlatb10){
        u_xlat10.xy = u_xlat0.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
        u_xlat10_6.xyz = texture(_SpecularMap, u_xlat10.xy).xyz;
        u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SpecularIntensity);
    } else {
        u_xlat6.x = float(0.0);
        u_xlat6.y = float(0.0);
        u_xlat6.z = float(0.0);
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_17 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
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
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
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
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
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
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}