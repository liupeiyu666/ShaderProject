//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Multi-Layer 2" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Color0 ("Tint 0", Color) = (1,1,1,1)
_Color1 ("Tint 1", Color) = (1,1,1,1)
_Tex0 ("Tex 0", 2D) = "white" { }
_Tex1 ("Tex 1", 2D) = "white" { }
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
  GpuProgramID 55268
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
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
    u_xlat16_2 = in_TEXCOORD0.x + 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    vs_COLOR0.x = ceil(u_xlat16_2);
    u_xlat16_2 = in_TEXCOORD1.x + 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    vs_COLOR0.y = ceil(u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color0;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _Tex0;
uniform lowp sampler2D _Tex1;
in mediump vec2 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat10_0 = texture(_Tex0, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color0;
    u_xlat16_1.x = u_xlat16_0.w * vs_COLOR0.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_13 = (-u_xlat16_0.w) * vs_COLOR0.x + 1.0;
    u_xlat10_0 = texture(_Tex1, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color1.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.x = u_xlat10_0.w * _Color1.w;
    u_xlat16_14 = u_xlat16_0.x * vs_COLOR0.y;
    u_xlat16_3 = (-u_xlat16_0.x) * vs_COLOR0.y + 1.0;
    SV_Target0.w = (-u_xlat16_13) * u_xlat16_3 + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + u_xlat16_1.xyz;
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
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
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
    u_xlat16_2 = in_TEXCOORD0.x + 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    vs_COLOR0.x = ceil(u_xlat16_2);
    u_xlat16_2 = in_TEXCOORD1.x + 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    vs_COLOR0.y = ceil(u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color0;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _Tex0;
uniform lowp sampler2D _Tex1;
in mediump vec2 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat10_0 = texture(_Tex0, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color0;
    u_xlat16_1.x = u_xlat16_0.w * vs_COLOR0.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_13 = (-u_xlat16_0.w) * vs_COLOR0.x + 1.0;
    u_xlat10_0 = texture(_Tex1, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color1.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.x = u_xlat10_0.w * _Color1.w;
    u_xlat16_14 = u_xlat16_0.x * vs_COLOR0.y;
    u_xlat16_3 = (-u_xlat16_0.x) * vs_COLOR0.y + 1.0;
    SV_Target0.w = (-u_xlat16_13) * u_xlat16_3 + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + u_xlat16_1.xyz;
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
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
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
    u_xlat16_2 = in_TEXCOORD0.x + 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    vs_COLOR0.x = ceil(u_xlat16_2);
    u_xlat16_2 = in_TEXCOORD1.x + 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    vs_COLOR0.y = ceil(u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color0;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _Tex0;
uniform lowp sampler2D _Tex1;
in mediump vec2 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat10_0 = texture(_Tex0, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color0;
    u_xlat16_1.x = u_xlat16_0.w * vs_COLOR0.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_13 = (-u_xlat16_0.w) * vs_COLOR0.x + 1.0;
    u_xlat10_0 = texture(_Tex1, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color1.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.x = u_xlat10_0.w * _Color1.w;
    u_xlat16_14 = u_xlat16_0.x * vs_COLOR0.y;
    u_xlat16_3 = (-u_xlat16_0.x) * vs_COLOR0.y + 1.0;
    SV_Target0.w = (-u_xlat16_13) * u_xlat16_3 + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + u_xlat16_1.xyz;
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
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
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
    u_xlat16_2 = in_TEXCOORD0.x + 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    vs_COLOR0.x = ceil(u_xlat16_2);
    u_xlat16_2 = in_TEXCOORD1.x + 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    vs_COLOR0.y = ceil(u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
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
uniform 	mediump vec4 _Color0;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _Tex0;
uniform lowp sampler2D _Tex1;
in mediump vec2 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
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
    u_xlat10_1 = texture(_Tex0, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 * _Color0;
    u_xlat16_5.x = u_xlat16_1.w * vs_COLOR0.x;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_1.xyz;
    u_xlat16_2 = (-u_xlat16_1.w) * vs_COLOR0.x + 1.0;
    u_xlat10_1 = texture(_Tex1, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = u_xlat10_1.xyz * _Color1.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3 = u_xlat10_1.w * _Color1.w;
    u_xlat16_4 = u_xlat16_3 * vs_COLOR0.y;
    u_xlat16_9 = (-u_xlat16_3) * vs_COLOR0.y + 1.0;
    u_xlat16_1.w = (-u_xlat16_2) * u_xlat16_9 + 1.0;
    u_xlat16_1.xyz = vec3(u_xlat16_4) * u_xlat16_7.xyz + u_xlat16_5.xyz;
    SV_Target0 = u_xlat16_0.xxxx * u_xlat16_1;
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
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
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
    u_xlat16_2 = in_TEXCOORD0.x + 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    vs_COLOR0.x = ceil(u_xlat16_2);
    u_xlat16_2 = in_TEXCOORD1.x + 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    vs_COLOR0.y = ceil(u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
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
uniform 	mediump vec4 _Color0;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _Tex0;
uniform lowp sampler2D _Tex1;
in mediump vec2 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
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
    u_xlat10_1 = texture(_Tex0, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 * _Color0;
    u_xlat16_5.x = u_xlat16_1.w * vs_COLOR0.x;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_1.xyz;
    u_xlat16_2 = (-u_xlat16_1.w) * vs_COLOR0.x + 1.0;
    u_xlat10_1 = texture(_Tex1, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = u_xlat10_1.xyz * _Color1.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3 = u_xlat10_1.w * _Color1.w;
    u_xlat16_4 = u_xlat16_3 * vs_COLOR0.y;
    u_xlat16_9 = (-u_xlat16_3) * vs_COLOR0.y + 1.0;
    u_xlat16_1.w = (-u_xlat16_2) * u_xlat16_9 + 1.0;
    u_xlat16_1.xyz = vec3(u_xlat16_4) * u_xlat16_7.xyz + u_xlat16_5.xyz;
    SV_Target0 = u_xlat16_0.xxxx * u_xlat16_1;
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
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
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
    u_xlat16_2 = in_TEXCOORD0.x + 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    vs_COLOR0.x = ceil(u_xlat16_2);
    u_xlat16_2 = in_TEXCOORD1.x + 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    vs_COLOR0.y = ceil(u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
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
uniform 	mediump vec4 _Color0;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _Tex0;
uniform lowp sampler2D _Tex1;
in mediump vec2 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
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
    u_xlat10_1 = texture(_Tex0, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 * _Color0;
    u_xlat16_5.x = u_xlat16_1.w * vs_COLOR0.x;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_1.xyz;
    u_xlat16_2 = (-u_xlat16_1.w) * vs_COLOR0.x + 1.0;
    u_xlat10_1 = texture(_Tex1, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = u_xlat10_1.xyz * _Color1.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3 = u_xlat10_1.w * _Color1.w;
    u_xlat16_4 = u_xlat16_3 * vs_COLOR0.y;
    u_xlat16_9 = (-u_xlat16_3) * vs_COLOR0.y + 1.0;
    u_xlat16_1.w = (-u_xlat16_2) * u_xlat16_9 + 1.0;
    u_xlat16_1.xyz = vec3(u_xlat16_4) * u_xlat16_7.xyz + u_xlat16_5.xyz;
    SV_Target0 = u_xlat16_0.xxxx * u_xlat16_1;
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