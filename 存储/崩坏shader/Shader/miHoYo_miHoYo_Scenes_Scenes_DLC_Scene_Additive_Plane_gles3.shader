//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/Scene_Additive_Plane" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Mask Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Toggle(WRITEDEPTH)] _WriteDepth ("WriteDepth", Float) = 0
[Toggle(TEXTURE_SCALE)] _TextureScale ("Texture Scale", Float) = 0
_TSAspectRatio ("Texture Aspect Ratio (width : height)", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DistortionTex ("Distortion Tex", 2D) = "gray" { }
_DistortionIntensity ("Distortion Intensity", Range(0, 10)) = 5
[Toggle(LUMINANCE)] _Luminance ("Luminance", Float) = 0
_LumiFactor ("Luminance Factor", Float) = 0
_FadeDistance ("Fade Start Distance", Range(0.1, 100)) = 50
_FadeOffset ("Fade Start Offset", Range(0, 150)) = 100
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 30068
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.x + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.z + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_Target0.w = u_xlat16_0.w * vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.x + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.z + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_Target0.w = u_xlat16_0.w * vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.x + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.z + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_Target0.w = u_xlat16_0.w * vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.x + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.z + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat16_1 = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat16_1);
    SV_Target0.w = u_xlat16_0.w * vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.x + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.z + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat16_1 = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat16_1);
    SV_Target0.w = u_xlat16_0.w * vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.x + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.z + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat16_1 = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat16_1);
    SV_Target0.w = u_xlat16_0.w * vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(1.0<_TSAspectRatio);
#else
    u_xlatb1 = 1.0<_TSAspectRatio;
#endif
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.x + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.z + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + (-vs_TEXCOORD1.xy);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vec2((-vs_TEXCOORD0.x) + vs_TEXCOORD1.z, (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_Target0.w = u_xlat16_0.w * vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(1.0<_TSAspectRatio);
#else
    u_xlatb1 = 1.0<_TSAspectRatio;
#endif
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.x + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.z + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + (-vs_TEXCOORD1.xy);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vec2((-vs_TEXCOORD0.x) + vs_TEXCOORD1.z, (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_Target0.w = u_xlat16_0.w * vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(1.0<_TSAspectRatio);
#else
    u_xlatb1 = 1.0<_TSAspectRatio;
#endif
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.x + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.z + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + (-vs_TEXCOORD1.xy);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vec2((-vs_TEXCOORD0.x) + vs_TEXCOORD1.z, (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_Target0.w = u_xlat16_0.w * vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(1.0<_TSAspectRatio);
#else
    u_xlatb1 = 1.0<_TSAspectRatio;
#endif
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.x + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.z + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + (-vs_TEXCOORD1.xy);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vec2((-vs_TEXCOORD0.x) + vs_TEXCOORD1.z, (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat16_1 = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat16_1);
    SV_Target0.w = u_xlat16_0.w * vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(1.0<_TSAspectRatio);
#else
    u_xlatb1 = 1.0<_TSAspectRatio;
#endif
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.x + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.z + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + (-vs_TEXCOORD1.xy);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vec2((-vs_TEXCOORD0.x) + vs_TEXCOORD1.z, (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat16_1 = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat16_1);
    SV_Target0.w = u_xlat16_0.w * vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(1.0<_TSAspectRatio);
#else
    u_xlatb1 = 1.0<_TSAspectRatio;
#endif
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * in_POSITION0.y;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.x + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.z + u_xlat0.x;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2;
    u_xlat0.x = u_xlat2 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + (-vs_TEXCOORD1.xy);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vec2((-vs_TEXCOORD0.x) + vs_TEXCOORD1.z, (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat16_1 = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat16_1);
    SV_Target0.w = u_xlat16_0.w * vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
 Pass {
  Name "CONSTANT_MAX"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 94167
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
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
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat0 = u_xlat16_1.x + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat16_1.x = u_xlat16_1.x * _BloomFactor;
    SV_Target0.w = u_xlat16_1.x * vs_TEXCOORD1;
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
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
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
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat0 = u_xlat16_1.x + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat16_1.x = u_xlat16_1.x * _BloomFactor;
    SV_Target0.w = u_xlat16_1.x * vs_TEXCOORD1;
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
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
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
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat0 = u_xlat16_1.x + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat16_1.x = u_xlat16_1.x * _BloomFactor;
    SV_Target0.w = u_xlat16_1.x * vs_TEXCOORD1;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD2 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD2.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD2.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD2.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD2.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat0 = u_xlat16_1.x + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat16_1.x = u_xlat16_1.x * _BloomFactor;
    SV_Target0.w = u_xlat16_1.x * vs_TEXCOORD1;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD2 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD2.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD2.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD2.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD2.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat0 = u_xlat16_1.x + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat16_1.x = u_xlat16_1.x * _BloomFactor;
    SV_Target0.w = u_xlat16_1.x * vs_TEXCOORD1;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD2 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD2.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD2.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD2.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD2.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat0 = u_xlat16_1.x + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat16_1.x = u_xlat16_1.x * _BloomFactor;
    SV_Target0.w = u_xlat16_1.x * vs_TEXCOORD1;
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
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}