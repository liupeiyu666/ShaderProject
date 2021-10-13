//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Smoke" {
Properties {
_DistortionTexture ("DistortionTexture", 2D) = "white" { }
_NoiseTexture ("NoiseTexture", 2D) = "white" { }
_SmokeShape ("SmokeShape", 2D) = "white" { }
_AlphaMultiplier ("AlphaMultiplier", Float) = 1
_LightColor ("LightColor", Color) = (0.097,0.097,0.097,0)
_RimColor ("RimColor", Color) = (0,0,0,0)
_DarkColor ("DarkColor", Color) = (0.038,0.038,0.038,0)
_SwirlItensity ("SwirlItensity", Float) = 0.05
_SmokeBrightness ("SmokeBrightness", Float) = 1
_FireNoise ("FireNoise", 2D) = "white" { }
_FireColor ("FireColor", Color) = (1,0.8985802,0.08088237,0)
[Toggle(_USEFIRE_ON)] _UseFire ("UseFire", Float) = 1
_DayColor ("DayColor", Color) = (1,1,1,1)
_texcoord ("", 2D) = "white" { }
__dirty ("", Float) = 1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 51298
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTexture_ST;
uniform 	float _AlphaMultiplier;
uniform 	mediump float _UseFire;
uniform lowp sampler2D _DistortionTexture;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _NoiseTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_DistortionTexture, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat16_7.xy * vec2(_SwirlItensity) + u_xlat1.xy;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShape, u_xlat2.xz);
    u_xlat0.xyz = u_xlat10_2.xxx * u_xlat0.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_9 = texture(_FireNoise, u_xlat1.xy).x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat10_9;
    u_xlat16_1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_9 = u_xlat16_9 * 7.80000019 + (-u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FireColor.xyz * vec3(u_xlat16_9) + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0<_UseFire);
#else
    u_xlatb9 = 0.0<_UseFire;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat16_7.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTexture_ST.xy + _NoiseTexture_ST.zw;
    u_xlat2.z = u_xlat16_7.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.z = 1.0;
    u_xlat2.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_1 = texture(_NoiseTexture, u_xlat2.xz).x;
    u_xlat16_1.x = (-u_xlat16_1.y) + u_xlat10_1;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_2.w;
    u_xlat1.x = u_xlat16_1.x * _AlphaMultiplier;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTexture_ST;
uniform 	float _AlphaMultiplier;
uniform 	mediump float _UseFire;
uniform lowp sampler2D _DistortionTexture;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _NoiseTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_DistortionTexture, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat16_7.xy * vec2(_SwirlItensity) + u_xlat1.xy;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShape, u_xlat2.xz);
    u_xlat0.xyz = u_xlat10_2.xxx * u_xlat0.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_9 = texture(_FireNoise, u_xlat1.xy).x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat10_9;
    u_xlat16_1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_9 = u_xlat16_9 * 7.80000019 + (-u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FireColor.xyz * vec3(u_xlat16_9) + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0<_UseFire);
#else
    u_xlatb9 = 0.0<_UseFire;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat16_7.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTexture_ST.xy + _NoiseTexture_ST.zw;
    u_xlat2.z = u_xlat16_7.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.z = 1.0;
    u_xlat2.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_1 = texture(_NoiseTexture, u_xlat2.xz).x;
    u_xlat16_1.x = (-u_xlat16_1.y) + u_xlat10_1;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_2.w;
    u_xlat1.x = u_xlat16_1.x * _AlphaMultiplier;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTexture_ST;
uniform 	float _AlphaMultiplier;
uniform 	mediump float _UseFire;
uniform lowp sampler2D _DistortionTexture;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _NoiseTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_DistortionTexture, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat16_7.xy * vec2(_SwirlItensity) + u_xlat1.xy;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShape, u_xlat2.xz);
    u_xlat0.xyz = u_xlat10_2.xxx * u_xlat0.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_9 = texture(_FireNoise, u_xlat1.xy).x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat10_9;
    u_xlat16_1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_9 = u_xlat16_9 * 7.80000019 + (-u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FireColor.xyz * vec3(u_xlat16_9) + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0<_UseFire);
#else
    u_xlatb9 = 0.0<_UseFire;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat16_7.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTexture_ST.xy + _NoiseTexture_ST.zw;
    u_xlat2.z = u_xlat16_7.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.z = 1.0;
    u_xlat2.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_1 = texture(_NoiseTexture, u_xlat2.xz).x;
    u_xlat16_1.x = (-u_xlat16_1.y) + u_xlat10_1;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_2.w;
    u_xlat1.x = u_xlat16_1.x * _AlphaMultiplier;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTexture_ST;
uniform 	float _AlphaMultiplier;
uniform 	mediump float _UseFire;
uniform lowp sampler2D _DistortionTexture;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _NoiseTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_DistortionTexture, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat16_7.xy * vec2(_SwirlItensity) + u_xlat1.xy;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShape, u_xlat2.xz);
    u_xlat0.xyz = u_xlat10_2.xxx * u_xlat0.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_9 = texture(_FireNoise, u_xlat1.xy).x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat10_9;
    u_xlat16_1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_9 = u_xlat16_9 * 7.80000019 + (-u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FireColor.xyz * vec3(u_xlat16_9) + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0<_UseFire);
#else
    u_xlatb9 = 0.0<_UseFire;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat16_7.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTexture_ST.xy + _NoiseTexture_ST.zw;
    u_xlat2.z = u_xlat16_7.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.z = 1.0;
    u_xlat2.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_1 = texture(_NoiseTexture, u_xlat2.xz).x;
    u_xlat16_1.x = (-u_xlat16_1.y) + u_xlat10_1;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_2.w;
    u_xlat1.x = u_xlat16_1.x * _AlphaMultiplier;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTexture_ST;
uniform 	float _AlphaMultiplier;
uniform 	mediump float _UseFire;
uniform lowp sampler2D _DistortionTexture;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _NoiseTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_DistortionTexture, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat16_7.xy * vec2(_SwirlItensity) + u_xlat1.xy;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShape, u_xlat2.xz);
    u_xlat0.xyz = u_xlat10_2.xxx * u_xlat0.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_9 = texture(_FireNoise, u_xlat1.xy).x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat10_9;
    u_xlat16_1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_9 = u_xlat16_9 * 7.80000019 + (-u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FireColor.xyz * vec3(u_xlat16_9) + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0<_UseFire);
#else
    u_xlatb9 = 0.0<_UseFire;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat16_7.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTexture_ST.xy + _NoiseTexture_ST.zw;
    u_xlat2.z = u_xlat16_7.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.z = 1.0;
    u_xlat2.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_1 = texture(_NoiseTexture, u_xlat2.xz).x;
    u_xlat16_1.x = (-u_xlat16_1.y) + u_xlat10_1;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_2.w;
    u_xlat1.x = u_xlat16_1.x * _AlphaMultiplier;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTexture_ST;
uniform 	float _AlphaMultiplier;
uniform 	mediump float _UseFire;
uniform lowp sampler2D _DistortionTexture;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _NoiseTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_DistortionTexture, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat16_7.xy * vec2(_SwirlItensity) + u_xlat1.xy;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShape, u_xlat2.xz);
    u_xlat0.xyz = u_xlat10_2.xxx * u_xlat0.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_9 = texture(_FireNoise, u_xlat1.xy).x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat10_9;
    u_xlat16_1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_9 = u_xlat16_9 * 7.80000019 + (-u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FireColor.xyz * vec3(u_xlat16_9) + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0<_UseFire);
#else
    u_xlatb9 = 0.0<_UseFire;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat16_7.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTexture_ST.xy + _NoiseTexture_ST.zw;
    u_xlat2.z = u_xlat16_7.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.z = 1.0;
    u_xlat2.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_1 = texture(_NoiseTexture, u_xlat2.xz).x;
    u_xlat16_1.x = (-u_xlat16_1.y) + u_xlat10_1;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_2.w;
    u_xlat1.x = u_xlat16_1.x * _AlphaMultiplier;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTexture_ST;
uniform 	float _AlphaMultiplier;
uniform 	mediump float _UseFire;
uniform lowp sampler2D _DistortionTexture;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _NoiseTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_DistortionTexture, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat16_7.xy * vec2(_SwirlItensity) + u_xlat1.xy;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShape, u_xlat2.xz);
    u_xlat0.xyz = u_xlat10_2.xxx * u_xlat0.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_9 = texture(_FireNoise, u_xlat1.xy).x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat10_9;
    u_xlat16_1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_9 = u_xlat16_9 * 7.80000019 + (-u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FireColor.xyz * vec3(u_xlat16_9) + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0<_UseFire);
#else
    u_xlatb9 = 0.0<_UseFire;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat16_7.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTexture_ST.xy + _NoiseTexture_ST.zw;
    u_xlat2.z = u_xlat16_7.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.z = 1.0;
    u_xlat2.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_1 = texture(_NoiseTexture, u_xlat2.xz).x;
    u_xlat16_1.x = (-u_xlat16_1.y) + u_xlat10_1;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_2.w;
    u_xlat1.x = u_xlat16_1.x * _AlphaMultiplier;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTexture_ST;
uniform 	float _AlphaMultiplier;
uniform 	mediump float _UseFire;
uniform lowp sampler2D _DistortionTexture;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _NoiseTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_DistortionTexture, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat16_7.xy * vec2(_SwirlItensity) + u_xlat1.xy;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShape, u_xlat2.xz);
    u_xlat0.xyz = u_xlat10_2.xxx * u_xlat0.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_9 = texture(_FireNoise, u_xlat1.xy).x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat10_9;
    u_xlat16_1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_9 = u_xlat16_9 * 7.80000019 + (-u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FireColor.xyz * vec3(u_xlat16_9) + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0<_UseFire);
#else
    u_xlatb9 = 0.0<_UseFire;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat16_7.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTexture_ST.xy + _NoiseTexture_ST.zw;
    u_xlat2.z = u_xlat16_7.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.z = 1.0;
    u_xlat2.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_1 = texture(_NoiseTexture, u_xlat2.xz).x;
    u_xlat16_1.x = (-u_xlat16_1.y) + u_xlat10_1;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_2.w;
    u_xlat1.x = u_xlat16_1.x * _AlphaMultiplier;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTexture_ST;
uniform 	float _AlphaMultiplier;
uniform 	mediump float _UseFire;
uniform lowp sampler2D _DistortionTexture;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _NoiseTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_DistortionTexture, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat16_7.xy * vec2(_SwirlItensity) + u_xlat1.xy;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShape, u_xlat2.xz);
    u_xlat0.xyz = u_xlat10_2.xxx * u_xlat0.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_9 = texture(_FireNoise, u_xlat1.xy).x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat10_9;
    u_xlat16_1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_9 = u_xlat16_9 * 7.80000019 + (-u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FireColor.xyz * vec3(u_xlat16_9) + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0<_UseFire);
#else
    u_xlatb9 = 0.0<_UseFire;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat16_7.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTexture_ST.xy + _NoiseTexture_ST.zw;
    u_xlat2.z = u_xlat16_7.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.z = 1.0;
    u_xlat2.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_1 = texture(_NoiseTexture, u_xlat2.xz).x;
    u_xlat16_1.x = (-u_xlat16_1.y) + u_xlat10_1;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_2.w;
    u_xlat1.x = u_xlat16_1.x * _AlphaMultiplier;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTexture_ST;
uniform 	float _AlphaMultiplier;
uniform 	mediump float _UseFire;
uniform lowp sampler2D _DistortionTexture;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _NoiseTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_DistortionTexture, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat16_7.xy * vec2(_SwirlItensity) + u_xlat1.xy;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShape, u_xlat2.xz);
    u_xlat0.xyz = u_xlat10_2.xxx * u_xlat0.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_9 = texture(_FireNoise, u_xlat1.xy).x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat10_9;
    u_xlat16_1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_9 = u_xlat16_9 * 7.80000019 + (-u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FireColor.xyz * vec3(u_xlat16_9) + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0<_UseFire);
#else
    u_xlatb9 = 0.0<_UseFire;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat16_7.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTexture_ST.xy + _NoiseTexture_ST.zw;
    u_xlat2.z = u_xlat16_7.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.z = 1.0;
    u_xlat2.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_1 = texture(_NoiseTexture, u_xlat2.xz).x;
    u_xlat16_1.x = (-u_xlat16_1.y) + u_xlat10_1;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_2.w;
    u_xlat1.x = u_xlat16_1.x * _AlphaMultiplier;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTexture_ST;
uniform 	float _AlphaMultiplier;
uniform 	mediump float _UseFire;
uniform lowp sampler2D _DistortionTexture;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _NoiseTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_DistortionTexture, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat16_7.xy * vec2(_SwirlItensity) + u_xlat1.xy;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShape, u_xlat2.xz);
    u_xlat0.xyz = u_xlat10_2.xxx * u_xlat0.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_9 = texture(_FireNoise, u_xlat1.xy).x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat10_9;
    u_xlat16_1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_9 = u_xlat16_9 * 7.80000019 + (-u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FireColor.xyz * vec3(u_xlat16_9) + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0<_UseFire);
#else
    u_xlatb9 = 0.0<_UseFire;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat16_7.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTexture_ST.xy + _NoiseTexture_ST.zw;
    u_xlat2.z = u_xlat16_7.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.z = 1.0;
    u_xlat2.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_1 = texture(_NoiseTexture, u_xlat2.xz).x;
    u_xlat16_1.x = (-u_xlat16_1.y) + u_xlat10_1;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_2.w;
    u_xlat1.x = u_xlat16_1.x * _AlphaMultiplier;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTexture_ST;
uniform 	float _AlphaMultiplier;
uniform 	mediump float _UseFire;
uniform lowp sampler2D _DistortionTexture;
uniform lowp sampler2D _SmokeShape;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _NoiseTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec2 u_xlat10_7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_7.xy = texture(_DistortionTexture, u_xlat7.xy).xy;
    u_xlat16_7.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat16_7.xy * vec2(_SwirlItensity) + u_xlat1.xy;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShape, u_xlat2.xz);
    u_xlat0.xyz = u_xlat10_2.xxx * u_xlat0.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_9 = texture(_FireNoise, u_xlat1.xy).x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat10_9;
    u_xlat16_1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_9 = u_xlat16_9 * 7.80000019 + (-u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FireColor.xyz * vec3(u_xlat16_9) + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0<_UseFire);
#else
    u_xlatb9 = 0.0<_UseFire;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat16_7.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTexture_ST.xy + _NoiseTexture_ST.zw;
    u_xlat2.z = u_xlat16_7.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.z = 1.0;
    u_xlat2.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_1 = texture(_NoiseTexture, u_xlat2.xz).x;
    u_xlat16_1.x = (-u_xlat16_1.y) + u_xlat10_1;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_2.w;
    u_xlat1.x = u_xlat16_1.x * _AlphaMultiplier;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
}
}
}
CustomEditor "MiHoYoMaterialInspector"
}