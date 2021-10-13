//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/Lightning_Common" {
Properties {
_Color ("Main Color", Color) = (0.5,0.15,1,1)
_ColorLgiht ("Light Color", Color) = (1,1,1,1)
_MainTex ("MainTex (RGBA)", 2D) = "white" { }
_TimeScale ("Time Scale", Range(0, 1)) = 0.5
_ShineLoop ("Shine Loop Time", Range(0, 0.2)) = 0.05
_DirLoop ("Change Dir Loop Time", Range(0, 1)) = 0.5
_DirStrength ("Dir Move Strength", Range(0, 2)) = 0.2
_ShineSpeed ("Shine Speed", Range(0, 40)) = 20
_MoveRange ("Move Range", Range(0, 2)) = 0.1
_LightSpeed ("Light Speed", Range(0, 40)) = 20
_BloomFactor ("Bloom Factor", Float) = 1
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 50443
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _TimeScale;
uniform 	float _ShineLoop;
uniform 	float _DirLoop;
uniform 	float _MoveRange;
uniform 	float _DirStrength;
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
bool u_xlatb6;
void main()
{
    u_xlat0.x = _Time.y * _TimeScale;
    u_xlat3 = u_xlat0.x / _ShineLoop;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat3>=(-u_xlat3));
#else
    u_xlatb6 = u_xlat3>=(-u_xlat3);
#endif
    u_xlat3 = fract(abs(u_xlat3));
    u_xlat3 = (u_xlatb6) ? u_xlat3 : (-u_xlat3);
    u_xlat0.y = (-u_xlat3) * _ShineLoop + u_xlat0.x;
    u_xlat0.x = in_TEXCOORD0.x;
    u_xlat0.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_MoveRange, _MoveRange, _MoveRange));
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1.x = _Time.y / _DirLoop;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlat1.x = fract(abs(u_xlat1.x));
    u_xlat1.x = (u_xlatb4) ? u_xlat1.x : (-u_xlat1.x);
    u_xlat4.x = _DirLoop * -0.5;
    u_xlat1.x = u_xlat1.x * _DirLoop + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0>=u_xlat1.x);
#else
    u_xlatb1 = 0.0>=u_xlat1.x;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat1.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat4.x = textureLod(_MainTex, in_TEXCOORD0.xy, 0.0).w;
    u_xlat1.x = u_xlat1.x * u_xlat4.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat4.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_DirStrength, _DirStrength, _DirStrength));
    u_xlat1.w = 0.0;
    gl_Position = u_xlat0 + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _Color;
uniform 	vec4 _ColorLgiht;
uniform 	float _LightSpeed;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0.x = _Time.y * _LightSpeed;
    u_xlat0.y = vs_TEXCOORD0.x * 6.0 + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD0.x * 6.0 + (-u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.x = max(u_xlat0.x, u_xlat0.y);
    u_xlat0.x = u_xlat0.x + -0.800000012;
    u_xlat0.x = u_xlat0.x * 5.00000048;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat2 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat1 = (-_Color) + _ColorLgiht;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _Color;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _TimeScale;
uniform 	float _ShineLoop;
uniform 	float _DirLoop;
uniform 	float _MoveRange;
uniform 	float _DirStrength;
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
bool u_xlatb6;
void main()
{
    u_xlat0.x = _Time.y * _TimeScale;
    u_xlat3 = u_xlat0.x / _ShineLoop;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat3>=(-u_xlat3));
#else
    u_xlatb6 = u_xlat3>=(-u_xlat3);
#endif
    u_xlat3 = fract(abs(u_xlat3));
    u_xlat3 = (u_xlatb6) ? u_xlat3 : (-u_xlat3);
    u_xlat0.y = (-u_xlat3) * _ShineLoop + u_xlat0.x;
    u_xlat0.x = in_TEXCOORD0.x;
    u_xlat0.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_MoveRange, _MoveRange, _MoveRange));
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1.x = _Time.y / _DirLoop;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlat1.x = fract(abs(u_xlat1.x));
    u_xlat1.x = (u_xlatb4) ? u_xlat1.x : (-u_xlat1.x);
    u_xlat4.x = _DirLoop * -0.5;
    u_xlat1.x = u_xlat1.x * _DirLoop + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0>=u_xlat1.x);
#else
    u_xlatb1 = 0.0>=u_xlat1.x;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat1.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat4.x = textureLod(_MainTex, in_TEXCOORD0.xy, 0.0).w;
    u_xlat1.x = u_xlat1.x * u_xlat4.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat4.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_DirStrength, _DirStrength, _DirStrength));
    u_xlat1.w = 0.0;
    gl_Position = u_xlat0 + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _Color;
uniform 	vec4 _ColorLgiht;
uniform 	float _LightSpeed;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0.x = _Time.y * _LightSpeed;
    u_xlat0.y = vs_TEXCOORD0.x * 6.0 + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD0.x * 6.0 + (-u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.x = max(u_xlat0.x, u_xlat0.y);
    u_xlat0.x = u_xlat0.x + -0.800000012;
    u_xlat0.x = u_xlat0.x * 5.00000048;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat2 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat1 = (-_Color) + _ColorLgiht;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _Color;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _TimeScale;
uniform 	float _ShineLoop;
uniform 	float _DirLoop;
uniform 	float _MoveRange;
uniform 	float _DirStrength;
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
bool u_xlatb6;
void main()
{
    u_xlat0.x = _Time.y * _TimeScale;
    u_xlat3 = u_xlat0.x / _ShineLoop;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat3>=(-u_xlat3));
#else
    u_xlatb6 = u_xlat3>=(-u_xlat3);
#endif
    u_xlat3 = fract(abs(u_xlat3));
    u_xlat3 = (u_xlatb6) ? u_xlat3 : (-u_xlat3);
    u_xlat0.y = (-u_xlat3) * _ShineLoop + u_xlat0.x;
    u_xlat0.x = in_TEXCOORD0.x;
    u_xlat0.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_MoveRange, _MoveRange, _MoveRange));
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1.x = _Time.y / _DirLoop;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlat1.x = fract(abs(u_xlat1.x));
    u_xlat1.x = (u_xlatb4) ? u_xlat1.x : (-u_xlat1.x);
    u_xlat4.x = _DirLoop * -0.5;
    u_xlat1.x = u_xlat1.x * _DirLoop + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0>=u_xlat1.x);
#else
    u_xlatb1 = 0.0>=u_xlat1.x;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat1.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat4.x = textureLod(_MainTex, in_TEXCOORD0.xy, 0.0).w;
    u_xlat1.x = u_xlat1.x * u_xlat4.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat4.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_DirStrength, _DirStrength, _DirStrength));
    u_xlat1.w = 0.0;
    gl_Position = u_xlat0 + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _Color;
uniform 	vec4 _ColorLgiht;
uniform 	float _LightSpeed;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0.x = _Time.y * _LightSpeed;
    u_xlat0.y = vs_TEXCOORD0.x * 6.0 + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD0.x * 6.0 + (-u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.x = max(u_xlat0.x, u_xlat0.y);
    u_xlat0.x = u_xlat0.x + -0.800000012;
    u_xlat0.x = u_xlat0.x * 5.00000048;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat2 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat1 = (-_Color) + _ColorLgiht;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _Color;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
  Name "CONSTANT_MAX"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 108844
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _TimeScale;
uniform 	float _ShineLoop;
uniform 	float _DirLoop;
uniform 	float _MoveRange;
uniform 	float _DirStrength;
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out mediump float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
bool u_xlatb6;
void main()
{
    u_xlat0.x = _Time.y * _TimeScale;
    u_xlat3 = u_xlat0.x / _ShineLoop;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat3>=(-u_xlat3));
#else
    u_xlatb6 = u_xlat3>=(-u_xlat3);
#endif
    u_xlat3 = fract(abs(u_xlat3));
    u_xlat3 = (u_xlatb6) ? u_xlat3 : (-u_xlat3);
    u_xlat0.y = (-u_xlat3) * _ShineLoop + u_xlat0.x;
    u_xlat0.x = in_TEXCOORD0.x;
    u_xlat0.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_MoveRange);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1.x = _Time.y / _DirLoop;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlat1.x = fract(abs(u_xlat1.x));
    u_xlat1.x = (u_xlatb4) ? u_xlat1.x : (-u_xlat1.x);
    u_xlat4.x = _DirLoop * -0.5;
    u_xlat1.x = u_xlat1.x * _DirLoop + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0>=u_xlat1.x);
#else
    u_xlatb1 = 0.0>=u_xlat1.x;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat1.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat4.x = textureLod(_MainTex, in_TEXCOORD0.xy, 0.0).w;
    u_xlat1.x = u_xlat1.x * u_xlat4.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat4.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_DirStrength, _DirStrength, _DirStrength));
    u_xlat1.w = 0.0;
    gl_Position = u_xlat0 + u_xlat1;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _BloomFactor;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
void main()
{
    u_xlat0 = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _TimeScale;
uniform 	float _ShineLoop;
uniform 	float _DirLoop;
uniform 	float _MoveRange;
uniform 	float _DirStrength;
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out mediump float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
bool u_xlatb6;
void main()
{
    u_xlat0.x = _Time.y * _TimeScale;
    u_xlat3 = u_xlat0.x / _ShineLoop;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat3>=(-u_xlat3));
#else
    u_xlatb6 = u_xlat3>=(-u_xlat3);
#endif
    u_xlat3 = fract(abs(u_xlat3));
    u_xlat3 = (u_xlatb6) ? u_xlat3 : (-u_xlat3);
    u_xlat0.y = (-u_xlat3) * _ShineLoop + u_xlat0.x;
    u_xlat0.x = in_TEXCOORD0.x;
    u_xlat0.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_MoveRange);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1.x = _Time.y / _DirLoop;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlat1.x = fract(abs(u_xlat1.x));
    u_xlat1.x = (u_xlatb4) ? u_xlat1.x : (-u_xlat1.x);
    u_xlat4.x = _DirLoop * -0.5;
    u_xlat1.x = u_xlat1.x * _DirLoop + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0>=u_xlat1.x);
#else
    u_xlatb1 = 0.0>=u_xlat1.x;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat1.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat4.x = textureLod(_MainTex, in_TEXCOORD0.xy, 0.0).w;
    u_xlat1.x = u_xlat1.x * u_xlat4.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat4.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_DirStrength, _DirStrength, _DirStrength));
    u_xlat1.w = 0.0;
    gl_Position = u_xlat0 + u_xlat1;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _BloomFactor;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
void main()
{
    u_xlat0 = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _TimeScale;
uniform 	float _ShineLoop;
uniform 	float _DirLoop;
uniform 	float _MoveRange;
uniform 	float _DirStrength;
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out mediump float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
bool u_xlatb6;
void main()
{
    u_xlat0.x = _Time.y * _TimeScale;
    u_xlat3 = u_xlat0.x / _ShineLoop;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat3>=(-u_xlat3));
#else
    u_xlatb6 = u_xlat3>=(-u_xlat3);
#endif
    u_xlat3 = fract(abs(u_xlat3));
    u_xlat3 = (u_xlatb6) ? u_xlat3 : (-u_xlat3);
    u_xlat0.y = (-u_xlat3) * _ShineLoop + u_xlat0.x;
    u_xlat0.x = in_TEXCOORD0.x;
    u_xlat0.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_MoveRange);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1.x = _Time.y / _DirLoop;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlat1.x = fract(abs(u_xlat1.x));
    u_xlat1.x = (u_xlatb4) ? u_xlat1.x : (-u_xlat1.x);
    u_xlat4.x = _DirLoop * -0.5;
    u_xlat1.x = u_xlat1.x * _DirLoop + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0>=u_xlat1.x);
#else
    u_xlatb1 = 0.0>=u_xlat1.x;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat1.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat4.x = textureLod(_MainTex, in_TEXCOORD0.xy, 0.0).w;
    u_xlat1.x = u_xlat1.x * u_xlat4.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat4.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_DirStrength, _DirStrength, _DirStrength));
    u_xlat1.w = 0.0;
    gl_Position = u_xlat0 + u_xlat1;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _BloomFactor;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
void main()
{
    u_xlat0 = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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