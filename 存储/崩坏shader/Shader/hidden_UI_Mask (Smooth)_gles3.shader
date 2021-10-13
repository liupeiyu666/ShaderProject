//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "hidden/UI/Mask (Smooth)" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_MaskTex ("Mask Texture", 2D) = "white" { }
_Color ("Tint Color", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(1, 3)) = 1
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
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 2114
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_NORMAL0.x;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
void main()
{
    u_xlat10_0.x = texture(_MaskTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_0.x + -1.0;
    u_xlat16_1 = vs_TEXCOORD2 * u_xlat16_1 + 1.0;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * vec4(_EmissionScaler);
    u_xlat16_3 = u_xlat16_0.w * u_xlat16_1 + -0.00999999978;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_NORMAL0.x;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
void main()
{
    u_xlat10_0.x = texture(_MaskTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_0.x + -1.0;
    u_xlat16_1 = vs_TEXCOORD2 * u_xlat16_1 + 1.0;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * vec4(_EmissionScaler);
    u_xlat16_3 = u_xlat16_0.w * u_xlat16_1 + -0.00999999978;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_NORMAL0.x;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
void main()
{
    u_xlat10_0.x = texture(_MaskTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_0.x + -1.0;
    u_xlat16_1 = vs_TEXCOORD2 * u_xlat16_1 + 1.0;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * vec4(_EmissionScaler);
    u_xlat16_3 = u_xlat16_0.w * u_xlat16_1 + -0.00999999978;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
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
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat1;
    vs_TEXCOORD2 = in_NORMAL0.x;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_6;
void main()
{
    u_xlat16_0 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_0 = u_xlat16_0 + (-_RMRect);
    u_xlat16_0 = u_xlat16_0 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_1 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_0.x = u_xlat16_0.y * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.z * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.w * u_xlat16_0.x;
    u_xlat10_2 = texture(_MaskTex, vs_TEXCOORD1.xy).w;
    u_xlat16_3 = u_xlat10_2 + -1.0;
    u_xlat16_3 = vs_TEXCOORD2 * u_xlat16_3 + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * vec4(_EmissionScaler);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.w;
    SV_Target0.xyz = u_xlat16_1.xyz;
    u_xlat16_6 = u_xlat16_3 * u_xlat16_0.x + -0.00999999978;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3;
    SV_Target0.w = u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_6<0.0);
#else
    u_xlatb2 = u_xlat16_6<0.0;
#endif
    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
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
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat1;
    vs_TEXCOORD2 = in_NORMAL0.x;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_6;
void main()
{
    u_xlat16_0 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_0 = u_xlat16_0 + (-_RMRect);
    u_xlat16_0 = u_xlat16_0 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_1 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_0.x = u_xlat16_0.y * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.z * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.w * u_xlat16_0.x;
    u_xlat10_2 = texture(_MaskTex, vs_TEXCOORD1.xy).w;
    u_xlat16_3 = u_xlat10_2 + -1.0;
    u_xlat16_3 = vs_TEXCOORD2 * u_xlat16_3 + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * vec4(_EmissionScaler);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.w;
    SV_Target0.xyz = u_xlat16_1.xyz;
    u_xlat16_6 = u_xlat16_3 * u_xlat16_0.x + -0.00999999978;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3;
    SV_Target0.w = u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_6<0.0);
#else
    u_xlatb2 = u_xlat16_6<0.0;
#endif
    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
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
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat1;
    vs_TEXCOORD2 = in_NORMAL0.x;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_6;
void main()
{
    u_xlat16_0 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_0 = u_xlat16_0 + (-_RMRect);
    u_xlat16_0 = u_xlat16_0 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_1 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_0.x = u_xlat16_0.y * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.z * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.w * u_xlat16_0.x;
    u_xlat10_2 = texture(_MaskTex, vs_TEXCOORD1.xy).w;
    u_xlat16_3 = u_xlat10_2 + -1.0;
    u_xlat16_3 = vs_TEXCOORD2 * u_xlat16_3 + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * vec4(_EmissionScaler);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.w;
    SV_Target0.xyz = u_xlat16_1.xyz;
    u_xlat16_6 = u_xlat16_3 * u_xlat16_0.x + -0.00999999978;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3;
    SV_Target0.w = u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_6<0.0);
#else
    u_xlatb2 = u_xlat16_6<0.0;
#endif
    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
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