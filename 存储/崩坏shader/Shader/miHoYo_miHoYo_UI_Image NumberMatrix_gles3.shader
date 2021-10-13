//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image NumberMatrix" {
Properties {
_MainTex ("Main Tex", 2D) = "white" { }
_TintColor ("Tint Color", Color) = (1,1,1,1)
_RandomTex ("Random Tex", 2D) = "white" { }
_FlowingTex ("Flowing Tex", 2D) = "white" { }
_NumberTex ("Number Tex", 2D) = "white" { }
_CellCount ("Cell Count (xy), Number Count", Vector) = (32,64,10,0)
_Speed ("Flowing Speed, Number Changing Speed", Vector) = (1,5,0,0)
_Intensity ("Global Intensity", Float) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
[Toggle(RECT_MASK)] _RectMask ("Rect Mask", Float) = 0
_RMRect ("Rect Mask Rect", Vector) = (0,0,1,1)
_RMTransitWidth ("Rect Mask Transit Width", Vector) = (0,0,0,0)
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent+1" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent+1" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 11488
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _TintColor;
uniform 	vec4 _RandomTex_TexelSize;
uniform 	vec4 _FlowingTex_TexelSize;
uniform 	vec4 _CellCount;
uniform 	vec4 _Speed;
uniform 	float _Intensity;
uniform lowp sampler2D _RandomTex;
uniform lowp sampler2D _FlowingTex;
uniform lowp sampler2D _NumberTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
void main()
{
    u_xlat0.x = _Time.y * _RandomTex_TexelSize.x;
    u_xlat1.y = vs_TEXCOORD0.x * _CellCount.x;
    u_xlat3 = u_xlat1.y * _RandomTex_TexelSize.x;
    u_xlat10_3 = texture(_RandomTex, vec2(u_xlat3)).y;
    u_xlat16_3 = u_xlat10_3 * 3.0 + 1.0;
    u_xlat0.x = u_xlat16_3 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _Speed.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _RandomTex_TexelSize.x;
    u_xlat1.x = vs_TEXCOORD0.x * _CellCount.x + u_xlat0.x;
    u_xlat0.x = _Time.y * _FlowingTex_TexelSize.x;
    u_xlat0.x = u_xlat16_3 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _Speed.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FlowingTex_TexelSize.x;
    u_xlat1.w = vs_TEXCOORD0.y * _CellCount.y + u_xlat0.x;
    u_xlat0.xy = u_xlat1.xw * _RandomTex_TexelSize.xx;
    u_xlat10_0.x = texture(_RandomTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x * _CellCount.z;
    u_xlat0.x = roundEven(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _CellCount.z;
    u_xlat6.xy = vec2(u_xlat1.y * _FlowingTex_TexelSize.x, u_xlat1.w * _FlowingTex_TexelSize.x);
    u_xlat1.x = u_xlat1.y / _CellCount.z;
    u_xlat2.xy = fract(u_xlat1.xw);
    u_xlat10_6 = texture(_FlowingTex, u_xlat6.xy).x;
    u_xlat0.y = 0.0;
    u_xlat0.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat10_0.xyw = texture(_NumberTex, u_xlat0.xy).xyz;
    u_xlat16_1 = u_xlat10_6 * u_xlat10_6;
    u_xlat16_6 = u_xlat10_6 * u_xlat16_1;
    u_xlat16_0.xyz = vec3(u_xlat16_6) * u_xlat10_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_Intensity);
    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    SV_Target0.xyz = u_xlat0.xyz;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _TintColor;
uniform 	vec4 _RandomTex_TexelSize;
uniform 	vec4 _FlowingTex_TexelSize;
uniform 	vec4 _CellCount;
uniform 	vec4 _Speed;
uniform 	float _Intensity;
uniform lowp sampler2D _RandomTex;
uniform lowp sampler2D _FlowingTex;
uniform lowp sampler2D _NumberTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
void main()
{
    u_xlat0.x = _Time.y * _RandomTex_TexelSize.x;
    u_xlat1.y = vs_TEXCOORD0.x * _CellCount.x;
    u_xlat3 = u_xlat1.y * _RandomTex_TexelSize.x;
    u_xlat10_3 = texture(_RandomTex, vec2(u_xlat3)).y;
    u_xlat16_3 = u_xlat10_3 * 3.0 + 1.0;
    u_xlat0.x = u_xlat16_3 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _Speed.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _RandomTex_TexelSize.x;
    u_xlat1.x = vs_TEXCOORD0.x * _CellCount.x + u_xlat0.x;
    u_xlat0.x = _Time.y * _FlowingTex_TexelSize.x;
    u_xlat0.x = u_xlat16_3 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _Speed.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FlowingTex_TexelSize.x;
    u_xlat1.w = vs_TEXCOORD0.y * _CellCount.y + u_xlat0.x;
    u_xlat0.xy = u_xlat1.xw * _RandomTex_TexelSize.xx;
    u_xlat10_0.x = texture(_RandomTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x * _CellCount.z;
    u_xlat0.x = roundEven(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _CellCount.z;
    u_xlat6.xy = vec2(u_xlat1.y * _FlowingTex_TexelSize.x, u_xlat1.w * _FlowingTex_TexelSize.x);
    u_xlat1.x = u_xlat1.y / _CellCount.z;
    u_xlat2.xy = fract(u_xlat1.xw);
    u_xlat10_6 = texture(_FlowingTex, u_xlat6.xy).x;
    u_xlat0.y = 0.0;
    u_xlat0.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat10_0.xyw = texture(_NumberTex, u_xlat0.xy).xyz;
    u_xlat16_1 = u_xlat10_6 * u_xlat10_6;
    u_xlat16_6 = u_xlat10_6 * u_xlat16_1;
    u_xlat16_0.xyz = vec3(u_xlat16_6) * u_xlat10_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_Intensity);
    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    SV_Target0.xyz = u_xlat0.xyz;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _TintColor;
uniform 	vec4 _RandomTex_TexelSize;
uniform 	vec4 _FlowingTex_TexelSize;
uniform 	vec4 _CellCount;
uniform 	vec4 _Speed;
uniform 	float _Intensity;
uniform lowp sampler2D _RandomTex;
uniform lowp sampler2D _FlowingTex;
uniform lowp sampler2D _NumberTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
void main()
{
    u_xlat0.x = _Time.y * _RandomTex_TexelSize.x;
    u_xlat1.y = vs_TEXCOORD0.x * _CellCount.x;
    u_xlat3 = u_xlat1.y * _RandomTex_TexelSize.x;
    u_xlat10_3 = texture(_RandomTex, vec2(u_xlat3)).y;
    u_xlat16_3 = u_xlat10_3 * 3.0 + 1.0;
    u_xlat0.x = u_xlat16_3 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _Speed.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _RandomTex_TexelSize.x;
    u_xlat1.x = vs_TEXCOORD0.x * _CellCount.x + u_xlat0.x;
    u_xlat0.x = _Time.y * _FlowingTex_TexelSize.x;
    u_xlat0.x = u_xlat16_3 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _Speed.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FlowingTex_TexelSize.x;
    u_xlat1.w = vs_TEXCOORD0.y * _CellCount.y + u_xlat0.x;
    u_xlat0.xy = u_xlat1.xw * _RandomTex_TexelSize.xx;
    u_xlat10_0.x = texture(_RandomTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x * _CellCount.z;
    u_xlat0.x = roundEven(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _CellCount.z;
    u_xlat6.xy = vec2(u_xlat1.y * _FlowingTex_TexelSize.x, u_xlat1.w * _FlowingTex_TexelSize.x);
    u_xlat1.x = u_xlat1.y / _CellCount.z;
    u_xlat2.xy = fract(u_xlat1.xw);
    u_xlat10_6 = texture(_FlowingTex, u_xlat6.xy).x;
    u_xlat0.y = 0.0;
    u_xlat0.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat10_0.xyw = texture(_NumberTex, u_xlat0.xy).xyz;
    u_xlat16_1 = u_xlat10_6 * u_xlat10_6;
    u_xlat16_6 = u_xlat10_6 * u_xlat16_1;
    u_xlat16_0.xyz = vec3(u_xlat16_6) * u_xlat10_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_Intensity);
    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RECT_MASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	vec4 _TintColor;
uniform 	vec4 _RandomTex_TexelSize;
uniform 	vec4 _FlowingTex_TexelSize;
uniform 	vec4 _CellCount;
uniform 	vec4 _Speed;
uniform 	float _Intensity;
uniform lowp sampler2D _RandomTex;
uniform lowp sampler2D _FlowingTex;
uniform lowp sampler2D _NumberTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump float u_xlat16_7;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
void main()
{
    u_xlat0.x = _Time.y * _RandomTex_TexelSize.x;
    u_xlat1.y = vs_TEXCOORD0.x * _CellCount.x;
    u_xlat4 = u_xlat1.y * _RandomTex_TexelSize.x;
    u_xlat10_4 = texture(_RandomTex, vec2(u_xlat4)).y;
    u_xlat16_4 = u_xlat10_4 * 3.0 + 1.0;
    u_xlat0.x = u_xlat16_4 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _Speed.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _RandomTex_TexelSize.x;
    u_xlat1.x = vs_TEXCOORD0.x * _CellCount.x + u_xlat0.x;
    u_xlat0.x = _Time.y * _FlowingTex_TexelSize.x;
    u_xlat0.x = u_xlat16_4 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _Speed.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FlowingTex_TexelSize.x;
    u_xlat1.w = vs_TEXCOORD0.y * _CellCount.y + u_xlat0.x;
    u_xlat0.xy = u_xlat1.xw * _RandomTex_TexelSize.xx;
    u_xlat10_0.x = texture(_RandomTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x * _CellCount.z;
    u_xlat0.x = roundEven(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _CellCount.z;
    u_xlat8.xy = vec2(u_xlat1.y * _FlowingTex_TexelSize.x, u_xlat1.w * _FlowingTex_TexelSize.x);
    u_xlat1.x = u_xlat1.y / _CellCount.z;
    u_xlat2.xy = fract(u_xlat1.xw);
    u_xlat10_8 = texture(_FlowingTex, u_xlat8.xy).x;
    u_xlat0.y = 0.0;
    u_xlat0.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat10_0.xyw = texture(_NumberTex, u_xlat0.xy).xyz;
    u_xlat16_1.x = u_xlat10_8 * u_xlat10_8;
    u_xlat16_8 = u_xlat10_8 * u_xlat16_1.x;
    u_xlat16_0.xyz = vec3(u_xlat16_8) * u_xlat10_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_Intensity);
    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
    u_xlat16_3 = dot(u_xlat0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_1 = vs_TEXCOORD5.xyxy / vs_TEXCOORD5.wwww;
    u_xlat16_1 = u_xlat16_1 + (-_RMRect);
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_2 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_2;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat16_7 = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat16_7 = u_xlat16_1.z * u_xlat16_7;
    u_xlat16_7 = u_xlat16_1.w * u_xlat16_7;
    SV_Target0.w = u_xlat16_7 * u_xlat16_3;
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_7);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RECT_MASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	vec4 _TintColor;
uniform 	vec4 _RandomTex_TexelSize;
uniform 	vec4 _FlowingTex_TexelSize;
uniform 	vec4 _CellCount;
uniform 	vec4 _Speed;
uniform 	float _Intensity;
uniform lowp sampler2D _RandomTex;
uniform lowp sampler2D _FlowingTex;
uniform lowp sampler2D _NumberTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump float u_xlat16_7;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
void main()
{
    u_xlat0.x = _Time.y * _RandomTex_TexelSize.x;
    u_xlat1.y = vs_TEXCOORD0.x * _CellCount.x;
    u_xlat4 = u_xlat1.y * _RandomTex_TexelSize.x;
    u_xlat10_4 = texture(_RandomTex, vec2(u_xlat4)).y;
    u_xlat16_4 = u_xlat10_4 * 3.0 + 1.0;
    u_xlat0.x = u_xlat16_4 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _Speed.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _RandomTex_TexelSize.x;
    u_xlat1.x = vs_TEXCOORD0.x * _CellCount.x + u_xlat0.x;
    u_xlat0.x = _Time.y * _FlowingTex_TexelSize.x;
    u_xlat0.x = u_xlat16_4 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _Speed.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FlowingTex_TexelSize.x;
    u_xlat1.w = vs_TEXCOORD0.y * _CellCount.y + u_xlat0.x;
    u_xlat0.xy = u_xlat1.xw * _RandomTex_TexelSize.xx;
    u_xlat10_0.x = texture(_RandomTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x * _CellCount.z;
    u_xlat0.x = roundEven(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _CellCount.z;
    u_xlat8.xy = vec2(u_xlat1.y * _FlowingTex_TexelSize.x, u_xlat1.w * _FlowingTex_TexelSize.x);
    u_xlat1.x = u_xlat1.y / _CellCount.z;
    u_xlat2.xy = fract(u_xlat1.xw);
    u_xlat10_8 = texture(_FlowingTex, u_xlat8.xy).x;
    u_xlat0.y = 0.0;
    u_xlat0.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat10_0.xyw = texture(_NumberTex, u_xlat0.xy).xyz;
    u_xlat16_1.x = u_xlat10_8 * u_xlat10_8;
    u_xlat16_8 = u_xlat10_8 * u_xlat16_1.x;
    u_xlat16_0.xyz = vec3(u_xlat16_8) * u_xlat10_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_Intensity);
    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
    u_xlat16_3 = dot(u_xlat0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_1 = vs_TEXCOORD5.xyxy / vs_TEXCOORD5.wwww;
    u_xlat16_1 = u_xlat16_1 + (-_RMRect);
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_2 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_2;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat16_7 = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat16_7 = u_xlat16_1.z * u_xlat16_7;
    u_xlat16_7 = u_xlat16_1.w * u_xlat16_7;
    SV_Target0.w = u_xlat16_7 * u_xlat16_3;
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_7);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RECT_MASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	vec4 _TintColor;
uniform 	vec4 _RandomTex_TexelSize;
uniform 	vec4 _FlowingTex_TexelSize;
uniform 	vec4 _CellCount;
uniform 	vec4 _Speed;
uniform 	float _Intensity;
uniform lowp sampler2D _RandomTex;
uniform lowp sampler2D _FlowingTex;
uniform lowp sampler2D _NumberTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump float u_xlat16_7;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
void main()
{
    u_xlat0.x = _Time.y * _RandomTex_TexelSize.x;
    u_xlat1.y = vs_TEXCOORD0.x * _CellCount.x;
    u_xlat4 = u_xlat1.y * _RandomTex_TexelSize.x;
    u_xlat10_4 = texture(_RandomTex, vec2(u_xlat4)).y;
    u_xlat16_4 = u_xlat10_4 * 3.0 + 1.0;
    u_xlat0.x = u_xlat16_4 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _Speed.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _RandomTex_TexelSize.x;
    u_xlat1.x = vs_TEXCOORD0.x * _CellCount.x + u_xlat0.x;
    u_xlat0.x = _Time.y * _FlowingTex_TexelSize.x;
    u_xlat0.x = u_xlat16_4 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _Speed.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FlowingTex_TexelSize.x;
    u_xlat1.w = vs_TEXCOORD0.y * _CellCount.y + u_xlat0.x;
    u_xlat0.xy = u_xlat1.xw * _RandomTex_TexelSize.xx;
    u_xlat10_0.x = texture(_RandomTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x * _CellCount.z;
    u_xlat0.x = roundEven(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _CellCount.z;
    u_xlat8.xy = vec2(u_xlat1.y * _FlowingTex_TexelSize.x, u_xlat1.w * _FlowingTex_TexelSize.x);
    u_xlat1.x = u_xlat1.y / _CellCount.z;
    u_xlat2.xy = fract(u_xlat1.xw);
    u_xlat10_8 = texture(_FlowingTex, u_xlat8.xy).x;
    u_xlat0.y = 0.0;
    u_xlat0.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat10_0.xyw = texture(_NumberTex, u_xlat0.xy).xyz;
    u_xlat16_1.x = u_xlat10_8 * u_xlat10_8;
    u_xlat16_8 = u_xlat10_8 * u_xlat16_1.x;
    u_xlat16_0.xyz = vec3(u_xlat16_8) * u_xlat10_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_Intensity);
    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
    u_xlat16_3 = dot(u_xlat0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_1 = vs_TEXCOORD5.xyxy / vs_TEXCOORD5.wwww;
    u_xlat16_1 = u_xlat16_1 + (-_RMRect);
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_2 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_2;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat16_7 = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat16_7 = u_xlat16_1.z * u_xlat16_7;
    u_xlat16_7 = u_xlat16_1.w * u_xlat16_7;
    SV_Target0.w = u_xlat16_7 * u_xlat16_3;
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_7);
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
Keywords { "RECT_MASK" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RECT_MASK" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RECT_MASK" }
""
}
}
}
}
}