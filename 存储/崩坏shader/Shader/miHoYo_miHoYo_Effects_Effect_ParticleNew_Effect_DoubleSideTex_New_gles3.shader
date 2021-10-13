//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_DoubleSideTex_New" {
Properties {
_FrontTex ("FrontTex", 2D) = "white" { }
_FrontColor ("FrontColor", Color) = (1,1,1,0)
_FrontIntensity ("FrontIntensity", Float) = 1
_BackTex ("BackTex", 2D) = "white" { }
_BackColor ("BackColor", Color) = (1,1,1,0)
_BackIntensity ("BackIntensity", Float) = 1
[Enum(r, 0, a, 1)] _Channel ("AlphaChannel", Float) = 0
[Enum(Add, 1, AlphaBlend,5)] _SrcBlend ("Src Blend Mode", Float) = 1
[Enum(Add, 1, AlphaBlend, 10)] _DstBlend ("Dst Blend Mode", Float) = 1
[Enum(Off, 0, On, 1)] _ZWrite ("ZWrite", Float) = 0
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 61273
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _FrontTex_ST;
uniform 	float _FrontIntensity;
uniform 	vec4 _FrontColor;
uniform 	vec4 _BackTex_ST;
uniform 	vec4 _BackColor;
uniform 	float _BackIntensity;
uniform 	float _Channel;
uniform lowp sampler2D _FrontTex;
uniform lowp sampler2D _BackTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _FrontTex_ST.xy + _FrontTex_ST.zw;
    u_xlat10_0 = texture(_FrontTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vec4(_FrontIntensity);
    u_xlat0 = u_xlat0 * _FrontColor;
    u_xlat1.xy = vs_TEXCOORD0.xy * _BackTex_ST.xy + _BackTex_ST.zw;
    u_xlat10_1 = texture(_BackTex, u_xlat1.xy);
    u_xlat1 = u_xlat10_1 * _BackColor;
    u_xlat1 = u_xlat1 * vec4(_BackIntensity);
    u_xlat0 = (uint((gl_FrontFacing ? 0xffffffffu : uint(0))) != uint(0u)) ? u_xlat0 : u_xlat1;
    u_xlat1.xy = u_xlat0.xw * vs_COLOR0.ww;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlatb0.xy = equal(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_2 = (u_xlatb0.y) ? u_xlat1.y : 0.0;
    SV_Target0.w = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _FrontTex_ST;
uniform 	float _FrontIntensity;
uniform 	vec4 _FrontColor;
uniform 	vec4 _BackTex_ST;
uniform 	vec4 _BackColor;
uniform 	float _BackIntensity;
uniform 	float _Channel;
uniform lowp sampler2D _FrontTex;
uniform lowp sampler2D _BackTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _FrontTex_ST.xy + _FrontTex_ST.zw;
    u_xlat10_0 = texture(_FrontTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vec4(_FrontIntensity);
    u_xlat0 = u_xlat0 * _FrontColor;
    u_xlat1.xy = vs_TEXCOORD0.xy * _BackTex_ST.xy + _BackTex_ST.zw;
    u_xlat10_1 = texture(_BackTex, u_xlat1.xy);
    u_xlat1 = u_xlat10_1 * _BackColor;
    u_xlat1 = u_xlat1 * vec4(_BackIntensity);
    u_xlat0 = (uint((gl_FrontFacing ? 0xffffffffu : uint(0))) != uint(0u)) ? u_xlat0 : u_xlat1;
    u_xlat1.xy = u_xlat0.xw * vs_COLOR0.ww;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlatb0.xy = equal(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_2 = (u_xlatb0.y) ? u_xlat1.y : 0.0;
    SV_Target0.w = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _FrontTex_ST;
uniform 	float _FrontIntensity;
uniform 	vec4 _FrontColor;
uniform 	vec4 _BackTex_ST;
uniform 	vec4 _BackColor;
uniform 	float _BackIntensity;
uniform 	float _Channel;
uniform lowp sampler2D _FrontTex;
uniform lowp sampler2D _BackTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _FrontTex_ST.xy + _FrontTex_ST.zw;
    u_xlat10_0 = texture(_FrontTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vec4(_FrontIntensity);
    u_xlat0 = u_xlat0 * _FrontColor;
    u_xlat1.xy = vs_TEXCOORD0.xy * _BackTex_ST.xy + _BackTex_ST.zw;
    u_xlat10_1 = texture(_BackTex, u_xlat1.xy);
    u_xlat1 = u_xlat10_1 * _BackColor;
    u_xlat1 = u_xlat1 * vec4(_BackIntensity);
    u_xlat0 = (uint((gl_FrontFacing ? 0xffffffffu : uint(0))) != uint(0u)) ? u_xlat0 : u_xlat1;
    u_xlat1.xy = u_xlat0.xw * vs_COLOR0.ww;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlatb0.xy = equal(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_2 = (u_xlatb0.y) ? u_xlat1.y : 0.0;
    SV_Target0.w = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2;
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