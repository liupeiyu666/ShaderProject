//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/CutIn" {
Properties {
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_MainTest ("MainTest (A)", 2D) = "white" { }
_AlphaTex ("AlphaTex (A)", 2D) = "white" { }
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "AlphaTest" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "AlphaTest" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 29053
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTest_ST;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTest_ST.xy + _MainTest_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _MainTest;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
bool u_xlatb2;
void main()
{
    u_xlat0.w = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat0.w + -0.200000003;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = texture(_MainTest, vs_TEXCOORD0.xy).xyz;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _MainTest_ST;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTest_ST.xy + _MainTest_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _MainTest;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
bool u_xlatb2;
void main()
{
    u_xlat0.w = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat0.w + -0.200000003;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = texture(_MainTest, vs_TEXCOORD0.xy).xyz;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _MainTest_ST;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTest_ST.xy + _MainTest_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _MainTest;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
bool u_xlatb2;
void main()
{
    u_xlat0.w = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat0.w + -0.200000003;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = texture(_MainTest, vs_TEXCOORD0.xy).xyz;
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
}
}
}
}