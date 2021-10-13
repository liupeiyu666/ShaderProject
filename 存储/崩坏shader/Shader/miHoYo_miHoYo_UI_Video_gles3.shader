//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Video" {
Properties {
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
[Toggle(_FLIP_X)] _flipX ("flip x", Float) = 0
[Toggle(_FLIP_Y)] _flipY ("flip y", Float) = 0
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 13210
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _flipX;
uniform 	mediump float _flipY;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_flipX, _flipY, _flipX, _flipX)).xy;
    u_xlat16_1.xy = (-vs_TEXCOORD0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = (u_xlatb0.x) ? u_xlat16_1.x : vs_TEXCOORD0.x;
    u_xlat16_1.y = (u_xlatb0.y) ? u_xlat16_1.y : vs_TEXCOORD0.y;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat16_1.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz;
    SV_Target0.w = _BloomFactor;
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
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _flipX;
uniform 	mediump float _flipY;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_flipX, _flipY, _flipX, _flipX)).xy;
    u_xlat16_1.xy = (-vs_TEXCOORD0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = (u_xlatb0.x) ? u_xlat16_1.x : vs_TEXCOORD0.x;
    u_xlat16_1.y = (u_xlatb0.y) ? u_xlat16_1.y : vs_TEXCOORD0.y;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat16_1.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz;
    SV_Target0.w = _BloomFactor;
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
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _flipX;
uniform 	mediump float _flipY;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_flipX, _flipY, _flipX, _flipX)).xy;
    u_xlat16_1.xy = (-vs_TEXCOORD0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = (u_xlatb0.x) ? u_xlat16_1.x : vs_TEXCOORD0.x;
    u_xlat16_1.y = (u_xlatb0.y) ? u_xlat16_1.y : vs_TEXCOORD0.y;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat16_1.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz;
    SV_Target0.w = _BloomFactor;
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