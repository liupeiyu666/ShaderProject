//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/Unlit/Opaque (texture+color+fog+stereo support)" {
Properties {
_MainTex ("Base (RGB)", 2D) = "black" { }
_ChromaTex ("Chroma", 2D) = "gray" { }
_Color ("Main Color", Color) = (1,1,1,1)
[KeywordEnum(None, Top_Bottom, Left_Right, Custom_UV)] Stereo ("Stereo Mode", Float) = 0
[Toggle(STEREO_DEBUG)] _StereoDebug ("Stereo Debug Tinting", Float) = 0
[Toggle(APPLY_GAMMA)] _ApplyGamma ("Apply Gamma", Float) = 0
[Toggle(USE_YPCBCR)] _UseYpCbCr ("Use YpCbCr", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 18399
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
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
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
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
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
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
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
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
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
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
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
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
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
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
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
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
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
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
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
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
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
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
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
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
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat0.x = (u_xlatb0) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat0.x : u_xlat2.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat0.x = (u_xlatb0) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat0.x : u_xlat2.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat0.x = (u_xlatb0) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat0.x : u_xlat2.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat0.x = (u_xlatb0) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat0.x : u_xlat2.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat0.x = (u_xlatb0) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat0.x : u_xlat2.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat0.x = (u_xlatb0) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat0.x : u_xlat2.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat0.x = (u_xlatb0) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat0.x : u_xlat2.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat0.x = (u_xlatb0) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat0.x : u_xlat2.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat0.x = (u_xlatb0) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat0.x : u_xlat2.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat0.x = (u_xlatb0) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat0.x : u_xlat2.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat0.x = (u_xlatb0) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat0.x : u_xlat2.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat0.x = (u_xlatb0) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat0.x : u_xlat2.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat2.x = (u_xlatb4) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat2.x = (u_xlatb4) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat2.x = (u_xlatb4) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat2.x = (u_xlatb4) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat2.x = (u_xlatb4) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat2.x = (u_xlatb4) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat2.x = (u_xlatb4) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat2.x = (u_xlatb4) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat2.x = (u_xlatb4) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat2.x = (u_xlatb4) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat2.x = (u_xlatb4) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat2.x = (u_xlatb4) ? 0.0 : 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MainTex_ST.y>=0.0);
#else
    u_xlatb4 = _MainTex_ST.y>=0.0;
#endif
    u_xlat0.y = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(1.0, 0.5) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.x = u_xlatb4 ? 0.5 : float(0.0);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat4.xy * vec2(0.5, 1.0) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat0.y;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb4;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat0.y);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat0.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    vs_COLOR0 = (bool(u_xlatb0)) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
}
}
}
}