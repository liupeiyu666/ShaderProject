//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_DefendShield_New" {
Properties {
_PointCirclePosition ("PointCirclePosition", Vector) = (0.2,0.39,0,0)
_PointCircleShieldPosition ("PointCircleShieldPosition", Vector) = (0,0,0,0)
_MainTex ("MainTex", 2D) = "white" { }
_MainTexIntensity ("MainTexIntensity", Float) = 1
_MainColor ("MainColor", Color) = (1,1,1,0)
_MainTexTilling ("MainTexTilling", Float) = 0
_MainTexSpeed ("MainTexSpeed", Vector) = (0,0,0,0)
_MainTexFresnel ("MainTexFresnel", Vector) = (0,1,5,0)
_MainTexDis ("MainTexDis", 2D) = "white" { }
_MainTexDisIntensity ("MainTexDisIntensity", Float) = 0
_CrackTex ("CrackTex", 2D) = "white" { }
_CrackTexIntensity ("CrackTexIntensity", Float) = 1
_CrackTexColor ("CrackTexColor", Color) = (1,0.8092361,0.01415092,0)
_PointCircleMainClip ("PointCircleMainClip", Float) = -0.22
_PointCircleWidth ("PointCircleWidth", Float) = 0.2
_PointCircleIntensity ("PointCircleIntensity", Float) = 0
_PointCircleColor ("PointCircleColor", Color) = (0,0,0,0)
_PointStep ("PointStep", Float) = 0
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 59311
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec3 _MainTexFresnel;
uniform 	vec2 _MainTexSpeed;
uniform 	float _MainTexTilling;
uniform 	vec4 _MainTexDis_ST;
uniform 	float _MainTexDisIntensity;
uniform 	float _MainTexIntensity;
uniform 	float _PointCircleMainClip;
uniform 	vec3 _PointCirclePosition;
uniform 	vec3 _PointCircleShieldPosition;
uniform 	float _PointCircleWidth;
uniform 	vec4 _PointCircleColor;
uniform 	float _PointCircleIntensity;
uniform 	float _PointStep;
uniform 	vec4 _CrackTex_ST;
uniform 	float _CrackTexIntensity;
uniform 	vec4 _CrackTexColor;
uniform 	vec4 _MainColor;
uniform lowp sampler2D _MainTexDis;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CrackTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat4;
mediump float u_xlat16_4;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
lowp float u_xlat10_9;
void main()
{
    u_xlat0.xyz = _PointCirclePosition.xyz + (-_PointCircleShieldPosition.xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = _PointCircleMainClip * -4.5 + 2.0;
    u_xlat6 = u_xlat3.x + _PointCircleWidth;
    u_xlat3.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = (-u_xlat6) + u_xlat0.x;
    u_xlat3.x = u_xlat3.x * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = _PointCircleMainClip * -4.5 + _PointCircleWidth;
    u_xlat9 = u_xlat9 + 2.20000005;
    u_xlat6 = (-u_xlat6) + u_xlat9;
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat6 = u_xlat3.x * -2.0 + 3.0;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat3.x + (-u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _PointCircleColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_PointCircleIntensity);
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(vec2(_MainTexTilling, _MainTexTilling));
    u_xlat1.xy = _Time.yy * _MainTexSpeed.xy + u_xlat1.xy;
    u_xlat7.xy = vs_TEXCOORD0.xy * _MainTexDis_ST.xy + _MainTexDis_ST.zw;
    u_xlat10_9 = texture(_MainTexDis, u_xlat7.xy).x;
    u_xlat1.xy = vec2(u_xlat10_9) * vec2(_MainTexDisIntensity) + u_xlat1.xy;
    u_xlat10_9 = texture(_MainTex, u_xlat1.xy).x;
    u_xlat16_1 = u_xlat10_9;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_4;
    u_xlat4 = float(1.0) / _PointStep;
    u_xlat4 = u_xlat4 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat1.xzw = vec3(u_xlat16_1) * _MainColor.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(vec3(_MainTexIntensity, _MainTexIntensity, _MainTexIntensity)) + u_xlat0.xyz;
    u_xlat3.x = u_xlat4 * -2.0 + 3.0;
    u_xlat6 = u_xlat4 * u_xlat4;
    u_xlat3.x = u_xlat6 * u_xlat3.x;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat2.xyz = u_xlat3.xxx * u_xlat2.xyz;
    u_xlat3.x = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _MainTexFresnel.z;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = _MainTexFresnel.y * u_xlat3.x + _MainTexFresnel.x;
    u_xlat3.x = u_xlat10_9 * u_xlat3.x;
    u_xlat0.x = u_xlat3.x * _MainTexIntensity + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat10_3.xyz = texture(_CrackTex, u_xlat3.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CrackTexIntensity);
    SV_Target0.w = u_xlat3.x * _CrackTexColor.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat3.xyz * _CrackTexColor.xyz + u_xlat1.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec3 _MainTexFresnel;
uniform 	vec2 _MainTexSpeed;
uniform 	float _MainTexTilling;
uniform 	vec4 _MainTexDis_ST;
uniform 	float _MainTexDisIntensity;
uniform 	float _MainTexIntensity;
uniform 	float _PointCircleMainClip;
uniform 	vec3 _PointCirclePosition;
uniform 	vec3 _PointCircleShieldPosition;
uniform 	float _PointCircleWidth;
uniform 	vec4 _PointCircleColor;
uniform 	float _PointCircleIntensity;
uniform 	float _PointStep;
uniform 	vec4 _CrackTex_ST;
uniform 	float _CrackTexIntensity;
uniform 	vec4 _CrackTexColor;
uniform 	vec4 _MainColor;
uniform lowp sampler2D _MainTexDis;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CrackTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat4;
mediump float u_xlat16_4;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
lowp float u_xlat10_9;
void main()
{
    u_xlat0.xyz = _PointCirclePosition.xyz + (-_PointCircleShieldPosition.xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = _PointCircleMainClip * -4.5 + 2.0;
    u_xlat6 = u_xlat3.x + _PointCircleWidth;
    u_xlat3.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = (-u_xlat6) + u_xlat0.x;
    u_xlat3.x = u_xlat3.x * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = _PointCircleMainClip * -4.5 + _PointCircleWidth;
    u_xlat9 = u_xlat9 + 2.20000005;
    u_xlat6 = (-u_xlat6) + u_xlat9;
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat6 = u_xlat3.x * -2.0 + 3.0;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat3.x + (-u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _PointCircleColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_PointCircleIntensity);
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(vec2(_MainTexTilling, _MainTexTilling));
    u_xlat1.xy = _Time.yy * _MainTexSpeed.xy + u_xlat1.xy;
    u_xlat7.xy = vs_TEXCOORD0.xy * _MainTexDis_ST.xy + _MainTexDis_ST.zw;
    u_xlat10_9 = texture(_MainTexDis, u_xlat7.xy).x;
    u_xlat1.xy = vec2(u_xlat10_9) * vec2(_MainTexDisIntensity) + u_xlat1.xy;
    u_xlat10_9 = texture(_MainTex, u_xlat1.xy).x;
    u_xlat16_1 = u_xlat10_9;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_4;
    u_xlat4 = float(1.0) / _PointStep;
    u_xlat4 = u_xlat4 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat1.xzw = vec3(u_xlat16_1) * _MainColor.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(vec3(_MainTexIntensity, _MainTexIntensity, _MainTexIntensity)) + u_xlat0.xyz;
    u_xlat3.x = u_xlat4 * -2.0 + 3.0;
    u_xlat6 = u_xlat4 * u_xlat4;
    u_xlat3.x = u_xlat6 * u_xlat3.x;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat2.xyz = u_xlat3.xxx * u_xlat2.xyz;
    u_xlat3.x = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _MainTexFresnel.z;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = _MainTexFresnel.y * u_xlat3.x + _MainTexFresnel.x;
    u_xlat3.x = u_xlat10_9 * u_xlat3.x;
    u_xlat0.x = u_xlat3.x * _MainTexIntensity + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat10_3.xyz = texture(_CrackTex, u_xlat3.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CrackTexIntensity);
    SV_Target0.w = u_xlat3.x * _CrackTexColor.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat3.xyz * _CrackTexColor.xyz + u_xlat1.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec3 _MainTexFresnel;
uniform 	vec2 _MainTexSpeed;
uniform 	float _MainTexTilling;
uniform 	vec4 _MainTexDis_ST;
uniform 	float _MainTexDisIntensity;
uniform 	float _MainTexIntensity;
uniform 	float _PointCircleMainClip;
uniform 	vec3 _PointCirclePosition;
uniform 	vec3 _PointCircleShieldPosition;
uniform 	float _PointCircleWidth;
uniform 	vec4 _PointCircleColor;
uniform 	float _PointCircleIntensity;
uniform 	float _PointStep;
uniform 	vec4 _CrackTex_ST;
uniform 	float _CrackTexIntensity;
uniform 	vec4 _CrackTexColor;
uniform 	vec4 _MainColor;
uniform lowp sampler2D _MainTexDis;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CrackTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat4;
mediump float u_xlat16_4;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
lowp float u_xlat10_9;
void main()
{
    u_xlat0.xyz = _PointCirclePosition.xyz + (-_PointCircleShieldPosition.xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = _PointCircleMainClip * -4.5 + 2.0;
    u_xlat6 = u_xlat3.x + _PointCircleWidth;
    u_xlat3.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = (-u_xlat6) + u_xlat0.x;
    u_xlat3.x = u_xlat3.x * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = _PointCircleMainClip * -4.5 + _PointCircleWidth;
    u_xlat9 = u_xlat9 + 2.20000005;
    u_xlat6 = (-u_xlat6) + u_xlat9;
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat6 = u_xlat3.x * -2.0 + 3.0;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat3.x + (-u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _PointCircleColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_PointCircleIntensity);
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(vec2(_MainTexTilling, _MainTexTilling));
    u_xlat1.xy = _Time.yy * _MainTexSpeed.xy + u_xlat1.xy;
    u_xlat7.xy = vs_TEXCOORD0.xy * _MainTexDis_ST.xy + _MainTexDis_ST.zw;
    u_xlat10_9 = texture(_MainTexDis, u_xlat7.xy).x;
    u_xlat1.xy = vec2(u_xlat10_9) * vec2(_MainTexDisIntensity) + u_xlat1.xy;
    u_xlat10_9 = texture(_MainTex, u_xlat1.xy).x;
    u_xlat16_1 = u_xlat10_9;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_4;
    u_xlat4 = float(1.0) / _PointStep;
    u_xlat4 = u_xlat4 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat1.xzw = vec3(u_xlat16_1) * _MainColor.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(vec3(_MainTexIntensity, _MainTexIntensity, _MainTexIntensity)) + u_xlat0.xyz;
    u_xlat3.x = u_xlat4 * -2.0 + 3.0;
    u_xlat6 = u_xlat4 * u_xlat4;
    u_xlat3.x = u_xlat6 * u_xlat3.x;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat2.xyz = u_xlat3.xxx * u_xlat2.xyz;
    u_xlat3.x = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _MainTexFresnel.z;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = _MainTexFresnel.y * u_xlat3.x + _MainTexFresnel.x;
    u_xlat3.x = u_xlat10_9 * u_xlat3.x;
    u_xlat0.x = u_xlat3.x * _MainTexIntensity + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat10_3.xyz = texture(_CrackTex, u_xlat3.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CrackTexIntensity);
    SV_Target0.w = u_xlat3.x * _CrackTexColor.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat3.xyz * _CrackTexColor.xyz + u_xlat1.xzw;
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
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}