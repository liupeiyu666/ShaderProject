//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Fragment Icon" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_MaskTex ("Mask Texture", 2D) = "white" { }
_Color ("Tint Color", Color) = (1,1,1,1)
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
  GpuProgramID 45469
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
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
    u_xlat0.zw = in_POSITION0.xy;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati2;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_11;
mediump float u_xlat16_15;
int u_xlati15;
void main()
{
    u_xlat10_0 = texture(_MaskTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xy = u_xlat10_0.ww + vec2(-0.36470589, 0.63529408);
    u_xlat16_6.x = floor(u_xlat16_1.y);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlati2 = int(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat10_0.w * 2.74193549;
    u_xlat16_11 = 1.0;
    u_xlat16_3.w = (u_xlati2 != 0) ? u_xlat16_11 : u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_3.w + 0.99000001;
    u_xlat16_6.x = floor(u_xlat16_6.x);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlati15 = int(u_xlat16_6.x);
    if((u_xlati15)==0){discard;}
    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_15 = u_xlat10_4.w * vs_COLOR0.w;
    u_xlat16_1.x = u_xlat16_1.x * 1.57407415;
    u_xlat16_1.x = u_xlat16_15 * u_xlat16_1.x;
    u_xlat16_6.xyz = u_xlat10_4.xyz * vs_COLOR0.xyz + (-u_xlat10_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = (int(u_xlati2) != 0) ? u_xlat16_1.xyz : u_xlat10_0.xyz;
    SV_Target0 = u_xlat16_3 * vs_COLOR0;
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
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
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
    u_xlat0.zw = in_POSITION0.xy;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati2;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_11;
mediump float u_xlat16_15;
int u_xlati15;
void main()
{
    u_xlat10_0 = texture(_MaskTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xy = u_xlat10_0.ww + vec2(-0.36470589, 0.63529408);
    u_xlat16_6.x = floor(u_xlat16_1.y);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlati2 = int(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat10_0.w * 2.74193549;
    u_xlat16_11 = 1.0;
    u_xlat16_3.w = (u_xlati2 != 0) ? u_xlat16_11 : u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_3.w + 0.99000001;
    u_xlat16_6.x = floor(u_xlat16_6.x);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlati15 = int(u_xlat16_6.x);
    if((u_xlati15)==0){discard;}
    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_15 = u_xlat10_4.w * vs_COLOR0.w;
    u_xlat16_1.x = u_xlat16_1.x * 1.57407415;
    u_xlat16_1.x = u_xlat16_15 * u_xlat16_1.x;
    u_xlat16_6.xyz = u_xlat10_4.xyz * vs_COLOR0.xyz + (-u_xlat10_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = (int(u_xlati2) != 0) ? u_xlat16_1.xyz : u_xlat10_0.xyz;
    SV_Target0 = u_xlat16_3 * vs_COLOR0;
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
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
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
    u_xlat0.zw = in_POSITION0.xy;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati2;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_11;
mediump float u_xlat16_15;
int u_xlati15;
void main()
{
    u_xlat10_0 = texture(_MaskTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xy = u_xlat10_0.ww + vec2(-0.36470589, 0.63529408);
    u_xlat16_6.x = floor(u_xlat16_1.y);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlati2 = int(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat10_0.w * 2.74193549;
    u_xlat16_11 = 1.0;
    u_xlat16_3.w = (u_xlati2 != 0) ? u_xlat16_11 : u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_3.w + 0.99000001;
    u_xlat16_6.x = floor(u_xlat16_6.x);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlati15 = int(u_xlat16_6.x);
    if((u_xlati15)==0){discard;}
    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_15 = u_xlat10_4.w * vs_COLOR0.w;
    u_xlat16_1.x = u_xlat16_1.x * 1.57407415;
    u_xlat16_1.x = u_xlat16_15 * u_xlat16_1.x;
    u_xlat16_6.xyz = u_xlat10_4.xyz * vs_COLOR0.xyz + (-u_xlat10_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = (int(u_xlati2) != 0) ? u_xlat16_1.xyz : u_xlat10_0.xyz;
    SV_Target0 = u_xlat16_3 * vs_COLOR0;
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
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
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
    u_xlat1.zw = in_POSITION0.xy;
    phase0_Output0_2 = u_xlat1;
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_11;
mediump float u_xlat16_15;
int u_xlati15;
void main()
{
    u_xlat10_0 = texture(_MaskTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xy = u_xlat10_0.ww + vec2(-0.36470589, 0.63529408);
    u_xlat16_6.x = floor(u_xlat16_1.y);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlati2 = int(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat10_0.w * 2.74193549;
    u_xlat16_11 = 1.0;
    u_xlat16_6.x = (u_xlati2 != 0) ? u_xlat16_11 : u_xlat16_6.x;
    u_xlat16_3 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_3 = u_xlat16_3 + (-_RMRect);
    u_xlat16_3 = u_xlat16_3 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_4 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_4 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_4;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat16_3 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_4;
    u_xlat16_11 = u_xlat16_3.y * u_xlat16_3.x;
    u_xlat16_11 = u_xlat16_3.z * u_xlat16_11;
    u_xlat16_11 = u_xlat16_3.w * u_xlat16_11;
    u_xlat16_3.w = u_xlat16_11 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11 + 0.99000001;
    u_xlat16_6.x = floor(u_xlat16_6.x);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlati15 = int(u_xlat16_6.x);
    if((u_xlati15)==0){discard;}
    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_15 = u_xlat10_4.w * vs_COLOR0.w;
    u_xlat16_1.x = u_xlat16_1.x * 1.57407415;
    u_xlat16_1.x = u_xlat16_15 * u_xlat16_1.x;
    u_xlat16_6.xyz = u_xlat10_4.xyz * vs_COLOR0.xyz + (-u_xlat10_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = (int(u_xlati2) != 0) ? u_xlat16_1.xyz : u_xlat10_0.xyz;
    SV_Target0 = u_xlat16_3 * vs_COLOR0;
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
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
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
    u_xlat1.zw = in_POSITION0.xy;
    phase0_Output0_2 = u_xlat1;
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_11;
mediump float u_xlat16_15;
int u_xlati15;
void main()
{
    u_xlat10_0 = texture(_MaskTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xy = u_xlat10_0.ww + vec2(-0.36470589, 0.63529408);
    u_xlat16_6.x = floor(u_xlat16_1.y);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlati2 = int(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat10_0.w * 2.74193549;
    u_xlat16_11 = 1.0;
    u_xlat16_6.x = (u_xlati2 != 0) ? u_xlat16_11 : u_xlat16_6.x;
    u_xlat16_3 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_3 = u_xlat16_3 + (-_RMRect);
    u_xlat16_3 = u_xlat16_3 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_4 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_4 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_4;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat16_3 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_4;
    u_xlat16_11 = u_xlat16_3.y * u_xlat16_3.x;
    u_xlat16_11 = u_xlat16_3.z * u_xlat16_11;
    u_xlat16_11 = u_xlat16_3.w * u_xlat16_11;
    u_xlat16_3.w = u_xlat16_11 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11 + 0.99000001;
    u_xlat16_6.x = floor(u_xlat16_6.x);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlati15 = int(u_xlat16_6.x);
    if((u_xlati15)==0){discard;}
    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_15 = u_xlat10_4.w * vs_COLOR0.w;
    u_xlat16_1.x = u_xlat16_1.x * 1.57407415;
    u_xlat16_1.x = u_xlat16_15 * u_xlat16_1.x;
    u_xlat16_6.xyz = u_xlat10_4.xyz * vs_COLOR0.xyz + (-u_xlat10_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = (int(u_xlati2) != 0) ? u_xlat16_1.xyz : u_xlat10_0.xyz;
    SV_Target0 = u_xlat16_3 * vs_COLOR0;
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
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
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
    u_xlat1.zw = in_POSITION0.xy;
    phase0_Output0_2 = u_xlat1;
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_11;
mediump float u_xlat16_15;
int u_xlati15;
void main()
{
    u_xlat10_0 = texture(_MaskTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xy = u_xlat10_0.ww + vec2(-0.36470589, 0.63529408);
    u_xlat16_6.x = floor(u_xlat16_1.y);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlati2 = int(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat10_0.w * 2.74193549;
    u_xlat16_11 = 1.0;
    u_xlat16_6.x = (u_xlati2 != 0) ? u_xlat16_11 : u_xlat16_6.x;
    u_xlat16_3 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_3 = u_xlat16_3 + (-_RMRect);
    u_xlat16_3 = u_xlat16_3 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_4 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_4 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_4;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat16_3 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_4;
    u_xlat16_11 = u_xlat16_3.y * u_xlat16_3.x;
    u_xlat16_11 = u_xlat16_3.z * u_xlat16_11;
    u_xlat16_11 = u_xlat16_3.w * u_xlat16_11;
    u_xlat16_3.w = u_xlat16_11 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11 + 0.99000001;
    u_xlat16_6.x = floor(u_xlat16_6.x);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlati15 = int(u_xlat16_6.x);
    if((u_xlati15)==0){discard;}
    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_15 = u_xlat10_4.w * vs_COLOR0.w;
    u_xlat16_1.x = u_xlat16_1.x * 1.57407415;
    u_xlat16_1.x = u_xlat16_15 * u_xlat16_1.x;
    u_xlat16_6.xyz = u_xlat10_4.xyz * vs_COLOR0.xyz + (-u_xlat10_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = (int(u_xlati2) != 0) ? u_xlat16_1.xyz : u_xlat10_0.xyz;
    SV_Target0 = u_xlat16_3 * vs_COLOR0;
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