//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/LightMapUnityHLOD" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
_BaseColorIntensity ("BaseColorIntensity", Range(0, 3)) = 1
_BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PASSFLAGS" = "OnlyDirectional" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 61906
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat1 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat1 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat1 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat1 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat1 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat1 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat1 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat1 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat1 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat1 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat1 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat1 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat1 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat1 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat1 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat1 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat1 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat1 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat1 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat1 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat1 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat1 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_LODFade;
uniform 	mediump float _BloomIntensity;
uniform 	mediump float _BaseColorIntensity;
uniform lowp sampler2D _DitherMaskLOD2D;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat1 = fract(u_xlat0.y);
    u_xlat0.z = u_xlat1 * 0.0625 + unity_LODFade.y;
    u_xlat10_0.x = texture(_DitherMaskLOD2D, u_xlat0.xz).w;
    u_xlat0.x = u_xlat10_0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_BaseColorIntensity, _BaseColorIntensity, _BaseColorIntensity));
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
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}