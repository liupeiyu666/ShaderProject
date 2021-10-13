//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Dynamic Sky/Generate Weather Map" {
Properties {
_PerlineWorleyNoiseTex ("Perline-Worley Noise", 2D) = "white" { }
[Header(Cloud Coverage)] _CloudDistanceMap ("Cloud Distance Map", 2D) = "white" { }
_CloudCoverageNoiseScale ("Cloud Coverage Noise Scale", Range(0, 0.5)) = 0.1
_CloudCoverageSmoothness ("Cloud Coverage Smoothness", Range(0, 1)) = 0.2
[Header(Cloud Smoothness)] _CloudSmoothnessNoiseScale ("Cloud Smoothness Noise Scale", Range(0, 0.5)) = 0.2
[Header(Cloud Shadow)] _CloudShadowSmoothness ("Cloud Shadow Smoothness", Range(0, 1)) = 0.2
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 51061
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _CloudCoverageNoiseScale;
uniform 	float _CloudSmoothnessNoiseScale;
uniform 	vec2 _CloudDirection;
uniform 	vec2 _CloudCoverageRotateDirection;
uniform 	float _CloudCoverageElapsedTime;
uniform 	vec2 _CloudShadowStretch;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = vec4(_CloudCoverageRotateDirection.y, _CloudCoverageRotateDirection.x, _CloudDirection.y, _CloudDirection.x) * vec4(1.0, -1.0, 1.0, -1.0);
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat1.xy);
    u_xlat2.x = dot(u_xlat0.zw, u_xlat1.xy);
    u_xlat0.y = dot(vec2(_CloudCoverageRotateDirection.x, _CloudCoverageRotateDirection.y), u_xlat1.xy);
    vs_TEXCOORD0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.xy * _CloudShadowStretch.xy + vec2(0.5, 0.5);
    u_xlat2.y = dot(_CloudDirection.xy, u_xlat1.xy);
    u_xlat0 = u_xlat2.xyxy + vec4(0.5, 0.5, 0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_CloudCoverageNoiseScale) + vec2(vec2(_CloudCoverageElapsedTime, _CloudCoverageElapsedTime));
    u_xlat0 = u_xlat0 * vec4(_CloudCoverageNoiseScale, _CloudCoverageNoiseScale, _CloudSmoothnessNoiseScale, _CloudSmoothnessNoiseScale);
    u_xlat1.x = _CloudCoverageElapsedTime + _CloudCoverageElapsedTime;
    vs_TEXCOORD1.zw = u_xlat0.xy * vec2(5.0, 5.0) + u_xlat1.xx;
    vs_TEXCOORD2.xy = vec2(vec2(_CloudCoverageElapsedTime, _CloudCoverageElapsedTime)) * vec2(0.600000024, 1.20000005) + u_xlat0.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _CloudCoverageSmoothness;
uniform 	mediump float _CloudShadowSmoothness;
uniform 	float _CloudCoverage;
uniform 	float _CloudCoverageRemapped;
uniform lowp sampler2D _CloudDistanceMap;
uniform lowp sampler2D _PerlineWorleyNoiseTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
float u_xlat2;
int u_xlati2;
mediump float u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
int u_xlati4;
mediump float u_xlat16_5;
lowp float u_xlat10_6;
void main()
{
    u_xlat0 = _CloudShadowSmoothness + _CloudCoverage;
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = (-_CloudShadowSmoothness) + _CloudCoverage;
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlat0 = (-u_xlat2) + u_xlat0;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat10_4 = texture(_CloudDistanceMap, vs_TEXCOORD0.zw).y;
    u_xlat2 = (-u_xlat2) + u_xlat10_4;
    u_xlat0 = u_xlat0 * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat16_1 = (-u_xlat2) * u_xlat0 + 1.0;
    u_xlat10_0 = texture(_PerlineWorleyNoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat16_0 = u_xlat10_0 * 0.699999988;
    SV_Target0.w = (-u_xlat16_0) * u_xlat16_1 + 1.0;
    u_xlat2 = (-_CloudCoverageRemapped) + 1.0;
    u_xlat4 = u_xlat2 + _CloudCoverageSmoothness;
    u_xlat2 = u_xlat2 + (-_CloudCoverageSmoothness);
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlat4 = min(u_xlat4, 1.0);
    u_xlat4 = (-u_xlat2) + u_xlat4;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat10_6 = texture(_CloudDistanceMap, vs_TEXCOORD0.xy).x;
    u_xlat2 = (-u_xlat2) + u_xlat10_6;
    u_xlat2 = u_xlat4 * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat2 * -2.0 + 3.0;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat16_1 = u_xlat4 * u_xlat2 + u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_PerlineWorleyNoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat0 = u_xlat10_0 + -0.5;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat0; u_xlati2 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati2 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat0<0.0; u_xlati4 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati4 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlat16_3 = u_xlat0 * u_xlat0;
    u_xlati0 = (-u_xlati2) + u_xlati4;
    u_xlat16_5 = float(u_xlati0);
    u_xlat16_1 = u_xlat16_5 * u_xlat16_3 + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat16_1) + 1.0;
    u_xlat10_0 = texture(_PerlineWorleyNoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_3;
    u_xlat16_0 = u_xlat16_0 * 3.0;
    u_xlat16_0 = min(u_xlat16_0, 1.0);
    SV_Target0.z = u_xlat16_0;
    u_xlat16_3 = u_xlat16_1 * 1.25;
    SV_Target0.x = u_xlat16_1;
    u_xlat16_1 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    SV_Target0.y = u_xlat16_1 * u_xlat16_3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _CloudCoverageNoiseScale;
uniform 	float _CloudSmoothnessNoiseScale;
uniform 	vec2 _CloudDirection;
uniform 	vec2 _CloudCoverageRotateDirection;
uniform 	float _CloudCoverageElapsedTime;
uniform 	vec2 _CloudShadowStretch;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = vec4(_CloudCoverageRotateDirection.y, _CloudCoverageRotateDirection.x, _CloudDirection.y, _CloudDirection.x) * vec4(1.0, -1.0, 1.0, -1.0);
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat1.xy);
    u_xlat2.x = dot(u_xlat0.zw, u_xlat1.xy);
    u_xlat0.y = dot(vec2(_CloudCoverageRotateDirection.x, _CloudCoverageRotateDirection.y), u_xlat1.xy);
    vs_TEXCOORD0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.xy * _CloudShadowStretch.xy + vec2(0.5, 0.5);
    u_xlat2.y = dot(_CloudDirection.xy, u_xlat1.xy);
    u_xlat0 = u_xlat2.xyxy + vec4(0.5, 0.5, 0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_CloudCoverageNoiseScale) + vec2(vec2(_CloudCoverageElapsedTime, _CloudCoverageElapsedTime));
    u_xlat0 = u_xlat0 * vec4(_CloudCoverageNoiseScale, _CloudCoverageNoiseScale, _CloudSmoothnessNoiseScale, _CloudSmoothnessNoiseScale);
    u_xlat1.x = _CloudCoverageElapsedTime + _CloudCoverageElapsedTime;
    vs_TEXCOORD1.zw = u_xlat0.xy * vec2(5.0, 5.0) + u_xlat1.xx;
    vs_TEXCOORD2.xy = vec2(vec2(_CloudCoverageElapsedTime, _CloudCoverageElapsedTime)) * vec2(0.600000024, 1.20000005) + u_xlat0.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _CloudCoverageSmoothness;
uniform 	mediump float _CloudShadowSmoothness;
uniform 	float _CloudCoverage;
uniform 	float _CloudCoverageRemapped;
uniform lowp sampler2D _CloudDistanceMap;
uniform lowp sampler2D _PerlineWorleyNoiseTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
float u_xlat2;
int u_xlati2;
mediump float u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
int u_xlati4;
mediump float u_xlat16_5;
lowp float u_xlat10_6;
void main()
{
    u_xlat0 = _CloudShadowSmoothness + _CloudCoverage;
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = (-_CloudShadowSmoothness) + _CloudCoverage;
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlat0 = (-u_xlat2) + u_xlat0;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat10_4 = texture(_CloudDistanceMap, vs_TEXCOORD0.zw).y;
    u_xlat2 = (-u_xlat2) + u_xlat10_4;
    u_xlat0 = u_xlat0 * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat16_1 = (-u_xlat2) * u_xlat0 + 1.0;
    u_xlat10_0 = texture(_PerlineWorleyNoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat16_0 = u_xlat10_0 * 0.699999988;
    SV_Target0.w = (-u_xlat16_0) * u_xlat16_1 + 1.0;
    u_xlat2 = (-_CloudCoverageRemapped) + 1.0;
    u_xlat4 = u_xlat2 + _CloudCoverageSmoothness;
    u_xlat2 = u_xlat2 + (-_CloudCoverageSmoothness);
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlat4 = min(u_xlat4, 1.0);
    u_xlat4 = (-u_xlat2) + u_xlat4;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat10_6 = texture(_CloudDistanceMap, vs_TEXCOORD0.xy).x;
    u_xlat2 = (-u_xlat2) + u_xlat10_6;
    u_xlat2 = u_xlat4 * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat2 * -2.0 + 3.0;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat16_1 = u_xlat4 * u_xlat2 + u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_PerlineWorleyNoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat0 = u_xlat10_0 + -0.5;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat0; u_xlati2 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati2 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat0<0.0; u_xlati4 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati4 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlat16_3 = u_xlat0 * u_xlat0;
    u_xlati0 = (-u_xlati2) + u_xlati4;
    u_xlat16_5 = float(u_xlati0);
    u_xlat16_1 = u_xlat16_5 * u_xlat16_3 + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat16_1) + 1.0;
    u_xlat10_0 = texture(_PerlineWorleyNoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_3;
    u_xlat16_0 = u_xlat16_0 * 3.0;
    u_xlat16_0 = min(u_xlat16_0, 1.0);
    SV_Target0.z = u_xlat16_0;
    u_xlat16_3 = u_xlat16_1 * 1.25;
    SV_Target0.x = u_xlat16_1;
    u_xlat16_1 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    SV_Target0.y = u_xlat16_1 * u_xlat16_3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _CloudCoverageNoiseScale;
uniform 	float _CloudSmoothnessNoiseScale;
uniform 	vec2 _CloudDirection;
uniform 	vec2 _CloudCoverageRotateDirection;
uniform 	float _CloudCoverageElapsedTime;
uniform 	vec2 _CloudShadowStretch;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = vec4(_CloudCoverageRotateDirection.y, _CloudCoverageRotateDirection.x, _CloudDirection.y, _CloudDirection.x) * vec4(1.0, -1.0, 1.0, -1.0);
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat1.xy);
    u_xlat2.x = dot(u_xlat0.zw, u_xlat1.xy);
    u_xlat0.y = dot(vec2(_CloudCoverageRotateDirection.x, _CloudCoverageRotateDirection.y), u_xlat1.xy);
    vs_TEXCOORD0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.xy * _CloudShadowStretch.xy + vec2(0.5, 0.5);
    u_xlat2.y = dot(_CloudDirection.xy, u_xlat1.xy);
    u_xlat0 = u_xlat2.xyxy + vec4(0.5, 0.5, 0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_CloudCoverageNoiseScale) + vec2(vec2(_CloudCoverageElapsedTime, _CloudCoverageElapsedTime));
    u_xlat0 = u_xlat0 * vec4(_CloudCoverageNoiseScale, _CloudCoverageNoiseScale, _CloudSmoothnessNoiseScale, _CloudSmoothnessNoiseScale);
    u_xlat1.x = _CloudCoverageElapsedTime + _CloudCoverageElapsedTime;
    vs_TEXCOORD1.zw = u_xlat0.xy * vec2(5.0, 5.0) + u_xlat1.xx;
    vs_TEXCOORD2.xy = vec2(vec2(_CloudCoverageElapsedTime, _CloudCoverageElapsedTime)) * vec2(0.600000024, 1.20000005) + u_xlat0.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _CloudCoverageSmoothness;
uniform 	mediump float _CloudShadowSmoothness;
uniform 	float _CloudCoverage;
uniform 	float _CloudCoverageRemapped;
uniform lowp sampler2D _CloudDistanceMap;
uniform lowp sampler2D _PerlineWorleyNoiseTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
float u_xlat2;
int u_xlati2;
mediump float u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
int u_xlati4;
mediump float u_xlat16_5;
lowp float u_xlat10_6;
void main()
{
    u_xlat0 = _CloudShadowSmoothness + _CloudCoverage;
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = (-_CloudShadowSmoothness) + _CloudCoverage;
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlat0 = (-u_xlat2) + u_xlat0;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat10_4 = texture(_CloudDistanceMap, vs_TEXCOORD0.zw).y;
    u_xlat2 = (-u_xlat2) + u_xlat10_4;
    u_xlat0 = u_xlat0 * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat16_1 = (-u_xlat2) * u_xlat0 + 1.0;
    u_xlat10_0 = texture(_PerlineWorleyNoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat16_0 = u_xlat10_0 * 0.699999988;
    SV_Target0.w = (-u_xlat16_0) * u_xlat16_1 + 1.0;
    u_xlat2 = (-_CloudCoverageRemapped) + 1.0;
    u_xlat4 = u_xlat2 + _CloudCoverageSmoothness;
    u_xlat2 = u_xlat2 + (-_CloudCoverageSmoothness);
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlat4 = min(u_xlat4, 1.0);
    u_xlat4 = (-u_xlat2) + u_xlat4;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat10_6 = texture(_CloudDistanceMap, vs_TEXCOORD0.xy).x;
    u_xlat2 = (-u_xlat2) + u_xlat10_6;
    u_xlat2 = u_xlat4 * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat2 * -2.0 + 3.0;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat16_1 = u_xlat4 * u_xlat2 + u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_PerlineWorleyNoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat0 = u_xlat10_0 + -0.5;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat0; u_xlati2 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati2 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat0<0.0; u_xlati4 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati4 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlat16_3 = u_xlat0 * u_xlat0;
    u_xlati0 = (-u_xlati2) + u_xlati4;
    u_xlat16_5 = float(u_xlati0);
    u_xlat16_1 = u_xlat16_5 * u_xlat16_3 + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat16_1) + 1.0;
    u_xlat10_0 = texture(_PerlineWorleyNoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_3;
    u_xlat16_0 = u_xlat16_0 * 3.0;
    u_xlat16_0 = min(u_xlat16_0, 1.0);
    SV_Target0.z = u_xlat16_0;
    u_xlat16_3 = u_xlat16_1 * 1.25;
    SV_Target0.x = u_xlat16_1;
    u_xlat16_1 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    SV_Target0.y = u_xlat16_1 * u_xlat16_3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_FIXED_WEATHER_MAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _CloudCoverageNoiseScale;
uniform 	float _CloudSmoothnessNoiseScale;
uniform 	vec2 _CloudDirection;
uniform 	vec2 _CloudCoverageRotateDirection;
uniform 	float _CloudCoverageElapsedTime;
uniform 	vec2 _CloudShadowStretch;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = vec4(_CloudCoverageRotateDirection.y, _CloudCoverageRotateDirection.x, _CloudDirection.y, _CloudDirection.x) * vec4(1.0, -1.0, 1.0, -1.0);
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat1.xy);
    u_xlat2.x = dot(u_xlat0.zw, u_xlat1.xy);
    u_xlat0.y = dot(vec2(_CloudCoverageRotateDirection.x, _CloudCoverageRotateDirection.y), u_xlat1.xy);
    vs_TEXCOORD0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.xy * _CloudShadowStretch.xy + vec2(0.5, 0.5);
    u_xlat2.y = dot(_CloudDirection.xy, u_xlat1.xy);
    u_xlat0 = u_xlat2.xyxy + vec4(0.5, 0.5, 0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_CloudCoverageNoiseScale) + vec2(vec2(_CloudCoverageElapsedTime, _CloudCoverageElapsedTime));
    u_xlat0 = u_xlat0 * vec4(_CloudCoverageNoiseScale, _CloudCoverageNoiseScale, _CloudSmoothnessNoiseScale, _CloudSmoothnessNoiseScale);
    u_xlat1.x = _CloudCoverageElapsedTime + _CloudCoverageElapsedTime;
    vs_TEXCOORD1.zw = u_xlat0.xy * vec2(5.0, 5.0) + u_xlat1.xx;
    vs_TEXCOORD2.xy = vec2(vec2(_CloudCoverageElapsedTime, _CloudCoverageElapsedTime)) * vec2(0.600000024, 1.20000005) + u_xlat0.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _FixedWeatherMap;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_FixedWeatherMap, vs_TEXCOORD2.zw);
    SV_Target0 = u_xlat10_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_FIXED_WEATHER_MAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _CloudCoverageNoiseScale;
uniform 	float _CloudSmoothnessNoiseScale;
uniform 	vec2 _CloudDirection;
uniform 	vec2 _CloudCoverageRotateDirection;
uniform 	float _CloudCoverageElapsedTime;
uniform 	vec2 _CloudShadowStretch;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = vec4(_CloudCoverageRotateDirection.y, _CloudCoverageRotateDirection.x, _CloudDirection.y, _CloudDirection.x) * vec4(1.0, -1.0, 1.0, -1.0);
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat1.xy);
    u_xlat2.x = dot(u_xlat0.zw, u_xlat1.xy);
    u_xlat0.y = dot(vec2(_CloudCoverageRotateDirection.x, _CloudCoverageRotateDirection.y), u_xlat1.xy);
    vs_TEXCOORD0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.xy * _CloudShadowStretch.xy + vec2(0.5, 0.5);
    u_xlat2.y = dot(_CloudDirection.xy, u_xlat1.xy);
    u_xlat0 = u_xlat2.xyxy + vec4(0.5, 0.5, 0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_CloudCoverageNoiseScale) + vec2(vec2(_CloudCoverageElapsedTime, _CloudCoverageElapsedTime));
    u_xlat0 = u_xlat0 * vec4(_CloudCoverageNoiseScale, _CloudCoverageNoiseScale, _CloudSmoothnessNoiseScale, _CloudSmoothnessNoiseScale);
    u_xlat1.x = _CloudCoverageElapsedTime + _CloudCoverageElapsedTime;
    vs_TEXCOORD1.zw = u_xlat0.xy * vec2(5.0, 5.0) + u_xlat1.xx;
    vs_TEXCOORD2.xy = vec2(vec2(_CloudCoverageElapsedTime, _CloudCoverageElapsedTime)) * vec2(0.600000024, 1.20000005) + u_xlat0.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _FixedWeatherMap;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_FixedWeatherMap, vs_TEXCOORD2.zw);
    SV_Target0 = u_xlat10_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_FIXED_WEATHER_MAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _CloudCoverageNoiseScale;
uniform 	float _CloudSmoothnessNoiseScale;
uniform 	vec2 _CloudDirection;
uniform 	vec2 _CloudCoverageRotateDirection;
uniform 	float _CloudCoverageElapsedTime;
uniform 	vec2 _CloudShadowStretch;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = vec4(_CloudCoverageRotateDirection.y, _CloudCoverageRotateDirection.x, _CloudDirection.y, _CloudDirection.x) * vec4(1.0, -1.0, 1.0, -1.0);
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat1.xy);
    u_xlat2.x = dot(u_xlat0.zw, u_xlat1.xy);
    u_xlat0.y = dot(vec2(_CloudCoverageRotateDirection.x, _CloudCoverageRotateDirection.y), u_xlat1.xy);
    vs_TEXCOORD0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.xy * _CloudShadowStretch.xy + vec2(0.5, 0.5);
    u_xlat2.y = dot(_CloudDirection.xy, u_xlat1.xy);
    u_xlat0 = u_xlat2.xyxy + vec4(0.5, 0.5, 0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_CloudCoverageNoiseScale) + vec2(vec2(_CloudCoverageElapsedTime, _CloudCoverageElapsedTime));
    u_xlat0 = u_xlat0 * vec4(_CloudCoverageNoiseScale, _CloudCoverageNoiseScale, _CloudSmoothnessNoiseScale, _CloudSmoothnessNoiseScale);
    u_xlat1.x = _CloudCoverageElapsedTime + _CloudCoverageElapsedTime;
    vs_TEXCOORD1.zw = u_xlat0.xy * vec2(5.0, 5.0) + u_xlat1.xx;
    vs_TEXCOORD2.xy = vec2(vec2(_CloudCoverageElapsedTime, _CloudCoverageElapsedTime)) * vec2(0.600000024, 1.20000005) + u_xlat0.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _FixedWeatherMap;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_FixedWeatherMap, vs_TEXCOORD2.zw);
    SV_Target0 = u_xlat10_0;
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
Keywords { "_USE_FIXED_WEATHER_MAP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_FIXED_WEATHER_MAP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_FIXED_WEATHER_MAP" }
""
}
}
}
}
}