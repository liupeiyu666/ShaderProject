//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Toon/Base_01" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EmissionColor ("Emmisive Color", Color) = (0.5,0.5,0.5,1)
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Outline ("Outline Width", Float) = 0.02
_SpecMulti ("Specular Multiply", Float) = 1
_Shininess ("Shininess", Float) = 2
_FadeDistance ("Fade Start Distance", Float) = 0.5
_FadeOffset ("Fade Start Offset", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_Ramp ("Toon Ramp (RGB)", 2D) = "white" { }
_SpecRamp ("Specular Ramp (RGB)", 2D) = "black" { }
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 22851
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat12;
    u_xlat12 = u_xlat12 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat12 = u_xlat1.x * in_POSITION0.x + u_xlat12;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat12 = u_xlat1.x * in_POSITION0.z + u_xlat12;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat12 = u_xlat1.x * in_POSITION0.w + u_xlat12;
    u_xlat12 = (-u_xlat12) + (-_ProjectionParams.y);
    u_xlat12 = u_xlat12 + (-_FadeOffset);
    u_xlat12 = u_xlat12 / _FadeDistance;
    vs_COLOR0.w = min(u_xlat12, 1.0);
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat3.xy = vec2(u_xlat12) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5>=u_xlat3.y);
#else
    u_xlatb12 = 0.5>=u_xlat3.y;
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13) + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (bool(u_xlatb12)) ? vec2(0.0250000004, 0.0250000004) : u_xlat0.xx;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Color;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat12;
    u_xlat12 = u_xlat12 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat12 = u_xlat1.x * in_POSITION0.x + u_xlat12;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat12 = u_xlat1.x * in_POSITION0.z + u_xlat12;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat12 = u_xlat1.x * in_POSITION0.w + u_xlat12;
    u_xlat12 = (-u_xlat12) + (-_ProjectionParams.y);
    u_xlat12 = u_xlat12 + (-_FadeOffset);
    u_xlat12 = u_xlat12 / _FadeDistance;
    vs_COLOR0.w = min(u_xlat12, 1.0);
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat3.xy = vec2(u_xlat12) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5>=u_xlat3.y);
#else
    u_xlatb12 = 0.5>=u_xlat3.y;
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13) + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (bool(u_xlatb12)) ? vec2(0.0250000004, 0.0250000004) : u_xlat0.xx;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Color;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat12;
    u_xlat12 = u_xlat12 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat12 = u_xlat1.x * in_POSITION0.x + u_xlat12;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat12 = u_xlat1.x * in_POSITION0.z + u_xlat12;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat12 = u_xlat1.x * in_POSITION0.w + u_xlat12;
    u_xlat12 = (-u_xlat12) + (-_ProjectionParams.y);
    u_xlat12 = u_xlat12 + (-_FadeOffset);
    u_xlat12 = u_xlat12 / _FadeDistance;
    vs_COLOR0.w = min(u_xlat12, 1.0);
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat3.xy = vec2(u_xlat12) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5>=u_xlat3.y);
#else
    u_xlatb12 = 0.5>=u_xlat3.y;
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13) + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (bool(u_xlatb12)) ? vec2(0.0250000004, 0.0250000004) : u_xlat0.xx;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Color;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
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
}
}
 Pass {
  Name "OUTLINE"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 95114
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position.zw = u_xlat1.zw;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat3.x;
    u_xlat0.x = u_xlat3.x * in_POSITION0.x + u_xlat0.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat3.x;
    u_xlat0.x = u_xlat3.x * in_POSITION0.z + u_xlat0.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat3.x;
    u_xlat0.x = u_xlat3.x * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    vs_COLOR0.w = u_xlat0.x * _OutlineColor.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0.w = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position.zw = u_xlat1.zw;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat3.x;
    u_xlat0.x = u_xlat3.x * in_POSITION0.x + u_xlat0.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat3.x;
    u_xlat0.x = u_xlat3.x * in_POSITION0.z + u_xlat0.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat3.x;
    u_xlat0.x = u_xlat3.x * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    vs_COLOR0.w = u_xlat0.x * _OutlineColor.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0.w = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position.zw = u_xlat1.zw;
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat3.x;
    u_xlat0.x = u_xlat3.x * in_POSITION0.x + u_xlat0.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat3.x;
    u_xlat0.x = u_xlat3.x * in_POSITION0.z + u_xlat0.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat3.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat3.x;
    u_xlat0.x = u_xlat3.x * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    vs_COLOR0.w = u_xlat0.x * _OutlineColor.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0.w = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = vs_COLOR0.xyz;
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
}
}
}
Fallback "Diffuse"
}