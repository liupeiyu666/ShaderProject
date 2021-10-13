//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Vertex Updown" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_Frequency ("Frequency", Float) = 1
_FrequencyMove ("FrequencyMove", Float) = 1
_Magnitude ("Magnitude", Float) = 1
_AlphaColor ("AlphaColorScale", Float) = 1
_AlphaColorPow ("AlphaColorPow", Float) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 LOD 200
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 19644
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Frequency;
uniform 	mediump float _FrequencyMove;
uniform 	mediump float _Magnitude;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat16_1 = u_xlat0.x * _FrequencyMove;
    u_xlat2.x = _Time.y * _Frequency + u_xlat16_1;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Magnitude + u_xlat0.y;
    u_xlat1 = u_xlat2.xxxx * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = u_xlat2.xxxx * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat2 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat2;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_WorldToObject[3] * u_xlat0.wwww + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0;
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _AlphaColor;
uniform 	mediump float _AlphaColorPow;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0 = vs_TEXCOORD2.y + _AlphaColor;
    u_xlat0 = u_xlat0 * _AlphaColorPow;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _TintColor.w;
    SV_Target0.w = u_xlat0;
    u_xlat16_1.xyz = _TintColor.xyz * vec3(_EmissionScaler);
    SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
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
uniform 	mediump float _Frequency;
uniform 	mediump float _FrequencyMove;
uniform 	mediump float _Magnitude;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat16_1 = u_xlat0.x * _FrequencyMove;
    u_xlat2.x = _Time.y * _Frequency + u_xlat16_1;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Magnitude + u_xlat0.y;
    u_xlat1 = u_xlat2.xxxx * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = u_xlat2.xxxx * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat2 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat2;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_WorldToObject[3] * u_xlat0.wwww + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0;
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _AlphaColor;
uniform 	mediump float _AlphaColorPow;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0 = vs_TEXCOORD2.y + _AlphaColor;
    u_xlat0 = u_xlat0 * _AlphaColorPow;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _TintColor.w;
    SV_Target0.w = u_xlat0;
    u_xlat16_1.xyz = _TintColor.xyz * vec3(_EmissionScaler);
    SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
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
uniform 	mediump float _Frequency;
uniform 	mediump float _FrequencyMove;
uniform 	mediump float _Magnitude;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat16_1 = u_xlat0.x * _FrequencyMove;
    u_xlat2.x = _Time.y * _Frequency + u_xlat16_1;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Magnitude + u_xlat0.y;
    u_xlat1 = u_xlat2.xxxx * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = u_xlat2.xxxx * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat2 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat2;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_WorldToObject[3] * u_xlat0.wwww + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0;
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _AlphaColor;
uniform 	mediump float _AlphaColorPow;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0 = vs_TEXCOORD2.y + _AlphaColor;
    u_xlat0 = u_xlat0 * _AlphaColorPow;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _TintColor.w;
    SV_Target0.w = u_xlat0;
    u_xlat16_1.xyz = _TintColor.xyz * vec3(_EmissionScaler);
    SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
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