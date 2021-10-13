//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/MainMenu/Screen" {
Properties {
_MainTex ("Particle Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_Scaler ("Emmision Scaler", Range(0, 10)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 49710
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _nextFrameOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    vs_TEXCOORD1.xy = u_xlat0.xy + _nextFrameOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _frameInterpolationFactor;
uniform 	float _BloomFactor;
uniform 	mediump float _Scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 + (-u_xlat10_1);
    u_xlat16_0 = vec4(_frameInterpolationFactor) * u_xlat16_0 + u_xlat10_1;
    u_xlat16_2.xyz = u_xlat16_0.www * u_xlat16_0.xyz;
    u_xlat1 = u_xlat16_0.w * _BloomFactor;
    SV_Target0.w = u_xlat1;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_Scaler);
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
uniform 	vec2 _nextFrameOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    vs_TEXCOORD1.xy = u_xlat0.xy + _nextFrameOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _frameInterpolationFactor;
uniform 	float _BloomFactor;
uniform 	mediump float _Scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 + (-u_xlat10_1);
    u_xlat16_0 = vec4(_frameInterpolationFactor) * u_xlat16_0 + u_xlat10_1;
    u_xlat16_2.xyz = u_xlat16_0.www * u_xlat16_0.xyz;
    u_xlat1 = u_xlat16_0.w * _BloomFactor;
    SV_Target0.w = u_xlat1;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_Scaler);
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
uniform 	vec2 _nextFrameOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    vs_TEXCOORD1.xy = u_xlat0.xy + _nextFrameOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _frameInterpolationFactor;
uniform 	float _BloomFactor;
uniform 	mediump float _Scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 + (-u_xlat10_1);
    u_xlat16_0 = vec4(_frameInterpolationFactor) * u_xlat16_0 + u_xlat10_1;
    u_xlat16_2.xyz = u_xlat16_0.www * u_xlat16_0.xyz;
    u_xlat1 = u_xlat16_0.w * _BloomFactor;
    SV_Target0.w = u_xlat1;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_Scaler);
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