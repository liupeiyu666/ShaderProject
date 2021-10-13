//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Hue and Saturate" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Hue ("Hue", Range(0, 1)) = 0
_Saturate ("Saturate", Range(0, 1)) = 0
_Intensity ("Intensity", Range(0, 1)) = 0
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
  GpuProgramID 40592
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in mediump vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Hue;
uniform 	mediump float _Saturate;
uniform 	mediump float _Intensity;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
ivec4 u_xlati0;
mediump vec4 u_xlat16_1;
int u_xlati1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_12;
int u_xlati15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.y + (-u_xlat16_1.x);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati15 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati15) != 0) ? u_xlat16_1.xy : u_xlat16_1.yx;
    u_xlat16_12.x = u_xlat10_0.z * vs_COLOR0.z + (-u_xlat16_2.x);
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati15 = int(u_xlat16_12.x);
    u_xlat16_2.x = (u_xlati15 != 0) ? u_xlat16_2.x : u_xlat16_1.z;
    u_xlat16_12.x = (-u_xlat10_0.z) * vs_COLOR0.z + u_xlat16_2.y;
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati15 = int(u_xlat16_12.x);
    u_xlat16_3.y = (u_xlati15 != 0) ? u_xlat16_2.y : u_xlat16_1.z;
    SV_Target0.w = u_xlat16_1.w;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = (-u_xlat10_0.yzx) * vs_COLOR0.yzx + u_xlat16_3.yyy;
    u_xlat16_4.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-u_xlat16_3.yyy);
    u_xlat16_4.xyz = abs(u_xlat16_4.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_4.xyz = floor(u_xlat16_4.xyz);
    u_xlati0.xyz = ivec3(u_xlat16_4.xyz);
    u_xlat16_7.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_7.xyz;
    u_xlat16_4.x = u_xlat16_2.x * 6.0;
    u_xlat16_7.xyz = u_xlat16_7.xyz / u_xlat16_4.xxx;
    u_xlat16_4.xy = u_xlat16_7.zx + vec2(0.333333343, 0.666666687);
    u_xlat16_4.xy = vec2((-u_xlat16_7.y) + u_xlat16_4.x, (-u_xlat16_7.z) + u_xlat16_4.y);
    u_xlat16_7.x = (-u_xlat16_7.x) + u_xlat16_7.y;
    u_xlat16_12.x = (u_xlati0.z != 0) ? 0.0 : u_xlat16_4.y;
    u_xlat16_12.x = (u_xlati0.y != 0) ? u_xlat16_12.x : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlati0.x != 0) ? u_xlat16_12.x : u_xlat16_7.x;
    u_xlat16_7.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_4.y = u_xlat16_2.x / u_xlat16_3.y;
    u_xlat16_2.x = floor(u_xlat16_7.x);
    u_xlati0.x = int(u_xlat16_2.x);
    u_xlat16_2.xy = (u_xlati0.x != 0) ? u_xlat16_4.xy : vec2(0.0, 0.0);
    u_xlat16_12.xy = vec2((-u_xlat16_2.x) + float(_Hue), (-u_xlat16_2.y) + float(_Saturate));
    u_xlat16_2.xy = vec2(vec2(_Intensity, _Intensity)) * u_xlat16_12.xy + u_xlat16_2.xy;
    u_xlat16_12.x = u_xlat16_2.x * 6.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_2.x = u_xlat16_2.x * 6.0 + (-u_xlat16_12.x);
    u_xlat16_17 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = (-u_xlat16_2.y) * u_xlat16_2.x + 1.0;
    u_xlat16_3.z = u_xlat16_2.x * u_xlat16_3.y;
    u_xlat16_2.x = (-u_xlat16_2.y) * u_xlat16_17 + 1.0;
    u_xlat16_7.x = (-u_xlat16_2.y) + 1.0;
    u_xlat16_4.y = u_xlat16_7.x * u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_2.x * u_xlat16_3.y;
    u_xlat16_0 = u_xlat16_12.xxxx + vec4(-1.0, -2.0, -3.0, -4.0);
    u_xlat16_2.x = abs(u_xlat16_12.x) + 0.999000013;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_0 = abs(u_xlat16_0) + vec4(0.999000013, 0.999000013, 0.999000013, 0.999000013);
    u_xlat16_0 = floor(u_xlat16_0);
    u_xlati0 = ivec4(u_xlat16_0);
    u_xlat16_4.xz = (u_xlati0.w != 0) ? u_xlat16_3.yz : u_xlat16_3.xy;
    u_xlat16_3.w = u_xlat16_4.y;
    u_xlat16_2.xyz = (u_xlati0.z != 0) ? u_xlat16_4.xyz : u_xlat16_3.wzy;
    u_xlat16_2.xyz = (u_xlati0.y != 0) ? u_xlat16_2.xyz : u_xlat16_3.wyx;
    u_xlat16_2.xyz = (u_xlati0.x != 0) ? u_xlat16_2.xyz : u_xlat16_3.zyw;
    SV_Target0.xyz = (int(u_xlati1) != 0) ? u_xlat16_2.xyz : u_xlat16_3.yxw;
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
in mediump vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Hue;
uniform 	mediump float _Saturate;
uniform 	mediump float _Intensity;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
ivec4 u_xlati0;
mediump vec4 u_xlat16_1;
int u_xlati1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_12;
int u_xlati15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.y + (-u_xlat16_1.x);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati15 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati15) != 0) ? u_xlat16_1.xy : u_xlat16_1.yx;
    u_xlat16_12.x = u_xlat10_0.z * vs_COLOR0.z + (-u_xlat16_2.x);
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati15 = int(u_xlat16_12.x);
    u_xlat16_2.x = (u_xlati15 != 0) ? u_xlat16_2.x : u_xlat16_1.z;
    u_xlat16_12.x = (-u_xlat10_0.z) * vs_COLOR0.z + u_xlat16_2.y;
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati15 = int(u_xlat16_12.x);
    u_xlat16_3.y = (u_xlati15 != 0) ? u_xlat16_2.y : u_xlat16_1.z;
    SV_Target0.w = u_xlat16_1.w;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = (-u_xlat10_0.yzx) * vs_COLOR0.yzx + u_xlat16_3.yyy;
    u_xlat16_4.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-u_xlat16_3.yyy);
    u_xlat16_4.xyz = abs(u_xlat16_4.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_4.xyz = floor(u_xlat16_4.xyz);
    u_xlati0.xyz = ivec3(u_xlat16_4.xyz);
    u_xlat16_7.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_7.xyz;
    u_xlat16_4.x = u_xlat16_2.x * 6.0;
    u_xlat16_7.xyz = u_xlat16_7.xyz / u_xlat16_4.xxx;
    u_xlat16_4.xy = u_xlat16_7.zx + vec2(0.333333343, 0.666666687);
    u_xlat16_4.xy = vec2((-u_xlat16_7.y) + u_xlat16_4.x, (-u_xlat16_7.z) + u_xlat16_4.y);
    u_xlat16_7.x = (-u_xlat16_7.x) + u_xlat16_7.y;
    u_xlat16_12.x = (u_xlati0.z != 0) ? 0.0 : u_xlat16_4.y;
    u_xlat16_12.x = (u_xlati0.y != 0) ? u_xlat16_12.x : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlati0.x != 0) ? u_xlat16_12.x : u_xlat16_7.x;
    u_xlat16_7.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_4.y = u_xlat16_2.x / u_xlat16_3.y;
    u_xlat16_2.x = floor(u_xlat16_7.x);
    u_xlati0.x = int(u_xlat16_2.x);
    u_xlat16_2.xy = (u_xlati0.x != 0) ? u_xlat16_4.xy : vec2(0.0, 0.0);
    u_xlat16_12.xy = vec2((-u_xlat16_2.x) + float(_Hue), (-u_xlat16_2.y) + float(_Saturate));
    u_xlat16_2.xy = vec2(vec2(_Intensity, _Intensity)) * u_xlat16_12.xy + u_xlat16_2.xy;
    u_xlat16_12.x = u_xlat16_2.x * 6.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_2.x = u_xlat16_2.x * 6.0 + (-u_xlat16_12.x);
    u_xlat16_17 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = (-u_xlat16_2.y) * u_xlat16_2.x + 1.0;
    u_xlat16_3.z = u_xlat16_2.x * u_xlat16_3.y;
    u_xlat16_2.x = (-u_xlat16_2.y) * u_xlat16_17 + 1.0;
    u_xlat16_7.x = (-u_xlat16_2.y) + 1.0;
    u_xlat16_4.y = u_xlat16_7.x * u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_2.x * u_xlat16_3.y;
    u_xlat16_0 = u_xlat16_12.xxxx + vec4(-1.0, -2.0, -3.0, -4.0);
    u_xlat16_2.x = abs(u_xlat16_12.x) + 0.999000013;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_0 = abs(u_xlat16_0) + vec4(0.999000013, 0.999000013, 0.999000013, 0.999000013);
    u_xlat16_0 = floor(u_xlat16_0);
    u_xlati0 = ivec4(u_xlat16_0);
    u_xlat16_4.xz = (u_xlati0.w != 0) ? u_xlat16_3.yz : u_xlat16_3.xy;
    u_xlat16_3.w = u_xlat16_4.y;
    u_xlat16_2.xyz = (u_xlati0.z != 0) ? u_xlat16_4.xyz : u_xlat16_3.wzy;
    u_xlat16_2.xyz = (u_xlati0.y != 0) ? u_xlat16_2.xyz : u_xlat16_3.wyx;
    u_xlat16_2.xyz = (u_xlati0.x != 0) ? u_xlat16_2.xyz : u_xlat16_3.zyw;
    SV_Target0.xyz = (int(u_xlati1) != 0) ? u_xlat16_2.xyz : u_xlat16_3.yxw;
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
in mediump vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Hue;
uniform 	mediump float _Saturate;
uniform 	mediump float _Intensity;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
ivec4 u_xlati0;
mediump vec4 u_xlat16_1;
int u_xlati1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_12;
int u_xlati15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.y + (-u_xlat16_1.x);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati15 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati15) != 0) ? u_xlat16_1.xy : u_xlat16_1.yx;
    u_xlat16_12.x = u_xlat10_0.z * vs_COLOR0.z + (-u_xlat16_2.x);
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati15 = int(u_xlat16_12.x);
    u_xlat16_2.x = (u_xlati15 != 0) ? u_xlat16_2.x : u_xlat16_1.z;
    u_xlat16_12.x = (-u_xlat10_0.z) * vs_COLOR0.z + u_xlat16_2.y;
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati15 = int(u_xlat16_12.x);
    u_xlat16_3.y = (u_xlati15 != 0) ? u_xlat16_2.y : u_xlat16_1.z;
    SV_Target0.w = u_xlat16_1.w;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = (-u_xlat10_0.yzx) * vs_COLOR0.yzx + u_xlat16_3.yyy;
    u_xlat16_4.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-u_xlat16_3.yyy);
    u_xlat16_4.xyz = abs(u_xlat16_4.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_4.xyz = floor(u_xlat16_4.xyz);
    u_xlati0.xyz = ivec3(u_xlat16_4.xyz);
    u_xlat16_7.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_7.xyz;
    u_xlat16_4.x = u_xlat16_2.x * 6.0;
    u_xlat16_7.xyz = u_xlat16_7.xyz / u_xlat16_4.xxx;
    u_xlat16_4.xy = u_xlat16_7.zx + vec2(0.333333343, 0.666666687);
    u_xlat16_4.xy = vec2((-u_xlat16_7.y) + u_xlat16_4.x, (-u_xlat16_7.z) + u_xlat16_4.y);
    u_xlat16_7.x = (-u_xlat16_7.x) + u_xlat16_7.y;
    u_xlat16_12.x = (u_xlati0.z != 0) ? 0.0 : u_xlat16_4.y;
    u_xlat16_12.x = (u_xlati0.y != 0) ? u_xlat16_12.x : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlati0.x != 0) ? u_xlat16_12.x : u_xlat16_7.x;
    u_xlat16_7.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_4.y = u_xlat16_2.x / u_xlat16_3.y;
    u_xlat16_2.x = floor(u_xlat16_7.x);
    u_xlati0.x = int(u_xlat16_2.x);
    u_xlat16_2.xy = (u_xlati0.x != 0) ? u_xlat16_4.xy : vec2(0.0, 0.0);
    u_xlat16_12.xy = vec2((-u_xlat16_2.x) + float(_Hue), (-u_xlat16_2.y) + float(_Saturate));
    u_xlat16_2.xy = vec2(vec2(_Intensity, _Intensity)) * u_xlat16_12.xy + u_xlat16_2.xy;
    u_xlat16_12.x = u_xlat16_2.x * 6.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_2.x = u_xlat16_2.x * 6.0 + (-u_xlat16_12.x);
    u_xlat16_17 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = (-u_xlat16_2.y) * u_xlat16_2.x + 1.0;
    u_xlat16_3.z = u_xlat16_2.x * u_xlat16_3.y;
    u_xlat16_2.x = (-u_xlat16_2.y) * u_xlat16_17 + 1.0;
    u_xlat16_7.x = (-u_xlat16_2.y) + 1.0;
    u_xlat16_4.y = u_xlat16_7.x * u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_2.x * u_xlat16_3.y;
    u_xlat16_0 = u_xlat16_12.xxxx + vec4(-1.0, -2.0, -3.0, -4.0);
    u_xlat16_2.x = abs(u_xlat16_12.x) + 0.999000013;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_0 = abs(u_xlat16_0) + vec4(0.999000013, 0.999000013, 0.999000013, 0.999000013);
    u_xlat16_0 = floor(u_xlat16_0);
    u_xlati0 = ivec4(u_xlat16_0);
    u_xlat16_4.xz = (u_xlati0.w != 0) ? u_xlat16_3.yz : u_xlat16_3.xy;
    u_xlat16_3.w = u_xlat16_4.y;
    u_xlat16_2.xyz = (u_xlati0.z != 0) ? u_xlat16_4.xyz : u_xlat16_3.wzy;
    u_xlat16_2.xyz = (u_xlati0.y != 0) ? u_xlat16_2.xyz : u_xlat16_3.wyx;
    u_xlat16_2.xyz = (u_xlati0.x != 0) ? u_xlat16_2.xyz : u_xlat16_3.zyw;
    SV_Target0.xyz = (int(u_xlati1) != 0) ? u_xlat16_2.xyz : u_xlat16_3.yxw;
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
in mediump vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump float _Hue;
uniform 	mediump float _Saturate;
uniform 	mediump float _Intensity;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
ivec4 u_xlati0;
mediump vec4 u_xlat16_1;
int u_xlati1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_12;
int u_xlati15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.y + (-u_xlat16_1.x);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati15 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati15) != 0) ? u_xlat16_1.xy : u_xlat16_1.yx;
    u_xlat16_12.x = u_xlat10_0.z * vs_COLOR0.z + (-u_xlat16_2.x);
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati15 = int(u_xlat16_12.x);
    u_xlat16_2.x = (u_xlati15 != 0) ? u_xlat16_2.x : u_xlat16_1.z;
    u_xlat16_12.x = (-u_xlat10_0.z) * vs_COLOR0.z + u_xlat16_2.y;
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati15 = int(u_xlat16_12.x);
    u_xlat16_3.y = (u_xlati15 != 0) ? u_xlat16_2.y : u_xlat16_1.z;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = (-u_xlat10_0.yzx) * vs_COLOR0.yzx + u_xlat16_3.yyy;
    u_xlat16_4.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-u_xlat16_3.yyy);
    u_xlat16_4.xyz = abs(u_xlat16_4.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_4.xyz = floor(u_xlat16_4.xyz);
    u_xlati0.xyz = ivec3(u_xlat16_4.xyz);
    u_xlat16_7.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_7.xyz;
    u_xlat16_4.x = u_xlat16_2.x * 6.0;
    u_xlat16_7.xyz = u_xlat16_7.xyz / u_xlat16_4.xxx;
    u_xlat16_4.xy = u_xlat16_7.zx + vec2(0.333333343, 0.666666687);
    u_xlat16_4.xy = vec2((-u_xlat16_7.y) + u_xlat16_4.x, (-u_xlat16_7.z) + u_xlat16_4.y);
    u_xlat16_7.x = (-u_xlat16_7.x) + u_xlat16_7.y;
    u_xlat16_12.x = (u_xlati0.z != 0) ? 0.0 : u_xlat16_4.y;
    u_xlat16_12.x = (u_xlati0.y != 0) ? u_xlat16_12.x : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlati0.x != 0) ? u_xlat16_12.x : u_xlat16_7.x;
    u_xlat16_7.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_4.y = u_xlat16_2.x / u_xlat16_3.y;
    u_xlat16_2.x = floor(u_xlat16_7.x);
    u_xlati0.x = int(u_xlat16_2.x);
    u_xlat16_2.xy = (u_xlati0.x != 0) ? u_xlat16_4.xy : vec2(0.0, 0.0);
    u_xlat16_12.xy = vec2((-u_xlat16_2.x) + float(_Hue), (-u_xlat16_2.y) + float(_Saturate));
    u_xlat16_2.xy = vec2(vec2(_Intensity, _Intensity)) * u_xlat16_12.xy + u_xlat16_2.xy;
    u_xlat16_12.x = u_xlat16_2.x * 6.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_2.x = u_xlat16_2.x * 6.0 + (-u_xlat16_12.x);
    u_xlat16_17 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = (-u_xlat16_2.y) * u_xlat16_2.x + 1.0;
    u_xlat16_3.z = u_xlat16_2.x * u_xlat16_3.y;
    u_xlat16_2.x = (-u_xlat16_2.y) * u_xlat16_17 + 1.0;
    u_xlat16_7.x = (-u_xlat16_2.y) + 1.0;
    u_xlat16_4.y = u_xlat16_7.x * u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_2.x * u_xlat16_3.y;
    u_xlat16_0 = u_xlat16_12.xxxx + vec4(-1.0, -2.0, -3.0, -4.0);
    u_xlat16_2.x = abs(u_xlat16_12.x) + 0.999000013;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_0 = abs(u_xlat16_0) + vec4(0.999000013, 0.999000013, 0.999000013, 0.999000013);
    u_xlat16_0 = floor(u_xlat16_0);
    u_xlati0 = ivec4(u_xlat16_0);
    u_xlat16_4.xz = (u_xlati0.w != 0) ? u_xlat16_3.yz : u_xlat16_3.xy;
    u_xlat16_3.w = u_xlat16_4.y;
    u_xlat16_2.xyz = (u_xlati0.z != 0) ? u_xlat16_4.xyz : u_xlat16_3.wzy;
    u_xlat16_2.xyz = (u_xlati0.y != 0) ? u_xlat16_2.xyz : u_xlat16_3.wyx;
    u_xlat16_2.xyz = (u_xlati0.x != 0) ? u_xlat16_2.xyz : u_xlat16_3.zyw;
    SV_Target0.xyz = (int(u_xlati1) != 0) ? u_xlat16_2.xyz : u_xlat16_3.yxw;
    u_xlat16_0 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_0 = u_xlat16_0 + (-_RMRect);
    u_xlat16_0 = u_xlat16_0 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_2 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_2;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_2.x = u_xlat16_0.y * u_xlat16_0.x;
    u_xlat16_2.x = u_xlat16_0.z * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_1.w * u_xlat16_2.x;
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
in mediump vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump float _Hue;
uniform 	mediump float _Saturate;
uniform 	mediump float _Intensity;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
ivec4 u_xlati0;
mediump vec4 u_xlat16_1;
int u_xlati1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_12;
int u_xlati15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.y + (-u_xlat16_1.x);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati15 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati15) != 0) ? u_xlat16_1.xy : u_xlat16_1.yx;
    u_xlat16_12.x = u_xlat10_0.z * vs_COLOR0.z + (-u_xlat16_2.x);
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati15 = int(u_xlat16_12.x);
    u_xlat16_2.x = (u_xlati15 != 0) ? u_xlat16_2.x : u_xlat16_1.z;
    u_xlat16_12.x = (-u_xlat10_0.z) * vs_COLOR0.z + u_xlat16_2.y;
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati15 = int(u_xlat16_12.x);
    u_xlat16_3.y = (u_xlati15 != 0) ? u_xlat16_2.y : u_xlat16_1.z;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = (-u_xlat10_0.yzx) * vs_COLOR0.yzx + u_xlat16_3.yyy;
    u_xlat16_4.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-u_xlat16_3.yyy);
    u_xlat16_4.xyz = abs(u_xlat16_4.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_4.xyz = floor(u_xlat16_4.xyz);
    u_xlati0.xyz = ivec3(u_xlat16_4.xyz);
    u_xlat16_7.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_7.xyz;
    u_xlat16_4.x = u_xlat16_2.x * 6.0;
    u_xlat16_7.xyz = u_xlat16_7.xyz / u_xlat16_4.xxx;
    u_xlat16_4.xy = u_xlat16_7.zx + vec2(0.333333343, 0.666666687);
    u_xlat16_4.xy = vec2((-u_xlat16_7.y) + u_xlat16_4.x, (-u_xlat16_7.z) + u_xlat16_4.y);
    u_xlat16_7.x = (-u_xlat16_7.x) + u_xlat16_7.y;
    u_xlat16_12.x = (u_xlati0.z != 0) ? 0.0 : u_xlat16_4.y;
    u_xlat16_12.x = (u_xlati0.y != 0) ? u_xlat16_12.x : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlati0.x != 0) ? u_xlat16_12.x : u_xlat16_7.x;
    u_xlat16_7.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_4.y = u_xlat16_2.x / u_xlat16_3.y;
    u_xlat16_2.x = floor(u_xlat16_7.x);
    u_xlati0.x = int(u_xlat16_2.x);
    u_xlat16_2.xy = (u_xlati0.x != 0) ? u_xlat16_4.xy : vec2(0.0, 0.0);
    u_xlat16_12.xy = vec2((-u_xlat16_2.x) + float(_Hue), (-u_xlat16_2.y) + float(_Saturate));
    u_xlat16_2.xy = vec2(vec2(_Intensity, _Intensity)) * u_xlat16_12.xy + u_xlat16_2.xy;
    u_xlat16_12.x = u_xlat16_2.x * 6.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_2.x = u_xlat16_2.x * 6.0 + (-u_xlat16_12.x);
    u_xlat16_17 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = (-u_xlat16_2.y) * u_xlat16_2.x + 1.0;
    u_xlat16_3.z = u_xlat16_2.x * u_xlat16_3.y;
    u_xlat16_2.x = (-u_xlat16_2.y) * u_xlat16_17 + 1.0;
    u_xlat16_7.x = (-u_xlat16_2.y) + 1.0;
    u_xlat16_4.y = u_xlat16_7.x * u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_2.x * u_xlat16_3.y;
    u_xlat16_0 = u_xlat16_12.xxxx + vec4(-1.0, -2.0, -3.0, -4.0);
    u_xlat16_2.x = abs(u_xlat16_12.x) + 0.999000013;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_0 = abs(u_xlat16_0) + vec4(0.999000013, 0.999000013, 0.999000013, 0.999000013);
    u_xlat16_0 = floor(u_xlat16_0);
    u_xlati0 = ivec4(u_xlat16_0);
    u_xlat16_4.xz = (u_xlati0.w != 0) ? u_xlat16_3.yz : u_xlat16_3.xy;
    u_xlat16_3.w = u_xlat16_4.y;
    u_xlat16_2.xyz = (u_xlati0.z != 0) ? u_xlat16_4.xyz : u_xlat16_3.wzy;
    u_xlat16_2.xyz = (u_xlati0.y != 0) ? u_xlat16_2.xyz : u_xlat16_3.wyx;
    u_xlat16_2.xyz = (u_xlati0.x != 0) ? u_xlat16_2.xyz : u_xlat16_3.zyw;
    SV_Target0.xyz = (int(u_xlati1) != 0) ? u_xlat16_2.xyz : u_xlat16_3.yxw;
    u_xlat16_0 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_0 = u_xlat16_0 + (-_RMRect);
    u_xlat16_0 = u_xlat16_0 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_2 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_2;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_2.x = u_xlat16_0.y * u_xlat16_0.x;
    u_xlat16_2.x = u_xlat16_0.z * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_1.w * u_xlat16_2.x;
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
in mediump vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump float _Hue;
uniform 	mediump float _Saturate;
uniform 	mediump float _Intensity;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
ivec4 u_xlati0;
mediump vec4 u_xlat16_1;
int u_xlati1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_12;
int u_xlati15;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.y + (-u_xlat16_1.x);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati15 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati15) != 0) ? u_xlat16_1.xy : u_xlat16_1.yx;
    u_xlat16_12.x = u_xlat10_0.z * vs_COLOR0.z + (-u_xlat16_2.x);
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati15 = int(u_xlat16_12.x);
    u_xlat16_2.x = (u_xlati15 != 0) ? u_xlat16_2.x : u_xlat16_1.z;
    u_xlat16_12.x = (-u_xlat10_0.z) * vs_COLOR0.z + u_xlat16_2.y;
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati15 = int(u_xlat16_12.x);
    u_xlat16_3.y = (u_xlati15 != 0) ? u_xlat16_2.y : u_xlat16_1.z;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = (-u_xlat10_0.yzx) * vs_COLOR0.yzx + u_xlat16_3.yyy;
    u_xlat16_4.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-u_xlat16_3.yyy);
    u_xlat16_4.xyz = abs(u_xlat16_4.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_4.xyz = floor(u_xlat16_4.xyz);
    u_xlati0.xyz = ivec3(u_xlat16_4.xyz);
    u_xlat16_7.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_7.xyz;
    u_xlat16_4.x = u_xlat16_2.x * 6.0;
    u_xlat16_7.xyz = u_xlat16_7.xyz / u_xlat16_4.xxx;
    u_xlat16_4.xy = u_xlat16_7.zx + vec2(0.333333343, 0.666666687);
    u_xlat16_4.xy = vec2((-u_xlat16_7.y) + u_xlat16_4.x, (-u_xlat16_7.z) + u_xlat16_4.y);
    u_xlat16_7.x = (-u_xlat16_7.x) + u_xlat16_7.y;
    u_xlat16_12.x = (u_xlati0.z != 0) ? 0.0 : u_xlat16_4.y;
    u_xlat16_12.x = (u_xlati0.y != 0) ? u_xlat16_12.x : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlati0.x != 0) ? u_xlat16_12.x : u_xlat16_7.x;
    u_xlat16_7.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_4.y = u_xlat16_2.x / u_xlat16_3.y;
    u_xlat16_2.x = floor(u_xlat16_7.x);
    u_xlati0.x = int(u_xlat16_2.x);
    u_xlat16_2.xy = (u_xlati0.x != 0) ? u_xlat16_4.xy : vec2(0.0, 0.0);
    u_xlat16_12.xy = vec2((-u_xlat16_2.x) + float(_Hue), (-u_xlat16_2.y) + float(_Saturate));
    u_xlat16_2.xy = vec2(vec2(_Intensity, _Intensity)) * u_xlat16_12.xy + u_xlat16_2.xy;
    u_xlat16_12.x = u_xlat16_2.x * 6.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_2.x = u_xlat16_2.x * 6.0 + (-u_xlat16_12.x);
    u_xlat16_17 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = (-u_xlat16_2.y) * u_xlat16_2.x + 1.0;
    u_xlat16_3.z = u_xlat16_2.x * u_xlat16_3.y;
    u_xlat16_2.x = (-u_xlat16_2.y) * u_xlat16_17 + 1.0;
    u_xlat16_7.x = (-u_xlat16_2.y) + 1.0;
    u_xlat16_4.y = u_xlat16_7.x * u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_2.x * u_xlat16_3.y;
    u_xlat16_0 = u_xlat16_12.xxxx + vec4(-1.0, -2.0, -3.0, -4.0);
    u_xlat16_2.x = abs(u_xlat16_12.x) + 0.999000013;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_0 = abs(u_xlat16_0) + vec4(0.999000013, 0.999000013, 0.999000013, 0.999000013);
    u_xlat16_0 = floor(u_xlat16_0);
    u_xlati0 = ivec4(u_xlat16_0);
    u_xlat16_4.xz = (u_xlati0.w != 0) ? u_xlat16_3.yz : u_xlat16_3.xy;
    u_xlat16_3.w = u_xlat16_4.y;
    u_xlat16_2.xyz = (u_xlati0.z != 0) ? u_xlat16_4.xyz : u_xlat16_3.wzy;
    u_xlat16_2.xyz = (u_xlati0.y != 0) ? u_xlat16_2.xyz : u_xlat16_3.wyx;
    u_xlat16_2.xyz = (u_xlati0.x != 0) ? u_xlat16_2.xyz : u_xlat16_3.zyw;
    SV_Target0.xyz = (int(u_xlati1) != 0) ? u_xlat16_2.xyz : u_xlat16_3.yxw;
    u_xlat16_0 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_0 = u_xlat16_0 + (-_RMRect);
    u_xlat16_0 = u_xlat16_0 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_2 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_2;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_2.x = u_xlat16_0.y * u_xlat16_0.x;
    u_xlat16_2.x = u_xlat16_0.z * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_1.w * u_xlat16_2.x;
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