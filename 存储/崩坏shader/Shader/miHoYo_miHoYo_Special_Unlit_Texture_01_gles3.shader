//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Unlit/Texture_01" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_FadeDistance ("Fade Start Distance", Float) = 0.5
_FadeOffset ("Fade Start Offset", Float) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 10998
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_COLOR0.w = min(u_xlat0.x, 1.0);
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat10_0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat10_0.xyz;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_COLOR0.w = min(u_xlat0.x, 1.0);
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat10_0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat10_0.xyz;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_COLOR0.w = min(u_xlat0.x, 1.0);
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat10_0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat10_0.xyz;
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