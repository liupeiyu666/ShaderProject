//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Liquid_Common" {
Properties {
_LiquidTex ("LiquidTex", 2D) = "white" { }
_Normalmap ("Normalmap", 2D) = "bump" { }
_NormalBrightness ("NormalBrightness", Range(-1, 4)) = 1
_MatcapSize ("MatcapSize", Range(0, 2)) = 1
_Matcap ("Matcap", 2D) = "white" { }
_ColorBrightnessMax ("ColorBrightnessMax", Float) = 1.05
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 2
[MHYToggle] _MatcapAlphaToggle ("MatcapAlphaToggle", Float) = 0
_Color ("Color", Color) = (1,1,1,1)
[MHYToggle] _UspeedToggle ("UspeedToggle", Float) = 0
_Uspeed ("Uspeed", Float) = 0
[Toggle(_MASKTEXTOGGLE_ON)] _MaskTexToggle ("MaskTexToggle", Float) = 0
_TextureMask ("TextureMask", 2D) = "white" { }
[Toggle(_NOISETOGGLE_ON)] _NoiseToggle ("NoiseToggle", Float) = 0
[MHYToggle] _NoiseRandomToggle ("NoiseRandomToggle", Float) = 0
_Noise_Tex ("Noise_Tex", 2D) = "white" { }
_Noise_Uspeed ("Noise_Uspeed", Float) = 0
_Noise_Vspeed ("Noise_Vspeed", Float) = 0
_Noise_Offset ("Noise_Offset", Float) = 0.5
_Noise_Brightness ("Noise_Brightness", Float) = 0.1
[MHYToggle] _ParticlesColorToggle1 ("ParticlesColorToggle1", Float) = 0
[MHYToggle] _ParticlesColorToggle2 ("ParticlesColorToggle2", Float) = 0
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_DayColor ("DayColor", Color) = (1,1,1,1)
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 10268
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _DayColor;
uniform 	mediump float _ParticlesColorToggle2;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _Normalmap_ST;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	float _AlphaBrightness;
uniform 	float _ColorBrightness;
uniform 	mediump float _ParticlesColorToggle1;
uniform 	vec4 _Color;
uniform 	float _ColorBrightnessMax;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.x = _NormalBrightness + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD3.y;
    u_xlat1.y = vs_TEXCOORD5.y;
    u_xlat1.z = vs_TEXCOORD4.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD3.x;
    u_xlat3.y = vs_TEXCOORD5.x;
    u_xlat3.z = vs_TEXCOORD4.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD3.z;
    u_xlat3.y = vs_TEXCOORD5.z;
    u_xlat3.z = vs_TEXCOORD4.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _ParticlesColorToggle2, _MatcapAlphaToggle, _ParticlesColorToggle2), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_ParticlesColorToggle1==1.0);
#else
    u_xlatb13 = _ParticlesColorToggle1==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(_ColorBrightnessMax));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _DayColor;
uniform 	mediump float _ParticlesColorToggle2;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _Normalmap_ST;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	float _AlphaBrightness;
uniform 	float _ColorBrightness;
uniform 	mediump float _ParticlesColorToggle1;
uniform 	vec4 _Color;
uniform 	float _ColorBrightnessMax;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.x = _NormalBrightness + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD3.y;
    u_xlat1.y = vs_TEXCOORD5.y;
    u_xlat1.z = vs_TEXCOORD4.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD3.x;
    u_xlat3.y = vs_TEXCOORD5.x;
    u_xlat3.z = vs_TEXCOORD4.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD3.z;
    u_xlat3.y = vs_TEXCOORD5.z;
    u_xlat3.z = vs_TEXCOORD4.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _ParticlesColorToggle2, _MatcapAlphaToggle, _ParticlesColorToggle2), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_ParticlesColorToggle1==1.0);
#else
    u_xlatb13 = _ParticlesColorToggle1==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(_ColorBrightnessMax));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _DayColor;
uniform 	mediump float _ParticlesColorToggle2;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _Normalmap_ST;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	float _AlphaBrightness;
uniform 	float _ColorBrightness;
uniform 	mediump float _ParticlesColorToggle1;
uniform 	vec4 _Color;
uniform 	float _ColorBrightnessMax;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.x = _NormalBrightness + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD3.y;
    u_xlat1.y = vs_TEXCOORD5.y;
    u_xlat1.z = vs_TEXCOORD4.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD3.x;
    u_xlat3.y = vs_TEXCOORD5.x;
    u_xlat3.z = vs_TEXCOORD4.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD3.z;
    u_xlat3.y = vs_TEXCOORD5.z;
    u_xlat3.z = vs_TEXCOORD4.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _ParticlesColorToggle2, _MatcapAlphaToggle, _ParticlesColorToggle2), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_ParticlesColorToggle1==1.0);
#else
    u_xlatb13 = _ParticlesColorToggle1==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(_ColorBrightnessMax));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _DayColor;
uniform 	mediump float _ParticlesColorToggle2;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _Normalmap_ST;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	float _AlphaBrightness;
uniform 	float _ColorBrightness;
uniform 	mediump float _ParticlesColorToggle1;
uniform 	vec4 _Color;
uniform 	float _ColorBrightnessMax;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.x = _NormalBrightness + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD3.y;
    u_xlat1.y = vs_TEXCOORD5.y;
    u_xlat1.z = vs_TEXCOORD4.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD3.x;
    u_xlat3.y = vs_TEXCOORD5.x;
    u_xlat3.z = vs_TEXCOORD4.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD3.z;
    u_xlat3.y = vs_TEXCOORD5.z;
    u_xlat3.z = vs_TEXCOORD4.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _ParticlesColorToggle2, _MatcapAlphaToggle, _ParticlesColorToggle2), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_ParticlesColorToggle1==1.0);
#else
    u_xlatb13 = _ParticlesColorToggle1==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(_ColorBrightnessMax));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _DayColor;
uniform 	mediump float _ParticlesColorToggle2;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _Normalmap_ST;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	float _AlphaBrightness;
uniform 	float _ColorBrightness;
uniform 	mediump float _ParticlesColorToggle1;
uniform 	vec4 _Color;
uniform 	float _ColorBrightnessMax;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.x = _NormalBrightness + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD3.y;
    u_xlat1.y = vs_TEXCOORD5.y;
    u_xlat1.z = vs_TEXCOORD4.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD3.x;
    u_xlat3.y = vs_TEXCOORD5.x;
    u_xlat3.z = vs_TEXCOORD4.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD3.z;
    u_xlat3.y = vs_TEXCOORD5.z;
    u_xlat3.z = vs_TEXCOORD4.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _ParticlesColorToggle2, _MatcapAlphaToggle, _ParticlesColorToggle2), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_ParticlesColorToggle1==1.0);
#else
    u_xlatb13 = _ParticlesColorToggle1==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(_ColorBrightnessMax));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _DayColor;
uniform 	mediump float _ParticlesColorToggle2;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _Normalmap_ST;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	float _AlphaBrightness;
uniform 	float _ColorBrightness;
uniform 	mediump float _ParticlesColorToggle1;
uniform 	vec4 _Color;
uniform 	float _ColorBrightnessMax;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.x = _NormalBrightness + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD3.y;
    u_xlat1.y = vs_TEXCOORD5.y;
    u_xlat1.z = vs_TEXCOORD4.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD3.x;
    u_xlat3.y = vs_TEXCOORD5.x;
    u_xlat3.z = vs_TEXCOORD4.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD3.z;
    u_xlat3.y = vs_TEXCOORD5.z;
    u_xlat3.z = vs_TEXCOORD4.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _ParticlesColorToggle2, _MatcapAlphaToggle, _ParticlesColorToggle2), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_ParticlesColorToggle1==1.0);
#else
    u_xlatb13 = _ParticlesColorToggle1==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(_ColorBrightnessMax));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}