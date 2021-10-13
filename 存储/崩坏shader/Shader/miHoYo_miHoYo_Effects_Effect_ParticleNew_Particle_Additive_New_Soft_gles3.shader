//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Particle_Additive_New_Soft" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_DepthCt ("DepthCt", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DistortionTex ("Distortion Tex", 2D) = "gray" { }
_DistortionIntensity ("Distortion Intensity", Range(0, 10)) = 5
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 25229
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _DepthCt;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_4 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat10_4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthCt;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat16_3 = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler);
    u_xlat0.x = u_xlat0.x * u_xlat16_3;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _DepthCt;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_4 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat10_4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthCt;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat16_3 = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler);
    u_xlat0.x = u_xlat0.x * u_xlat16_3;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _DepthCt;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_4 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat10_4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthCt;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat16_3 = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler);
    u_xlat0.x = u_xlat0.x * u_xlat16_3;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform 	float _DepthCt;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_4 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat10_4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthCt;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat16_3.x = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler);
    u_xlat16_13 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_EmissionScaler) + vec3(u_xlat16_13);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform 	float _DepthCt;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_4 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat10_4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthCt;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat16_3.x = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler);
    u_xlat16_13 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_EmissionScaler) + vec3(u_xlat16_13);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform 	float _DepthCt;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_4 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat10_4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthCt;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat16_3.x = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler);
    u_xlat16_13 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_EmissionScaler) + vec3(u_xlat16_13);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _DepthCt;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_4 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat10_4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthCt;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat16_3 = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler);
    u_xlat0.x = u_xlat0.x * u_xlat16_3;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _DepthCt;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_4 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat10_4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthCt;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat16_3 = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler);
    u_xlat0.x = u_xlat0.x * u_xlat16_3;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _DepthCt;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_4 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat10_4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthCt;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat16_3 = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler);
    u_xlat0.x = u_xlat0.x * u_xlat16_3;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform 	float _DepthCt;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_4 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat10_4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthCt;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat16_3.x = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler);
    u_xlat16_13 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_EmissionScaler) + vec3(u_xlat16_13);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform 	float _DepthCt;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_4 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat10_4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthCt;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat16_3.x = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler);
    u_xlat16_13 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_EmissionScaler) + vec3(u_xlat16_13);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform 	float _DepthCt;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_4 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat10_4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthCt;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat16_3.x = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler);
    u_xlat16_13 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_EmissionScaler) + vec3(u_xlat16_13);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
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
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}