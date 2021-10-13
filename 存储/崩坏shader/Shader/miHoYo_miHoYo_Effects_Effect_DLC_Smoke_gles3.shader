//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/Smoke" {
Properties {
_LightColor ("LightColor", Color) = (0.097,0.097,0.097,0)
_DarkColor ("DarkColor", Color) = (0.038,0.038,0.038,0)
_RimColor ("RimColor", Color) = (0.5441177,0.5441177,0.5441177,0)
_SmokeShape ("SmokeShape", 2D) = "white" { }
_Distortion ("Distortion", 2D) = "white" { }
_DistortionStrength ("Distortion Strength", Range(-0.1, 0.1)) = 0
[MHYToggle] _DistortWithTime ("Distort With Time", Float) = 0
_LoopTime ("LoopTime", Range(0, 5)) = 1
[MHYToggle] _DiaPearByTime ("DiaPear By Time", Float) = 0
_dispearSpeed ("dispearSpeed", Range(0, 5)) = 1
_StartDispearTime ("Start Dispear Time", Float) = 0.2
_TransparentNoise ("Transparent Noise", 2D) = "white" { }
_AlphaMuliplier ("Alpha Muliplier", Float) = 1
_NoiseDistortion ("Noise Distortion", 2D) = "white" { }
_NoiseDistortionSpeedXUspeedYVSpeed ("Noise Distortion Speed (X:Uspeed. Y:VSpeed)", Vector) = (0,0.1,0,0)
_NoiseDistortionStrength ("Noise Distortion Strength", Float) = 0.1
[Header(Motion Vectors)] _MotionVectorsAlphaCutoff ("Motion Vectors Alpha Cutoff", Range(0, 1)) = 0.1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "MAIN"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 58973
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3.x = u_xlat16_0 * _LoopTime;
    u_xlat16_0 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_6.xy = u_xlat16_3.xx * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat16_3.x = u_xlat16_3.x * _DistortionStrength;
    u_xlat10_1 = texture(_NoiseDistortion, u_xlat16_6.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistortWithTime==1.0);
#else
    u_xlatb4 = _DistortWithTime==1.0;
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat16_3.x : _DistortionStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_Distortion, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat1.xw = vec2(u_xlat10_1) * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1 = texture(_TransparentNoise, u_xlat1.xw).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat16_3.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_3.x = (-u_xlat10_2.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_0) * _dispearSpeed + u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb4 = _DiaPearByTime==1.0;
#endif
    u_xlat16_0 = (u_xlatb4) ? u_xlat16_0 : u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_1 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
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
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3.x = u_xlat16_0 * _LoopTime;
    u_xlat16_0 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_6.xy = u_xlat16_3.xx * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat16_3.x = u_xlat16_3.x * _DistortionStrength;
    u_xlat10_1 = texture(_NoiseDistortion, u_xlat16_6.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistortWithTime==1.0);
#else
    u_xlatb4 = _DistortWithTime==1.0;
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat16_3.x : _DistortionStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_Distortion, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat1.xw = vec2(u_xlat10_1) * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1 = texture(_TransparentNoise, u_xlat1.xw).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat16_3.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_3.x = (-u_xlat10_2.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_0) * _dispearSpeed + u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb4 = _DiaPearByTime==1.0;
#endif
    u_xlat16_0 = (u_xlatb4) ? u_xlat16_0 : u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_1 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
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
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3.x = u_xlat16_0 * _LoopTime;
    u_xlat16_0 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_6.xy = u_xlat16_3.xx * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat16_3.x = u_xlat16_3.x * _DistortionStrength;
    u_xlat10_1 = texture(_NoiseDistortion, u_xlat16_6.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistortWithTime==1.0);
#else
    u_xlatb4 = _DistortWithTime==1.0;
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat16_3.x : _DistortionStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_Distortion, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat1.xw = vec2(u_xlat10_1) * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1 = texture(_TransparentNoise, u_xlat1.xw).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat16_3.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_3.x = (-u_xlat10_2.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_0) * _dispearSpeed + u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb4 = _DiaPearByTime==1.0;
#endif
    u_xlat16_0 = (u_xlatb4) ? u_xlat16_0 : u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_1 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3.x = u_xlat16_0 * _LoopTime;
    u_xlat16_0 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_6.xy = u_xlat16_3.xx * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat16_3.x = u_xlat16_3.x * _DistortionStrength;
    u_xlat10_1 = texture(_NoiseDistortion, u_xlat16_6.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistortWithTime==1.0);
#else
    u_xlatb4 = _DistortWithTime==1.0;
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat16_3.x : _DistortionStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_Distortion, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat1.xw = vec2(u_xlat10_1) * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1 = texture(_TransparentNoise, u_xlat1.xw).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat16_3.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_3.x = (-u_xlat10_2.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_0) * _dispearSpeed + u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb4 = _DiaPearByTime==1.0;
#endif
    u_xlat16_0 = (u_xlatb4) ? u_xlat16_0 : u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_1 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3.x = u_xlat16_0 * _LoopTime;
    u_xlat16_0 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_6.xy = u_xlat16_3.xx * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat16_3.x = u_xlat16_3.x * _DistortionStrength;
    u_xlat10_1 = texture(_NoiseDistortion, u_xlat16_6.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistortWithTime==1.0);
#else
    u_xlatb4 = _DistortWithTime==1.0;
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat16_3.x : _DistortionStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_Distortion, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat1.xw = vec2(u_xlat10_1) * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1 = texture(_TransparentNoise, u_xlat1.xw).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat16_3.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_3.x = (-u_xlat10_2.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_0) * _dispearSpeed + u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb4 = _DiaPearByTime==1.0;
#endif
    u_xlat16_0 = (u_xlatb4) ? u_xlat16_0 : u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_1 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3.x = u_xlat16_0 * _LoopTime;
    u_xlat16_0 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_6.xy = u_xlat16_3.xx * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat16_3.x = u_xlat16_3.x * _DistortionStrength;
    u_xlat10_1 = texture(_NoiseDistortion, u_xlat16_6.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistortWithTime==1.0);
#else
    u_xlatb4 = _DistortWithTime==1.0;
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat16_3.x : _DistortionStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_Distortion, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat1.xw = vec2(u_xlat10_1) * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1 = texture(_TransparentNoise, u_xlat1.xw).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat16_3.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_3.x = (-u_xlat10_2.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_0) * _dispearSpeed + u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb4 = _DiaPearByTime==1.0;
#endif
    u_xlat16_0 = (u_xlatb4) ? u_xlat16_0 : u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_1 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3.x = u_xlat16_0 * _LoopTime;
    u_xlat16_0 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_6.xy = u_xlat16_3.xx * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat16_3.x = u_xlat16_3.x * _DistortionStrength;
    u_xlat10_1 = texture(_NoiseDistortion, u_xlat16_6.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistortWithTime==1.0);
#else
    u_xlatb4 = _DistortWithTime==1.0;
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat16_3.x : _DistortionStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_Distortion, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat1.xw = vec2(u_xlat10_1) * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1 = texture(_TransparentNoise, u_xlat1.xw).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat16_3.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_3.x = (-u_xlat10_2.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_0) * _dispearSpeed + u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb4 = _DiaPearByTime==1.0;
#endif
    u_xlat16_0 = (u_xlatb4) ? u_xlat16_0 : u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_1 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3.x = u_xlat16_0 * _LoopTime;
    u_xlat16_0 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_6.xy = u_xlat16_3.xx * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat16_3.x = u_xlat16_3.x * _DistortionStrength;
    u_xlat10_1 = texture(_NoiseDistortion, u_xlat16_6.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistortWithTime==1.0);
#else
    u_xlatb4 = _DistortWithTime==1.0;
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat16_3.x : _DistortionStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_Distortion, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat1.xw = vec2(u_xlat10_1) * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1 = texture(_TransparentNoise, u_xlat1.xw).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat16_3.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_3.x = (-u_xlat10_2.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_0) * _dispearSpeed + u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb4 = _DiaPearByTime==1.0;
#endif
    u_xlat16_0 = (u_xlatb4) ? u_xlat16_0 : u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_1 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3.x = u_xlat16_0 * _LoopTime;
    u_xlat16_0 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_6.xy = u_xlat16_3.xx * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat16_3.x = u_xlat16_3.x * _DistortionStrength;
    u_xlat10_1 = texture(_NoiseDistortion, u_xlat16_6.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistortWithTime==1.0);
#else
    u_xlatb4 = _DistortWithTime==1.0;
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat16_3.x : _DistortionStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_Distortion, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat1.xw = vec2(u_xlat10_1) * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1 = texture(_TransparentNoise, u_xlat1.xw).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat16_3.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_3.x = (-u_xlat10_2.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_0) * _dispearSpeed + u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb4 = _DiaPearByTime==1.0;
#endif
    u_xlat16_0 = (u_xlatb4) ? u_xlat16_0 : u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_1 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3.x = u_xlat16_0 * _LoopTime;
    u_xlat16_0 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_6.xy = u_xlat16_3.xx * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat16_3.x = u_xlat16_3.x * _DistortionStrength;
    u_xlat10_1 = texture(_NoiseDistortion, u_xlat16_6.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistortWithTime==1.0);
#else
    u_xlatb4 = _DistortWithTime==1.0;
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat16_3.x : _DistortionStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_Distortion, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat1.xw = vec2(u_xlat10_1) * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1 = texture(_TransparentNoise, u_xlat1.xw).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat16_3.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_3.x = (-u_xlat10_2.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_0) * _dispearSpeed + u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb4 = _DiaPearByTime==1.0;
#endif
    u_xlat16_0 = (u_xlatb4) ? u_xlat16_0 : u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_1 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3.x = u_xlat16_0 * _LoopTime;
    u_xlat16_0 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_6.xy = u_xlat16_3.xx * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat16_3.x = u_xlat16_3.x * _DistortionStrength;
    u_xlat10_1 = texture(_NoiseDistortion, u_xlat16_6.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistortWithTime==1.0);
#else
    u_xlatb4 = _DistortWithTime==1.0;
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat16_3.x : _DistortionStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_Distortion, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat1.xw = vec2(u_xlat10_1) * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1 = texture(_TransparentNoise, u_xlat1.xw).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat16_3.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_3.x = (-u_xlat10_2.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_0) * _dispearSpeed + u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb4 = _DiaPearByTime==1.0;
#endif
    u_xlat16_0 = (u_xlatb4) ? u_xlat16_0 : u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_1 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3.x = u_xlat16_0 * _LoopTime;
    u_xlat16_0 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_6.xy = u_xlat16_3.xx * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat16_3.x = u_xlat16_3.x * _DistortionStrength;
    u_xlat10_1 = texture(_NoiseDistortion, u_xlat16_6.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistortWithTime==1.0);
#else
    u_xlatb4 = _DistortWithTime==1.0;
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat16_3.x : _DistortionStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_Distortion, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat1.xw = vec2(u_xlat10_1) * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1 = texture(_TransparentNoise, u_xlat1.xw).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat16_3.xy = u_xlat16_4.xy * u_xlat16_3.xx + u_xlat2.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_3.x = (-u_xlat10_2.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_0) * _dispearSpeed + u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.x;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb4 = _DiaPearByTime==1.0;
#endif
    u_xlat16_0 = (u_xlatb4) ? u_xlat16_0 : u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_1 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump vec2 u_xlat16_12;
lowp vec2 u_xlat10_12;
mediump vec2 u_xlat16_13;
vec2 u_xlat14;
mediump float u_xlat16_19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat16_1 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1>=(-u_xlat16_1));
#else
    u_xlatb2 = u_xlat16_1>=(-u_xlat16_1);
#endif
    u_xlat16_1 = fract(abs(u_xlat16_1));
    u_xlat16_1 = (u_xlatb2) ? u_xlat16_1 : (-u_xlat16_1);
    u_xlat16_7 = u_xlat16_1 * _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistortWithTime==1.0);
#else
    u_xlatb2 = _DistortWithTime==1.0;
#endif
    u_xlat16_13.x = u_xlat16_7 * _DistortionStrength;
    u_xlat16_13.x = (u_xlatb2) ? u_xlat16_13.x : _DistortionStrength;
    u_xlat10_12.xy = texture(_Distortion, u_xlat12.xy).xy;
    u_xlat16_12.xy = u_xlat10_12.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_19 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _LoopTime + (-_StartDispearTime);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = (-u_xlat16_1) * _dispearSpeed + u_xlat16_19;
    u_xlat16_1 = u_xlat16_1 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DiaPearByTime==1.0);
#else
    u_xlatb0.x = _DiaPearByTime==1.0;
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2.w;
    u_xlat16_1 = (u_xlatb0.x) ? u_xlat16_1 : u_xlat10_2.w;
    u_xlat0.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _RimColor.xyz;
    u_xlat4.xyz = u_xlat10_2.yyy * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat16_13.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat16_3.xy = vec2(u_xlat16_7) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat14.xy;
    u_xlat10_0 = texture(_NoiseDistortion, u_xlat16_3.xy).x;
    u_xlat0.xy = vec2(u_xlat10_0) * vec2(_NoiseDistortionStrength) + u_xlat16_13.xy;
    u_xlat10_0 = texture(_TransparentNoise, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump vec2 u_xlat16_12;
lowp vec2 u_xlat10_12;
mediump vec2 u_xlat16_13;
vec2 u_xlat14;
mediump float u_xlat16_19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat16_1 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1>=(-u_xlat16_1));
#else
    u_xlatb2 = u_xlat16_1>=(-u_xlat16_1);
#endif
    u_xlat16_1 = fract(abs(u_xlat16_1));
    u_xlat16_1 = (u_xlatb2) ? u_xlat16_1 : (-u_xlat16_1);
    u_xlat16_7 = u_xlat16_1 * _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistortWithTime==1.0);
#else
    u_xlatb2 = _DistortWithTime==1.0;
#endif
    u_xlat16_13.x = u_xlat16_7 * _DistortionStrength;
    u_xlat16_13.x = (u_xlatb2) ? u_xlat16_13.x : _DistortionStrength;
    u_xlat10_12.xy = texture(_Distortion, u_xlat12.xy).xy;
    u_xlat16_12.xy = u_xlat10_12.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_19 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _LoopTime + (-_StartDispearTime);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = (-u_xlat16_1) * _dispearSpeed + u_xlat16_19;
    u_xlat16_1 = u_xlat16_1 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DiaPearByTime==1.0);
#else
    u_xlatb0.x = _DiaPearByTime==1.0;
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2.w;
    u_xlat16_1 = (u_xlatb0.x) ? u_xlat16_1 : u_xlat10_2.w;
    u_xlat0.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _RimColor.xyz;
    u_xlat4.xyz = u_xlat10_2.yyy * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat16_13.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat16_3.xy = vec2(u_xlat16_7) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat14.xy;
    u_xlat10_0 = texture(_NoiseDistortion, u_xlat16_3.xy).x;
    u_xlat0.xy = vec2(u_xlat10_0) * vec2(_NoiseDistortionStrength) + u_xlat16_13.xy;
    u_xlat10_0 = texture(_TransparentNoise, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump vec2 u_xlat16_12;
lowp vec2 u_xlat10_12;
mediump vec2 u_xlat16_13;
vec2 u_xlat14;
mediump float u_xlat16_19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat16_1 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1>=(-u_xlat16_1));
#else
    u_xlatb2 = u_xlat16_1>=(-u_xlat16_1);
#endif
    u_xlat16_1 = fract(abs(u_xlat16_1));
    u_xlat16_1 = (u_xlatb2) ? u_xlat16_1 : (-u_xlat16_1);
    u_xlat16_7 = u_xlat16_1 * _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistortWithTime==1.0);
#else
    u_xlatb2 = _DistortWithTime==1.0;
#endif
    u_xlat16_13.x = u_xlat16_7 * _DistortionStrength;
    u_xlat16_13.x = (u_xlatb2) ? u_xlat16_13.x : _DistortionStrength;
    u_xlat10_12.xy = texture(_Distortion, u_xlat12.xy).xy;
    u_xlat16_12.xy = u_xlat10_12.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_19 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _LoopTime + (-_StartDispearTime);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = (-u_xlat16_1) * _dispearSpeed + u_xlat16_19;
    u_xlat16_1 = u_xlat16_1 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DiaPearByTime==1.0);
#else
    u_xlatb0.x = _DiaPearByTime==1.0;
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2.w;
    u_xlat16_1 = (u_xlatb0.x) ? u_xlat16_1 : u_xlat10_2.w;
    u_xlat0.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _RimColor.xyz;
    u_xlat4.xyz = u_xlat10_2.yyy * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat16_13.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat16_3.xy = vec2(u_xlat16_7) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat14.xy;
    u_xlat10_0 = texture(_NoiseDistortion, u_xlat16_3.xy).x;
    u_xlat0.xy = vec2(u_xlat10_0) * vec2(_NoiseDistortionStrength) + u_xlat16_13.xy;
    u_xlat10_0 = texture(_TransparentNoise, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump vec2 u_xlat16_12;
lowp vec2 u_xlat10_12;
mediump vec2 u_xlat16_13;
vec2 u_xlat14;
mediump float u_xlat16_19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat16_1 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1>=(-u_xlat16_1));
#else
    u_xlatb2 = u_xlat16_1>=(-u_xlat16_1);
#endif
    u_xlat16_1 = fract(abs(u_xlat16_1));
    u_xlat16_1 = (u_xlatb2) ? u_xlat16_1 : (-u_xlat16_1);
    u_xlat16_7 = u_xlat16_1 * _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistortWithTime==1.0);
#else
    u_xlatb2 = _DistortWithTime==1.0;
#endif
    u_xlat16_13.x = u_xlat16_7 * _DistortionStrength;
    u_xlat16_13.x = (u_xlatb2) ? u_xlat16_13.x : _DistortionStrength;
    u_xlat10_12.xy = texture(_Distortion, u_xlat12.xy).xy;
    u_xlat16_12.xy = u_xlat10_12.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_19 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _LoopTime + (-_StartDispearTime);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = (-u_xlat16_1) * _dispearSpeed + u_xlat16_19;
    u_xlat16_1 = u_xlat16_1 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DiaPearByTime==1.0);
#else
    u_xlatb0.x = _DiaPearByTime==1.0;
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2.w;
    u_xlat16_1 = (u_xlatb0.x) ? u_xlat16_1 : u_xlat10_2.w;
    u_xlat0.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _RimColor.xyz;
    u_xlat4.xyz = u_xlat10_2.yyy * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat16_13.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat16_3.xy = vec2(u_xlat16_7) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat14.xy;
    u_xlat10_0 = texture(_NoiseDistortion, u_xlat16_3.xy).x;
    u_xlat0.xy = vec2(u_xlat10_0) * vec2(_NoiseDistortionStrength) + u_xlat16_13.xy;
    u_xlat10_0 = texture(_TransparentNoise, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump vec2 u_xlat16_12;
lowp vec2 u_xlat10_12;
mediump vec2 u_xlat16_13;
vec2 u_xlat14;
mediump float u_xlat16_19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat16_1 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1>=(-u_xlat16_1));
#else
    u_xlatb2 = u_xlat16_1>=(-u_xlat16_1);
#endif
    u_xlat16_1 = fract(abs(u_xlat16_1));
    u_xlat16_1 = (u_xlatb2) ? u_xlat16_1 : (-u_xlat16_1);
    u_xlat16_7 = u_xlat16_1 * _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistortWithTime==1.0);
#else
    u_xlatb2 = _DistortWithTime==1.0;
#endif
    u_xlat16_13.x = u_xlat16_7 * _DistortionStrength;
    u_xlat16_13.x = (u_xlatb2) ? u_xlat16_13.x : _DistortionStrength;
    u_xlat10_12.xy = texture(_Distortion, u_xlat12.xy).xy;
    u_xlat16_12.xy = u_xlat10_12.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_19 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _LoopTime + (-_StartDispearTime);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = (-u_xlat16_1) * _dispearSpeed + u_xlat16_19;
    u_xlat16_1 = u_xlat16_1 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DiaPearByTime==1.0);
#else
    u_xlatb0.x = _DiaPearByTime==1.0;
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2.w;
    u_xlat16_1 = (u_xlatb0.x) ? u_xlat16_1 : u_xlat10_2.w;
    u_xlat0.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _RimColor.xyz;
    u_xlat4.xyz = u_xlat10_2.yyy * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat16_13.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat16_3.xy = vec2(u_xlat16_7) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat14.xy;
    u_xlat10_0 = texture(_NoiseDistortion, u_xlat16_3.xy).x;
    u_xlat0.xy = vec2(u_xlat10_0) * vec2(_NoiseDistortionStrength) + u_xlat16_13.xy;
    u_xlat10_0 = texture(_TransparentNoise, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump vec2 u_xlat16_12;
lowp vec2 u_xlat10_12;
mediump vec2 u_xlat16_13;
vec2 u_xlat14;
mediump float u_xlat16_19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat16_1 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1>=(-u_xlat16_1));
#else
    u_xlatb2 = u_xlat16_1>=(-u_xlat16_1);
#endif
    u_xlat16_1 = fract(abs(u_xlat16_1));
    u_xlat16_1 = (u_xlatb2) ? u_xlat16_1 : (-u_xlat16_1);
    u_xlat16_7 = u_xlat16_1 * _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistortWithTime==1.0);
#else
    u_xlatb2 = _DistortWithTime==1.0;
#endif
    u_xlat16_13.x = u_xlat16_7 * _DistortionStrength;
    u_xlat16_13.x = (u_xlatb2) ? u_xlat16_13.x : _DistortionStrength;
    u_xlat10_12.xy = texture(_Distortion, u_xlat12.xy).xy;
    u_xlat16_12.xy = u_xlat10_12.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_19 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _LoopTime + (-_StartDispearTime);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = (-u_xlat16_1) * _dispearSpeed + u_xlat16_19;
    u_xlat16_1 = u_xlat16_1 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DiaPearByTime==1.0);
#else
    u_xlatb0.x = _DiaPearByTime==1.0;
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2.w;
    u_xlat16_1 = (u_xlatb0.x) ? u_xlat16_1 : u_xlat10_2.w;
    u_xlat0.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _RimColor.xyz;
    u_xlat4.xyz = u_xlat10_2.yyy * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat16_13.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat16_3.xy = vec2(u_xlat16_7) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat14.xy;
    u_xlat10_0 = texture(_NoiseDistortion, u_xlat16_3.xy).x;
    u_xlat0.xy = vec2(u_xlat10_0) * vec2(_NoiseDistortionStrength) + u_xlat16_13.xy;
    u_xlat10_0 = texture(_TransparentNoise, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump vec2 u_xlat16_12;
lowp vec2 u_xlat10_12;
mediump vec2 u_xlat16_13;
vec2 u_xlat14;
mediump float u_xlat16_19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat16_1 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1>=(-u_xlat16_1));
#else
    u_xlatb2 = u_xlat16_1>=(-u_xlat16_1);
#endif
    u_xlat16_1 = fract(abs(u_xlat16_1));
    u_xlat16_1 = (u_xlatb2) ? u_xlat16_1 : (-u_xlat16_1);
    u_xlat16_7 = u_xlat16_1 * _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistortWithTime==1.0);
#else
    u_xlatb2 = _DistortWithTime==1.0;
#endif
    u_xlat16_13.x = u_xlat16_7 * _DistortionStrength;
    u_xlat16_13.x = (u_xlatb2) ? u_xlat16_13.x : _DistortionStrength;
    u_xlat10_12.xy = texture(_Distortion, u_xlat12.xy).xy;
    u_xlat16_12.xy = u_xlat10_12.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_19 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _LoopTime + (-_StartDispearTime);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = (-u_xlat16_1) * _dispearSpeed + u_xlat16_19;
    u_xlat16_1 = u_xlat16_1 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DiaPearByTime==1.0);
#else
    u_xlatb0.x = _DiaPearByTime==1.0;
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2.w;
    u_xlat16_1 = (u_xlatb0.x) ? u_xlat16_1 : u_xlat10_2.w;
    u_xlat0.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _RimColor.xyz;
    u_xlat4.xyz = u_xlat10_2.yyy * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat16_13.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat16_3.xy = vec2(u_xlat16_7) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat14.xy;
    u_xlat10_0 = texture(_NoiseDistortion, u_xlat16_3.xy).x;
    u_xlat0.xy = vec2(u_xlat10_0) * vec2(_NoiseDistortionStrength) + u_xlat16_13.xy;
    u_xlat10_0 = texture(_TransparentNoise, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump vec2 u_xlat16_12;
lowp vec2 u_xlat10_12;
mediump vec2 u_xlat16_13;
vec2 u_xlat14;
mediump float u_xlat16_19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat16_1 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1>=(-u_xlat16_1));
#else
    u_xlatb2 = u_xlat16_1>=(-u_xlat16_1);
#endif
    u_xlat16_1 = fract(abs(u_xlat16_1));
    u_xlat16_1 = (u_xlatb2) ? u_xlat16_1 : (-u_xlat16_1);
    u_xlat16_7 = u_xlat16_1 * _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistortWithTime==1.0);
#else
    u_xlatb2 = _DistortWithTime==1.0;
#endif
    u_xlat16_13.x = u_xlat16_7 * _DistortionStrength;
    u_xlat16_13.x = (u_xlatb2) ? u_xlat16_13.x : _DistortionStrength;
    u_xlat10_12.xy = texture(_Distortion, u_xlat12.xy).xy;
    u_xlat16_12.xy = u_xlat10_12.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_19 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _LoopTime + (-_StartDispearTime);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = (-u_xlat16_1) * _dispearSpeed + u_xlat16_19;
    u_xlat16_1 = u_xlat16_1 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DiaPearByTime==1.0);
#else
    u_xlatb0.x = _DiaPearByTime==1.0;
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2.w;
    u_xlat16_1 = (u_xlatb0.x) ? u_xlat16_1 : u_xlat10_2.w;
    u_xlat0.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _RimColor.xyz;
    u_xlat4.xyz = u_xlat10_2.yyy * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat16_13.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat16_3.xy = vec2(u_xlat16_7) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat14.xy;
    u_xlat10_0 = texture(_NoiseDistortion, u_xlat16_3.xy).x;
    u_xlat0.xy = vec2(u_xlat10_0) * vec2(_NoiseDistortionStrength) + u_xlat16_13.xy;
    u_xlat10_0 = texture(_TransparentNoise, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump vec2 u_xlat16_12;
lowp vec2 u_xlat10_12;
mediump vec2 u_xlat16_13;
vec2 u_xlat14;
mediump float u_xlat16_19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat16_1 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1>=(-u_xlat16_1));
#else
    u_xlatb2 = u_xlat16_1>=(-u_xlat16_1);
#endif
    u_xlat16_1 = fract(abs(u_xlat16_1));
    u_xlat16_1 = (u_xlatb2) ? u_xlat16_1 : (-u_xlat16_1);
    u_xlat16_7 = u_xlat16_1 * _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistortWithTime==1.0);
#else
    u_xlatb2 = _DistortWithTime==1.0;
#endif
    u_xlat16_13.x = u_xlat16_7 * _DistortionStrength;
    u_xlat16_13.x = (u_xlatb2) ? u_xlat16_13.x : _DistortionStrength;
    u_xlat10_12.xy = texture(_Distortion, u_xlat12.xy).xy;
    u_xlat16_12.xy = u_xlat10_12.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_19 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _LoopTime + (-_StartDispearTime);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = (-u_xlat16_1) * _dispearSpeed + u_xlat16_19;
    u_xlat16_1 = u_xlat16_1 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DiaPearByTime==1.0);
#else
    u_xlatb0.x = _DiaPearByTime==1.0;
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2.w;
    u_xlat16_1 = (u_xlatb0.x) ? u_xlat16_1 : u_xlat10_2.w;
    u_xlat0.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _RimColor.xyz;
    u_xlat4.xyz = u_xlat10_2.yyy * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat16_13.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat16_3.xy = vec2(u_xlat16_7) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat14.xy;
    u_xlat10_0 = texture(_NoiseDistortion, u_xlat16_3.xy).x;
    u_xlat0.xy = vec2(u_xlat10_0) * vec2(_NoiseDistortionStrength) + u_xlat16_13.xy;
    u_xlat10_0 = texture(_TransparentNoise, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump vec2 u_xlat16_12;
lowp vec2 u_xlat10_12;
mediump vec2 u_xlat16_13;
vec2 u_xlat14;
mediump float u_xlat16_19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat16_1 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1>=(-u_xlat16_1));
#else
    u_xlatb2 = u_xlat16_1>=(-u_xlat16_1);
#endif
    u_xlat16_1 = fract(abs(u_xlat16_1));
    u_xlat16_1 = (u_xlatb2) ? u_xlat16_1 : (-u_xlat16_1);
    u_xlat16_7 = u_xlat16_1 * _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistortWithTime==1.0);
#else
    u_xlatb2 = _DistortWithTime==1.0;
#endif
    u_xlat16_13.x = u_xlat16_7 * _DistortionStrength;
    u_xlat16_13.x = (u_xlatb2) ? u_xlat16_13.x : _DistortionStrength;
    u_xlat10_12.xy = texture(_Distortion, u_xlat12.xy).xy;
    u_xlat16_12.xy = u_xlat10_12.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_19 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _LoopTime + (-_StartDispearTime);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = (-u_xlat16_1) * _dispearSpeed + u_xlat16_19;
    u_xlat16_1 = u_xlat16_1 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DiaPearByTime==1.0);
#else
    u_xlatb0.x = _DiaPearByTime==1.0;
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2.w;
    u_xlat16_1 = (u_xlatb0.x) ? u_xlat16_1 : u_xlat10_2.w;
    u_xlat0.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _RimColor.xyz;
    u_xlat4.xyz = u_xlat10_2.yyy * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat16_13.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat16_3.xy = vec2(u_xlat16_7) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat14.xy;
    u_xlat10_0 = texture(_NoiseDistortion, u_xlat16_3.xy).x;
    u_xlat0.xy = vec2(u_xlat10_0) * vec2(_NoiseDistortionStrength) + u_xlat16_13.xy;
    u_xlat10_0 = texture(_TransparentNoise, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump vec2 u_xlat16_12;
lowp vec2 u_xlat10_12;
mediump vec2 u_xlat16_13;
vec2 u_xlat14;
mediump float u_xlat16_19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat16_1 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1>=(-u_xlat16_1));
#else
    u_xlatb2 = u_xlat16_1>=(-u_xlat16_1);
#endif
    u_xlat16_1 = fract(abs(u_xlat16_1));
    u_xlat16_1 = (u_xlatb2) ? u_xlat16_1 : (-u_xlat16_1);
    u_xlat16_7 = u_xlat16_1 * _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistortWithTime==1.0);
#else
    u_xlatb2 = _DistortWithTime==1.0;
#endif
    u_xlat16_13.x = u_xlat16_7 * _DistortionStrength;
    u_xlat16_13.x = (u_xlatb2) ? u_xlat16_13.x : _DistortionStrength;
    u_xlat10_12.xy = texture(_Distortion, u_xlat12.xy).xy;
    u_xlat16_12.xy = u_xlat10_12.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_19 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _LoopTime + (-_StartDispearTime);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = (-u_xlat16_1) * _dispearSpeed + u_xlat16_19;
    u_xlat16_1 = u_xlat16_1 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DiaPearByTime==1.0);
#else
    u_xlatb0.x = _DiaPearByTime==1.0;
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2.w;
    u_xlat16_1 = (u_xlatb0.x) ? u_xlat16_1 : u_xlat10_2.w;
    u_xlat0.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _RimColor.xyz;
    u_xlat4.xyz = u_xlat10_2.yyy * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat16_13.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat16_3.xy = vec2(u_xlat16_7) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat14.xy;
    u_xlat10_0 = texture(_NoiseDistortion, u_xlat16_3.xy).x;
    u_xlat0.xy = vec2(u_xlat10_0) * vec2(_NoiseDistortionStrength) + u_xlat16_13.xy;
    u_xlat10_0 = texture(_TransparentNoise, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _RimColor;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump vec2 u_xlat16_12;
lowp vec2 u_xlat10_12;
mediump vec2 u_xlat16_13;
vec2 u_xlat14;
mediump float u_xlat16_19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat16_1 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1>=(-u_xlat16_1));
#else
    u_xlatb2 = u_xlat16_1>=(-u_xlat16_1);
#endif
    u_xlat16_1 = fract(abs(u_xlat16_1));
    u_xlat16_1 = (u_xlatb2) ? u_xlat16_1 : (-u_xlat16_1);
    u_xlat16_7 = u_xlat16_1 * _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistortWithTime==1.0);
#else
    u_xlatb2 = _DistortWithTime==1.0;
#endif
    u_xlat16_13.x = u_xlat16_7 * _DistortionStrength;
    u_xlat16_13.x = (u_xlatb2) ? u_xlat16_13.x : _DistortionStrength;
    u_xlat10_12.xy = texture(_Distortion, u_xlat12.xy).xy;
    u_xlat16_12.xy = u_xlat10_12.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat10_2 = texture(_SmokeShape, u_xlat16_3.xy);
    u_xlat16_19 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _LoopTime + (-_StartDispearTime);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = (-u_xlat16_1) * _dispearSpeed + u_xlat16_19;
    u_xlat16_1 = u_xlat16_1 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DiaPearByTime==1.0);
#else
    u_xlatb0.x = _DiaPearByTime==1.0;
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2.w;
    u_xlat16_1 = (u_xlatb0.x) ? u_xlat16_1 : u_xlat10_2.w;
    u_xlat0.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _RimColor.xyz;
    u_xlat4.xyz = u_xlat10_2.yyy * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat16_13.xy = u_xlat16_12.xy * u_xlat16_13.xx + u_xlat0.xy;
    u_xlat16_3.xy = vec2(u_xlat16_7) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat14.xy;
    u_xlat10_0 = texture(_NoiseDistortion, u_xlat16_3.xy).x;
    u_xlat0.xy = vec2(u_xlat10_0) * vec2(_NoiseDistortionStrength) + u_xlat16_13.xy;
    u_xlat10_0 = texture(_TransparentNoise, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * _AlphaMuliplier;
    u_xlat0.w = u_xlat16_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
}
}
 Pass {
  Name "MOTIONVECTORS"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 125191
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = u_xlat0.x * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_6;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = u_xlat16_0 * _LoopTime;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_6.x = u_xlat16_0 * _DistortionStrength;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_DistortWithTime==1.0);
#else
    u_xlatb1 = _DistortWithTime==1.0;
#endif
    u_xlat16_6.x = (u_xlatb1) ? u_xlat16_6.x : _DistortionStrength;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_Distortion, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_7.xy * u_xlat16_6.xx + u_xlat1.xy;
    u_xlat10_1.xy = texture(_SmokeShape, u_xlat16_2.xy).zw;
    u_xlat16_9 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_3 = (-u_xlat16_3) * _dispearSpeed + u_xlat16_9;
    u_xlat16_3 = u_xlat16_3 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3 * -2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_9;
    u_xlat16_3 = u_xlat16_3 * u_xlat10_1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb1 = _DiaPearByTime==1.0;
#endif
    u_xlat16_3 = (u_xlatb1) ? u_xlat16_3 : u_xlat10_1.y;
    u_xlat1.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_7.xy * u_xlat16_6.xx + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_2.xy = vec2(u_xlat16_0) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat10_1.x = texture(_NoiseDistortion, u_xlat16_2.xy).x;
    u_xlat1.xy = u_xlat10_1.xx * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1.x = texture(_TransparentNoise, u_xlat1.xy).x;
    u_xlat16_1 = u_xlat16_3 * u_xlat10_1.x;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat1.x = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat1.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat7.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat7.xy * vec2(0.5, 0.5) + (-u_xlat1.xy);
    SV_Target0.xy = u_xlat1.xy;
    SV_Target0.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = u_xlat0.x * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_6;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = u_xlat16_0 * _LoopTime;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_6.x = u_xlat16_0 * _DistortionStrength;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_DistortWithTime==1.0);
#else
    u_xlatb1 = _DistortWithTime==1.0;
#endif
    u_xlat16_6.x = (u_xlatb1) ? u_xlat16_6.x : _DistortionStrength;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_Distortion, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_7.xy * u_xlat16_6.xx + u_xlat1.xy;
    u_xlat10_1.xy = texture(_SmokeShape, u_xlat16_2.xy).zw;
    u_xlat16_9 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_3 = (-u_xlat16_3) * _dispearSpeed + u_xlat16_9;
    u_xlat16_3 = u_xlat16_3 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3 * -2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_9;
    u_xlat16_3 = u_xlat16_3 * u_xlat10_1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb1 = _DiaPearByTime==1.0;
#endif
    u_xlat16_3 = (u_xlatb1) ? u_xlat16_3 : u_xlat10_1.y;
    u_xlat1.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_7.xy * u_xlat16_6.xx + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_2.xy = vec2(u_xlat16_0) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat10_1.x = texture(_NoiseDistortion, u_xlat16_2.xy).x;
    u_xlat1.xy = u_xlat10_1.xx * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1.x = texture(_TransparentNoise, u_xlat1.xy).x;
    u_xlat16_1 = u_xlat16_3 * u_xlat10_1.x;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat1.x = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat1.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat7.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat7.xy * vec2(0.5, 0.5) + (-u_xlat1.xy);
    SV_Target0.xy = u_xlat1.xy;
    SV_Target0.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = u_xlat0.x * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_6;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = u_xlat16_0 * _LoopTime;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_6.x = u_xlat16_0 * _DistortionStrength;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_DistortWithTime==1.0);
#else
    u_xlatb1 = _DistortWithTime==1.0;
#endif
    u_xlat16_6.x = (u_xlatb1) ? u_xlat16_6.x : _DistortionStrength;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_Distortion, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_7.xy * u_xlat16_6.xx + u_xlat1.xy;
    u_xlat10_1.xy = texture(_SmokeShape, u_xlat16_2.xy).zw;
    u_xlat16_9 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_3 = (-u_xlat16_3) * _dispearSpeed + u_xlat16_9;
    u_xlat16_3 = u_xlat16_3 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3 * -2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_9;
    u_xlat16_3 = u_xlat16_3 * u_xlat10_1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb1 = _DiaPearByTime==1.0;
#endif
    u_xlat16_3 = (u_xlatb1) ? u_xlat16_3 : u_xlat10_1.y;
    u_xlat1.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_7.xy * u_xlat16_6.xx + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_2.xy = vec2(u_xlat16_0) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat10_1.x = texture(_NoiseDistortion, u_xlat16_2.xy).x;
    u_xlat1.xy = u_xlat10_1.xx * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1.x = texture(_TransparentNoise, u_xlat1.xy).x;
    u_xlat16_1 = u_xlat16_3 * u_xlat10_1.x;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat1.x = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat1.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat7.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat7.xy * vec2(0.5, 0.5) + (-u_xlat1.xy);
    SV_Target0.xy = u_xlat1.xy;
    SV_Target0.zw = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = u_xlat0.x * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_6;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = u_xlat16_0 * _LoopTime;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_6.x = u_xlat16_0 * _DistortionStrength;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_DistortWithTime==1.0);
#else
    u_xlatb1 = _DistortWithTime==1.0;
#endif
    u_xlat16_6.x = (u_xlatb1) ? u_xlat16_6.x : _DistortionStrength;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_Distortion, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_7.xy * u_xlat16_6.xx + u_xlat1.xy;
    u_xlat10_1.xy = texture(_SmokeShape, u_xlat16_2.xy).zw;
    u_xlat16_9 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_3 = (-u_xlat16_3) * _dispearSpeed + u_xlat16_9;
    u_xlat16_3 = u_xlat16_3 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3 * -2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_9;
    u_xlat16_3 = u_xlat16_3 * u_xlat10_1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb1 = _DiaPearByTime==1.0;
#endif
    u_xlat16_3 = (u_xlatb1) ? u_xlat16_3 : u_xlat10_1.y;
    u_xlat1.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_7.xy * u_xlat16_6.xx + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_2.xy = vec2(u_xlat16_0) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat10_1.x = texture(_NoiseDistortion, u_xlat16_2.xy).x;
    u_xlat1.xy = u_xlat10_1.xx * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1.x = texture(_TransparentNoise, u_xlat1.xy).x;
    u_xlat16_1 = u_xlat16_3 * u_xlat10_1.x;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat1.x = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat1.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat7.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat7.xy * vec2(0.5, 0.5) + (-u_xlat1.xy);
    SV_Target0.xy = u_xlat1.xy;
    SV_Target0.zw = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = u_xlat0.x * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_6;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = u_xlat16_0 * _LoopTime;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_6.x = u_xlat16_0 * _DistortionStrength;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_DistortWithTime==1.0);
#else
    u_xlatb1 = _DistortWithTime==1.0;
#endif
    u_xlat16_6.x = (u_xlatb1) ? u_xlat16_6.x : _DistortionStrength;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_Distortion, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_7.xy * u_xlat16_6.xx + u_xlat1.xy;
    u_xlat10_1.xy = texture(_SmokeShape, u_xlat16_2.xy).zw;
    u_xlat16_9 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_3 = (-u_xlat16_3) * _dispearSpeed + u_xlat16_9;
    u_xlat16_3 = u_xlat16_3 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3 * -2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_9;
    u_xlat16_3 = u_xlat16_3 * u_xlat10_1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb1 = _DiaPearByTime==1.0;
#endif
    u_xlat16_3 = (u_xlatb1) ? u_xlat16_3 : u_xlat10_1.y;
    u_xlat1.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_7.xy * u_xlat16_6.xx + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_2.xy = vec2(u_xlat16_0) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat10_1.x = texture(_NoiseDistortion, u_xlat16_2.xy).x;
    u_xlat1.xy = u_xlat10_1.xx * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1.x = texture(_TransparentNoise, u_xlat1.xy).x;
    u_xlat16_1 = u_xlat16_3 * u_xlat10_1.x;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat1.x = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat1.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat7.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat7.xy * vec2(0.5, 0.5) + (-u_xlat1.xy);
    SV_Target0.xy = u_xlat1.xy;
    SV_Target0.zw = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = u_xlat0.x * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _DiaPearByTime;
uniform 	vec4 _SmokeShape_ST;
uniform 	mediump float _DistortWithTime;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _LoopTime;
uniform 	mediump float _StartDispearTime;
uniform 	mediump float _dispearSpeed;
uniform 	vec4 _TransparentNoise_ST;
uniform 	mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform 	vec4 _NoiseDistortion_ST;
uniform 	mediump float _NoiseDistortionStrength;
uniform 	mediump float _AlphaMuliplier;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _NoiseDistortion;
uniform lowp sampler2D _TransparentNoise;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_6;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0 = _Time.y / _LoopTime;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0>=(-u_xlat16_0));
#else
    u_xlatb1 = u_xlat16_0>=(-u_xlat16_0);
#endif
    u_xlat16_0 = fract(abs(u_xlat16_0));
    u_xlat16_0 = (u_xlatb1) ? u_xlat16_0 : (-u_xlat16_0);
    u_xlat16_3 = u_xlat16_0 * _LoopTime + (-_StartDispearTime);
    u_xlat16_0 = u_xlat16_0 * _LoopTime;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_6.x = u_xlat16_0 * _DistortionStrength;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_DistortWithTime==1.0);
#else
    u_xlatb1 = _DistortWithTime==1.0;
#endif
    u_xlat16_6.x = (u_xlatb1) ? u_xlat16_6.x : _DistortionStrength;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShape_ST.xy + _SmokeShape_ST.zw;
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_Distortion, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_7.xy * u_xlat16_6.xx + u_xlat1.xy;
    u_xlat10_1.xy = texture(_SmokeShape, u_xlat16_2.xy).zw;
    u_xlat16_9 = (-u_xlat10_1.x) + 1.0;
    u_xlat16_3 = (-u_xlat16_3) * _dispearSpeed + u_xlat16_9;
    u_xlat16_3 = u_xlat16_3 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3 * -2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_9;
    u_xlat16_3 = u_xlat16_3 * u_xlat10_1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_DiaPearByTime==1.0);
#else
    u_xlatb1 = _DiaPearByTime==1.0;
#endif
    u_xlat16_3 = (u_xlatb1) ? u_xlat16_3 : u_xlat10_1.y;
    u_xlat1.xy = vs_TEXCOORD0.xy * _TransparentNoise_ST.xy + _TransparentNoise_ST.zw;
    u_xlat16_6.xy = u_xlat16_7.xy * u_xlat16_6.xx + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseDistortion_ST.xy + _NoiseDistortion_ST.zw;
    u_xlat16_2.xy = vec2(u_xlat16_0) * _NoiseDistortionSpeedXUspeedYVSpeed.xy + u_xlat1.xy;
    u_xlat10_1.x = texture(_NoiseDistortion, u_xlat16_2.xy).x;
    u_xlat1.xy = u_xlat10_1.xx * vec2(_NoiseDistortionStrength) + u_xlat16_6.xy;
    u_xlat10_1.x = texture(_TransparentNoise, u_xlat1.xy).x;
    u_xlat16_1 = u_xlat16_3 * u_xlat10_1.x;
    u_xlat16_1 = u_xlat16_1 * _AlphaMuliplier;
    u_xlat1.x = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat1.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat7.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat7.xy * vec2(0.5, 0.5) + (-u_xlat1.xy);
    SV_Target0.xy = u_xlat1.xy;
    SV_Target0.zw = vec2(0.0, 0.0);
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
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}