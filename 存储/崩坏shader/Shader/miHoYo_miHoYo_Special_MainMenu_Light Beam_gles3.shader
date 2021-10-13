//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/MainMenu/Light Beam" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_LongitudinalIntensityTex ("Longitudinal Intensity Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_WidthRatio ("Width Ratio", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 35012
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _WidthRatio;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LongitudinalIntensityTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + -0.5;
    u_xlat2 = _WidthRatio + -1.0;
    u_xlat2 = vs_TEXCOORD0.y * u_xlat2 + 1.0;
    u_xlat0 = u_xlat2 * 0.5 + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat2;
    u_xlat10_0 = texture(_MainTex, vec2(u_xlat0)).x;
    u_xlat16_1 = u_xlat10_0 * _EmissionScaler;
    u_xlat10_0 = texture(_LongitudinalIntensityTex, vs_TEXCOORD0.yy).x;
    u_xlat16_1 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _WidthRatio;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LongitudinalIntensityTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + -0.5;
    u_xlat2 = _WidthRatio + -1.0;
    u_xlat2 = vs_TEXCOORD0.y * u_xlat2 + 1.0;
    u_xlat0 = u_xlat2 * 0.5 + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat2;
    u_xlat10_0 = texture(_MainTex, vec2(u_xlat0)).x;
    u_xlat16_1 = u_xlat10_0 * _EmissionScaler;
    u_xlat10_0 = texture(_LongitudinalIntensityTex, vs_TEXCOORD0.yy).x;
    u_xlat16_1 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _WidthRatio;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LongitudinalIntensityTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + -0.5;
    u_xlat2 = _WidthRatio + -1.0;
    u_xlat2 = vs_TEXCOORD0.y * u_xlat2 + 1.0;
    u_xlat0 = u_xlat2 * 0.5 + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat2;
    u_xlat10_0 = texture(_MainTex, vec2(u_xlat0)).x;
    u_xlat16_1 = u_xlat10_0 * _EmissionScaler;
    u_xlat10_0 = texture(_LongitudinalIntensityTex, vs_TEXCOORD0.yy).x;
    u_xlat16_1 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 115133
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	float _WidthRatio;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LongitudinalIntensityTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + -0.5;
    u_xlat2 = _WidthRatio + -1.0;
    u_xlat2 = vs_TEXCOORD0.y * u_xlat2 + 1.0;
    u_xlat0 = u_xlat2 * 0.5 + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat2;
    u_xlat10_0 = texture(_MainTex, vec2(u_xlat0)).x;
    u_xlat16_1 = u_xlat10_0 * _BloomFactor;
    u_xlat10_0 = texture(_LongitudinalIntensityTex, vs_TEXCOORD0.yy).x;
    SV_Target0.w = u_xlat10_0 * u_xlat16_1;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	float _WidthRatio;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LongitudinalIntensityTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + -0.5;
    u_xlat2 = _WidthRatio + -1.0;
    u_xlat2 = vs_TEXCOORD0.y * u_xlat2 + 1.0;
    u_xlat0 = u_xlat2 * 0.5 + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat2;
    u_xlat10_0 = texture(_MainTex, vec2(u_xlat0)).x;
    u_xlat16_1 = u_xlat10_0 * _BloomFactor;
    u_xlat10_0 = texture(_LongitudinalIntensityTex, vs_TEXCOORD0.yy).x;
    SV_Target0.w = u_xlat10_0 * u_xlat16_1;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	float _WidthRatio;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LongitudinalIntensityTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + -0.5;
    u_xlat2 = _WidthRatio + -1.0;
    u_xlat2 = vs_TEXCOORD0.y * u_xlat2 + 1.0;
    u_xlat0 = u_xlat2 * 0.5 + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat2;
    u_xlat10_0 = texture(_MainTex, vec2(u_xlat0)).x;
    u_xlat16_1 = u_xlat10_0 * _BloomFactor;
    u_xlat10_0 = texture(_LongitudinalIntensityTex, vs_TEXCOORD0.yy).x;
    SV_Target0.w = u_xlat10_0 * u_xlat16_1;
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
}