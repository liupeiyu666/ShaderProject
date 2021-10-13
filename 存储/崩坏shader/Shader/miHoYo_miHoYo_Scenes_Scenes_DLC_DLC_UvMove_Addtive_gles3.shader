//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_UvMove_Addtive" {
Properties {
_MainTex1 ("Texture1", 2D) = "white" { }
_MainColor1 ("MainColor1", Color) = (1,1,1,1)
_Opacity1 ("Opacity1", Range(0, 1)) = 1
_ScrollXSpeed1 ("ScrollXSpeed1", Float) = 0
_ScrollYSpeed1 ("ScrollYSpeed1", Float) = 0
_MainTex2 ("Texture2", 2D) = "black" { }
_MainColor2 ("MainColor2", Color) = (1,1,1,1)
_Opacity2 ("Opacity2", Range(0, 1)) = 1
_ScrollXSpeed2 ("ScrollXSpeed2", Float) = 0
_ScrollYSpeed2 ("ScrollYSpeed2", Float) = 0
}
SubShader {
 LOD 100
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 64604
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex1_ST;
uniform 	vec4 _MainTex2_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex1_ST.xy + _MainTex1_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainColor1;
uniform 	float _Opacity1;
uniform 	mediump float _ScrollXSpeed1;
uniform 	mediump float _ScrollYSpeed1;
uniform 	vec4 _MainColor2;
uniform 	float _Opacity2;
uniform 	mediump float _ScrollXSpeed2;
uniform 	mediump float _ScrollYSpeed2;
uniform lowp sampler2D _MainTex1;
uniform lowp sampler2D _MainTex2;
in mediump vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vec2(_ScrollXSpeed2, _ScrollYSpeed2) * _Time.xx + vs_TEXCOORD2.xy;
    u_xlat10_0 = texture(_MainTex2, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * _MainColor2;
    u_xlat0 = u_xlat0 * vec4(_Opacity2);
    u_xlat16_1.xy = vec2(_ScrollXSpeed1, _ScrollYSpeed1) * _Time.xx + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex1, u_xlat16_1.xy);
    u_xlat1 = u_xlat10_1 * _MainColor1;
    u_xlat0 = u_xlat1 * vec4(_Opacity1) + u_xlat0;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 _MainTex1_ST;
uniform 	vec4 _MainTex2_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex1_ST.xy + _MainTex1_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainColor1;
uniform 	float _Opacity1;
uniform 	mediump float _ScrollXSpeed1;
uniform 	mediump float _ScrollYSpeed1;
uniform 	vec4 _MainColor2;
uniform 	float _Opacity2;
uniform 	mediump float _ScrollXSpeed2;
uniform 	mediump float _ScrollYSpeed2;
uniform lowp sampler2D _MainTex1;
uniform lowp sampler2D _MainTex2;
in mediump vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vec2(_ScrollXSpeed2, _ScrollYSpeed2) * _Time.xx + vs_TEXCOORD2.xy;
    u_xlat10_0 = texture(_MainTex2, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * _MainColor2;
    u_xlat0 = u_xlat0 * vec4(_Opacity2);
    u_xlat16_1.xy = vec2(_ScrollXSpeed1, _ScrollYSpeed1) * _Time.xx + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex1, u_xlat16_1.xy);
    u_xlat1 = u_xlat10_1 * _MainColor1;
    u_xlat0 = u_xlat1 * vec4(_Opacity1) + u_xlat0;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 _MainTex1_ST;
uniform 	vec4 _MainTex2_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex1_ST.xy + _MainTex1_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainColor1;
uniform 	float _Opacity1;
uniform 	mediump float _ScrollXSpeed1;
uniform 	mediump float _ScrollYSpeed1;
uniform 	vec4 _MainColor2;
uniform 	float _Opacity2;
uniform 	mediump float _ScrollXSpeed2;
uniform 	mediump float _ScrollYSpeed2;
uniform lowp sampler2D _MainTex1;
uniform lowp sampler2D _MainTex2;
in mediump vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vec2(_ScrollXSpeed2, _ScrollYSpeed2) * _Time.xx + vs_TEXCOORD2.xy;
    u_xlat10_0 = texture(_MainTex2, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * _MainColor2;
    u_xlat0 = u_xlat0 * vec4(_Opacity2);
    u_xlat16_1.xy = vec2(_ScrollXSpeed1, _ScrollYSpeed1) * _Time.xx + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex1, u_xlat16_1.xy);
    u_xlat1 = u_xlat10_1 * _MainColor1;
    u_xlat0 = u_xlat1 * vec4(_Opacity1) + u_xlat0;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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