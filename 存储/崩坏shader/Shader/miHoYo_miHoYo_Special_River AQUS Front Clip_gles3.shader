//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/River AQUS Front Clip" {
Properties {
[Header(Global)] _UV_Mix_Start_Distance ("UV_Mix_Start_Distance", Range(0, 3000)) = 400
_UV_Mix_Range ("UV_Mix_Range", Range(1, 500)) = 100
[Header(MainColor)] _RefractColor ("Refract Color", Color) = (0,0.4627451,1,1)
_ReflectColor ("Reflect Color", Color) = (1,1,1,1)
_WaterColor ("Water Color", Color) = (1,1,1,1)
_FrontRefractFade ("Front Refract Fade", Float) = 1.45
_BackRefractFade ("Back Refract Fade", Float) = 1.45
_FrontDensity ("Front Density", Range(0, 10)) = 1.74
_BackDensity ("Back Density", Range(0, 10)) = 1.74
[Header(Transparency)] _FrontShoreTransparency ("Front Shore Transparency", Range(0.0001, 10)) = 0.04
_FrontShoreFade ("Front Shore Fade", Range(0.0001, 10)) = 0.3
_BackShoreTransparency ("Back Shore Transparency", Range(0.0001, 10)) = 0.04
_BackShoreFade ("Back Shore Fade", Range(0.0001, 10)) = 0.3
[Header(Fresnel)] _FrontFresnelBias ("Front Fresnel Bias", Range(0, 1)) = 0.1
_BackFresnelBias ("Back Fresnel Bias", Range(0, 1)) = 0.1
[Header(Refraction)] _ReflectionTex ("Reflection", 2D) = "white" { }
_FrontRefractDistort ("Front Refraction Distort", Range(0, 0.1)) = 0.067
_BackRefractDistort ("Back Refraction Distort", Range(0, 0.1)) = 0.067
_FrontReflectIntensity ("Front Reflection Intensity", Range(0, 1)) = 0.6
_BackReflectIntensity ("Back Reflection Intensity", Range(0, 1)) = 0.6
_FrontReflectDistort ("Front Reflction Distortion", Range(0, 5)) = 0.3
_BackReflectDistort ("Back Reflection Distortion", Range(0, 5)) = 0.3
_BackCriticalAngle ("Total Reflection Critial Angle", Float) = 65
_BackFogDensity ("Back Fog Density", Range(0, 10)) = 0.5
_BackFogEffectLimit ("Back Fog Effect Limit", Range(0, 1)) = 0.5
_BackFogEffectStart ("Back Fog Effect Start", Range(0, 1)) = 0.5
_BackFogStart ("Back Apply Fog Start", Range(0, 1000)) = 100
_BackFogEnd ("Back Apply Fog End", Range(0, 1000)) = 200
[Header(Small Wave)] _SmallWavesTexture ("Small Waves Bump", 2D) = "bump" { }
_SmallWavesParams ("Small Waves Tilling(X, Y) Speed(Z, W)", Vector) = (1,1,1,1)
[Header(Large Wave)] _LargeWavesTexture ("Large Waves Bump", 2D) = "bump" { }
_LargeWavesParams ("Large Waves Tilling(X, Y) Speed(Z, W)", Vector) = (1,1,1,1)
[Header(Shore Foam)] _ShoreFoam ("Foam", 2D) = "black" { }
_ShoreFoamParams ("Shore Foam Tilling(X, Y) Speed(Z, W)", Vector) = (10,10,1,1)
_ShoreFoamColor ("ShoreFoam Color", Color) = (1,1,1,0)
_ShoreFoamColorStrength ("Shore Foam Color Strength", Range(0, 1000)) = 1
_ShoreFoamDepth ("Shore Foam Depth", Range(0, 5)) = 0.3
_ClipRadius ("Water Plane Clip Radius", Range(0, 100)) = 20
[Toggle(SPECIAL_STATE)] _SpecialState ("Special State", Float) = 0
_SPTex ("SP Tex", 2D) = "white" { }
_SPNoiseTex ("SP Noise Tex", 2D) = "white" { }
_SPNoiseScaler ("SP Noise Scaler", Range(0, 10)) = 1
_SPIntensity ("SP Intensity", Range(0, 1)) = 0.5
_SPTransition ("SP Transition", Range(0, 10)) = 0
_SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
_SPOpaqueness ("SP Opaqueness", Range(0, 1)) = 1
_SPOutlineColor ("SP Outline Color", Color) = (1,1,1,1)
_SPTransitionEmissionScaler ("SP Transition Emission Scaler", Range(1, 100)) = 1
_SPTransitionBloomFactor ("SP Transition Bloom Factor", Float) = 1
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FRONT"
  LOD 200
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 3762
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
float u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec2 u_xlat16_11;
float u_xlat13;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1.xy = u_xlat16_11.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat15 = u_xlat16_16 + (-_UV_Mix_Start_Distance);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_16);
    u_xlat16_6 = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_6) + 1.0;
    u_xlat5.x = u_xlat15 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat5.x * u_xlat5.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat5.x = _FrontRefractDistort * -0.75;
    u_xlat5.x = u_xlat16_6 * u_xlat5.x + _FrontRefractDistort;
    u_xlat16_1.xy = u_xlat5.xx * u_xlat16_1.xz;
    u_xlat16_1.z = 0.0;
    u_xlat5.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.x = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD5.z);
#else
    u_xlatb5 = u_xlat5.x>=vs_TEXCOORD5.z;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xyz = u_xlat16_1.xyz * u_xlat5.xxx + vs_TEXCOORD5.xyw;
    u_xlat16_1.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.xyz = texture(_RefractionTex, u_xlat16_1.xy).xyz;
    u_xlat16_1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat16_1.xy).x;
    u_xlat3 = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat3 = u_xlat3 + (-vs_TEXCOORD5.z);
    u_xlat8.xy = vec2(u_xlat3) * vec2(0.0500000007, -0.5);
    u_xlat4.xyz = u_xlat8.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_FrontRefractFade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat4.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat5.xyz) + _ReflectColor.xyz;
    u_xlat16_13 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_13;
    u_xlat13 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat15 = u_xlat3 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat3 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat3 + 9.99999975e-05;
    u_xlat3 = log2(u_xlat3);
    u_xlat3 = u_xlat3 * _FrontShoreFade;
    u_xlat3 = exp2(u_xlat3);
    u_xlat1.w = min(u_xlat3, 1.0);
    u_xlat16_2.x = (-u_xlat15) + 1.0;
    u_xlat10_15 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_15 = u_xlat16_2.x * u_xlat10_15;
    u_xlat15 = u_xlat1.w * u_xlat16_15;
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat8.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
float u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec2 u_xlat16_11;
float u_xlat13;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1.xy = u_xlat16_11.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat15 = u_xlat16_16 + (-_UV_Mix_Start_Distance);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_16);
    u_xlat16_6 = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_6) + 1.0;
    u_xlat5.x = u_xlat15 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat5.x * u_xlat5.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat5.x = _FrontRefractDistort * -0.75;
    u_xlat5.x = u_xlat16_6 * u_xlat5.x + _FrontRefractDistort;
    u_xlat16_1.xy = u_xlat5.xx * u_xlat16_1.xz;
    u_xlat16_1.z = 0.0;
    u_xlat5.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.x = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD5.z);
#else
    u_xlatb5 = u_xlat5.x>=vs_TEXCOORD5.z;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xyz = u_xlat16_1.xyz * u_xlat5.xxx + vs_TEXCOORD5.xyw;
    u_xlat16_1.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.xyz = texture(_RefractionTex, u_xlat16_1.xy).xyz;
    u_xlat16_1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat16_1.xy).x;
    u_xlat3 = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat3 = u_xlat3 + (-vs_TEXCOORD5.z);
    u_xlat8.xy = vec2(u_xlat3) * vec2(0.0500000007, -0.5);
    u_xlat4.xyz = u_xlat8.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_FrontRefractFade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat4.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat5.xyz) + _ReflectColor.xyz;
    u_xlat16_13 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_13;
    u_xlat13 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat15 = u_xlat3 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat3 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat3 + 9.99999975e-05;
    u_xlat3 = log2(u_xlat3);
    u_xlat3 = u_xlat3 * _FrontShoreFade;
    u_xlat3 = exp2(u_xlat3);
    u_xlat1.w = min(u_xlat3, 1.0);
    u_xlat16_2.x = (-u_xlat15) + 1.0;
    u_xlat10_15 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_15 = u_xlat16_2.x * u_xlat10_15;
    u_xlat15 = u_xlat1.w * u_xlat16_15;
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat8.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
float u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec2 u_xlat16_11;
float u_xlat13;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1.xy = u_xlat16_11.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat15 = u_xlat16_16 + (-_UV_Mix_Start_Distance);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_16);
    u_xlat16_6 = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_6) + 1.0;
    u_xlat5.x = u_xlat15 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat5.x * u_xlat5.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat5.x = _FrontRefractDistort * -0.75;
    u_xlat5.x = u_xlat16_6 * u_xlat5.x + _FrontRefractDistort;
    u_xlat16_1.xy = u_xlat5.xx * u_xlat16_1.xz;
    u_xlat16_1.z = 0.0;
    u_xlat5.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.x = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD5.z);
#else
    u_xlatb5 = u_xlat5.x>=vs_TEXCOORD5.z;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xyz = u_xlat16_1.xyz * u_xlat5.xxx + vs_TEXCOORD5.xyw;
    u_xlat16_1.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.xyz = texture(_RefractionTex, u_xlat16_1.xy).xyz;
    u_xlat16_1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat16_1.xy).x;
    u_xlat3 = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat3 = u_xlat3 + (-vs_TEXCOORD5.z);
    u_xlat8.xy = vec2(u_xlat3) * vec2(0.0500000007, -0.5);
    u_xlat4.xyz = u_xlat8.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_FrontRefractFade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat4.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat5.xyz) + _ReflectColor.xyz;
    u_xlat16_13 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_13;
    u_xlat13 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat15 = u_xlat3 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat3 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat3 + 9.99999975e-05;
    u_xlat3 = log2(u_xlat3);
    u_xlat3 = u_xlat3 * _FrontShoreFade;
    u_xlat3 = exp2(u_xlat3);
    u_xlat1.w = min(u_xlat3, 1.0);
    u_xlat16_2.x = (-u_xlat15) + 1.0;
    u_xlat10_15 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_15 = u_xlat16_2.x * u_xlat10_15;
    u_xlat15 = u_xlat1.w * u_xlat16_15;
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat8.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat18 * u_xlat18;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_2.x * u_xlat18 + _FrontRefractDistort;
    u_xlat16_2.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_2.z = 0.0;
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=vs_TEXCOORD5.z);
#else
    u_xlatb18 = u_xlat18>=vs_TEXCOORD5.z;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat21 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat21 = u_xlat21 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat21) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat16_21 = u_xlat16_19 * 0.00499999989;
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_19);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = min(u_xlat16_21, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat11.xyz = vec3(u_xlat16_6) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat11.xyz = (-u_xlat3.xyz) + u_xlat11.xyz;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat21 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _FrontShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat1.w = min(u_xlat18, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat10_18 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_18 = u_xlat16_2.x * u_xlat10_18;
    u_xlat18 = u_xlat1.w * u_xlat16_18;
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat18 * u_xlat18;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_2.x * u_xlat18 + _FrontRefractDistort;
    u_xlat16_2.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_2.z = 0.0;
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=vs_TEXCOORD5.z);
#else
    u_xlatb18 = u_xlat18>=vs_TEXCOORD5.z;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat21 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat21 = u_xlat21 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat21) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat16_21 = u_xlat16_19 * 0.00499999989;
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_19);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = min(u_xlat16_21, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat11.xyz = vec3(u_xlat16_6) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat11.xyz = (-u_xlat3.xyz) + u_xlat11.xyz;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat21 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _FrontShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat1.w = min(u_xlat18, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat10_18 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_18 = u_xlat16_2.x * u_xlat10_18;
    u_xlat18 = u_xlat1.w * u_xlat16_18;
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat18 * u_xlat18;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_2.x * u_xlat18 + _FrontRefractDistort;
    u_xlat16_2.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_2.z = 0.0;
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=vs_TEXCOORD5.z);
#else
    u_xlatb18 = u_xlat18>=vs_TEXCOORD5.z;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat21 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat21 = u_xlat21 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat21) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat16_21 = u_xlat16_19 * 0.00499999989;
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_19);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = min(u_xlat16_21, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat11.xyz = vec3(u_xlat16_6) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat11.xyz = (-u_xlat3.xyz) + u_xlat11.xyz;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat21 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _FrontShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat1.w = min(u_xlat18, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat10_18 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_18 = u_xlat16_2.x * u_xlat10_18;
    u_xlat18 = u_xlat1.w * u_xlat16_18;
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
float u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec2 u_xlat16_11;
float u_xlat13;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1.xy = u_xlat16_11.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat15 = u_xlat16_16 + (-_UV_Mix_Start_Distance);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_16);
    u_xlat16_6 = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_6) + 1.0;
    u_xlat5.x = u_xlat15 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat5.x * u_xlat5.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat5.x = _FrontRefractDistort * -0.75;
    u_xlat5.x = u_xlat16_6 * u_xlat5.x + _FrontRefractDistort;
    u_xlat16_1.xy = u_xlat5.xx * u_xlat16_1.xz;
    u_xlat16_1.z = 0.0;
    u_xlat5.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.x = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD5.z);
#else
    u_xlatb5 = u_xlat5.x>=vs_TEXCOORD5.z;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xyz = u_xlat16_1.xyz * u_xlat5.xxx + vs_TEXCOORD5.xyw;
    u_xlat16_1.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.xyz = texture(_RefractionTex, u_xlat16_1.xy).xyz;
    u_xlat16_1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat16_1.xy).x;
    u_xlat3 = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat3 = u_xlat3 + (-vs_TEXCOORD5.z);
    u_xlat8.xy = vec2(u_xlat3) * vec2(0.0500000007, -0.5);
    u_xlat4.xyz = u_xlat8.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_FrontRefractFade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat4.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat5.xyz) + _ReflectColor.xyz;
    u_xlat16_13 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_13;
    u_xlat13 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat15 = u_xlat3 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat3 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat3 + 9.99999975e-05;
    u_xlat3 = log2(u_xlat3);
    u_xlat3 = u_xlat3 * _FrontShoreFade;
    u_xlat3 = exp2(u_xlat3);
    u_xlat1.w = min(u_xlat3, 1.0);
    u_xlat16_2.x = (-u_xlat15) + 1.0;
    u_xlat10_15 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_15 = u_xlat16_2.x * u_xlat10_15;
    u_xlat15 = u_xlat1.w * u_xlat16_15;
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat8.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
float u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec2 u_xlat16_11;
float u_xlat13;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1.xy = u_xlat16_11.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat15 = u_xlat16_16 + (-_UV_Mix_Start_Distance);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_16);
    u_xlat16_6 = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_6) + 1.0;
    u_xlat5.x = u_xlat15 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat5.x * u_xlat5.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat5.x = _FrontRefractDistort * -0.75;
    u_xlat5.x = u_xlat16_6 * u_xlat5.x + _FrontRefractDistort;
    u_xlat16_1.xy = u_xlat5.xx * u_xlat16_1.xz;
    u_xlat16_1.z = 0.0;
    u_xlat5.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.x = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD5.z);
#else
    u_xlatb5 = u_xlat5.x>=vs_TEXCOORD5.z;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xyz = u_xlat16_1.xyz * u_xlat5.xxx + vs_TEXCOORD5.xyw;
    u_xlat16_1.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.xyz = texture(_RefractionTex, u_xlat16_1.xy).xyz;
    u_xlat16_1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat16_1.xy).x;
    u_xlat3 = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat3 = u_xlat3 + (-vs_TEXCOORD5.z);
    u_xlat8.xy = vec2(u_xlat3) * vec2(0.0500000007, -0.5);
    u_xlat4.xyz = u_xlat8.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_FrontRefractFade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat4.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat5.xyz) + _ReflectColor.xyz;
    u_xlat16_13 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_13;
    u_xlat13 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat15 = u_xlat3 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat3 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat3 + 9.99999975e-05;
    u_xlat3 = log2(u_xlat3);
    u_xlat3 = u_xlat3 * _FrontShoreFade;
    u_xlat3 = exp2(u_xlat3);
    u_xlat1.w = min(u_xlat3, 1.0);
    u_xlat16_2.x = (-u_xlat15) + 1.0;
    u_xlat10_15 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_15 = u_xlat16_2.x * u_xlat10_15;
    u_xlat15 = u_xlat1.w * u_xlat16_15;
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat8.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
float u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec2 u_xlat16_11;
float u_xlat13;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1.xy = u_xlat16_11.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat15 = u_xlat16_16 + (-_UV_Mix_Start_Distance);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_16);
    u_xlat16_6 = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_6) + 1.0;
    u_xlat5.x = u_xlat15 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat5.x * u_xlat5.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat5.x = _FrontRefractDistort * -0.75;
    u_xlat5.x = u_xlat16_6 * u_xlat5.x + _FrontRefractDistort;
    u_xlat16_1.xy = u_xlat5.xx * u_xlat16_1.xz;
    u_xlat16_1.z = 0.0;
    u_xlat5.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.x = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD5.z);
#else
    u_xlatb5 = u_xlat5.x>=vs_TEXCOORD5.z;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xyz = u_xlat16_1.xyz * u_xlat5.xxx + vs_TEXCOORD5.xyw;
    u_xlat16_1.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.xyz = texture(_RefractionTex, u_xlat16_1.xy).xyz;
    u_xlat16_1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat16_1.xy).x;
    u_xlat3 = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat3 = u_xlat3 + (-vs_TEXCOORD5.z);
    u_xlat8.xy = vec2(u_xlat3) * vec2(0.0500000007, -0.5);
    u_xlat4.xyz = u_xlat8.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_FrontRefractFade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat4.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat5.xyz) + _ReflectColor.xyz;
    u_xlat16_13 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_13;
    u_xlat13 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat15 = u_xlat3 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat3 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat3 + 9.99999975e-05;
    u_xlat3 = log2(u_xlat3);
    u_xlat3 = u_xlat3 * _FrontShoreFade;
    u_xlat3 = exp2(u_xlat3);
    u_xlat1.w = min(u_xlat3, 1.0);
    u_xlat16_2.x = (-u_xlat15) + 1.0;
    u_xlat10_15 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_15 = u_xlat16_2.x * u_xlat10_15;
    u_xlat15 = u_xlat1.w * u_xlat16_15;
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat8.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat18 * u_xlat18;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_2.x * u_xlat18 + _FrontRefractDistort;
    u_xlat16_2.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_2.z = 0.0;
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=vs_TEXCOORD5.z);
#else
    u_xlatb18 = u_xlat18>=vs_TEXCOORD5.z;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat21 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat21 = u_xlat21 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat21) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat16_21 = u_xlat16_19 * 0.00499999989;
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_19);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = min(u_xlat16_21, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat11.xyz = vec3(u_xlat16_6) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat11.xyz = (-u_xlat3.xyz) + u_xlat11.xyz;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat21 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _FrontShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat1.w = min(u_xlat18, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat10_18 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_18 = u_xlat16_2.x * u_xlat10_18;
    u_xlat18 = u_xlat1.w * u_xlat16_18;
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat18 * u_xlat18;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_2.x * u_xlat18 + _FrontRefractDistort;
    u_xlat16_2.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_2.z = 0.0;
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=vs_TEXCOORD5.z);
#else
    u_xlatb18 = u_xlat18>=vs_TEXCOORD5.z;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat21 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat21 = u_xlat21 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat21) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat16_21 = u_xlat16_19 * 0.00499999989;
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_19);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = min(u_xlat16_21, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat11.xyz = vec3(u_xlat16_6) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat11.xyz = (-u_xlat3.xyz) + u_xlat11.xyz;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat21 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _FrontShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat1.w = min(u_xlat18, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat10_18 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_18 = u_xlat16_2.x * u_xlat10_18;
    u_xlat18 = u_xlat1.w * u_xlat16_18;
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat18 * u_xlat18;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_2.x * u_xlat18 + _FrontRefractDistort;
    u_xlat16_2.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_2.z = 0.0;
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=vs_TEXCOORD5.z);
#else
    u_xlatb18 = u_xlat18>=vs_TEXCOORD5.z;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat21 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat21 = u_xlat21 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat21) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat16_21 = u_xlat16_19 * 0.00499999989;
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_19);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = min(u_xlat16_21, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat11.xyz = vec3(u_xlat16_6) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat11.xyz = (-u_xlat3.xyz) + u_xlat11.xyz;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat21 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _FrontShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat1.w = min(u_xlat18, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat10_18 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_18 = u_xlat16_2.x * u_xlat10_18;
    u_xlat18 = u_xlat1.w * u_xlat16_18;
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _ClipRadius;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp float u_xlat10_12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat18 * u_xlat18;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_1.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_1 = u_xlat0;
    } else {
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _ClipRadius;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp float u_xlat10_12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat18 * u_xlat18;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_1.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_1 = u_xlat0;
    } else {
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _ClipRadius;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp float u_xlat10_12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat18 * u_xlat18;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_1.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_1 = u_xlat0;
    } else {
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _ClipRadius;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
lowp float u_xlat10_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
float u_xlat20;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat18 * u_xlat18;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_7.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_7.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_7.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_7.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat20 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat20 = u_xlat20 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat20) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_4.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_4.xy).xyz;
    u_xlat16_20 = u_xlat16_1.x * 0.00499999989;
    u_xlat16_20 = min(u_xlat16_20, 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat11.xyz = vec3(u_xlat16_20) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_1 = u_xlat0;
    } else {
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _ClipRadius;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
lowp float u_xlat10_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
float u_xlat20;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat18 * u_xlat18;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_7.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_7.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_7.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_7.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat20 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat20 = u_xlat20 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat20) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_4.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_4.xy).xyz;
    u_xlat16_20 = u_xlat16_1.x * 0.00499999989;
    u_xlat16_20 = min(u_xlat16_20, 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat11.xyz = vec3(u_xlat16_20) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_1 = u_xlat0;
    } else {
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _ClipRadius;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
lowp float u_xlat10_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
float u_xlat20;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat18 * u_xlat18;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_7.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_7.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_7.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_7.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat20 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat20 = u_xlat20 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat20) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_4.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_4.xy).xyz;
    u_xlat16_20 = u_xlat16_1.x * 0.00499999989;
    u_xlat16_20 = min(u_xlat16_20, 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat11.xyz = vec3(u_xlat16_20) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_1 = u_xlat0;
    } else {
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _ClipRadius;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp float u_xlat10_12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat18 * u_xlat18;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_1.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_1 = u_xlat0;
    } else {
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _ClipRadius;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp float u_xlat10_12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat18 * u_xlat18;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_1.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_1 = u_xlat0;
    } else {
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _ClipRadius;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp float u_xlat10_12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat18 * u_xlat18;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_1.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_1 = u_xlat0;
    } else {
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _ClipRadius;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
lowp float u_xlat10_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
float u_xlat20;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat18 * u_xlat18;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_7.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_7.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_7.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_7.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat20 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat20 = u_xlat20 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat20) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_4.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_4.xy).xyz;
    u_xlat16_20 = u_xlat16_1.x * 0.00499999989;
    u_xlat16_20 = min(u_xlat16_20, 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat11.xyz = vec3(u_xlat16_20) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_1 = u_xlat0;
    } else {
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _ClipRadius;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
lowp float u_xlat10_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
float u_xlat20;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat18 * u_xlat18;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_7.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_7.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_7.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_7.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat20 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat20 = u_xlat20 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat20) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_4.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_4.xy).xyz;
    u_xlat16_20 = u_xlat16_1.x * 0.00499999989;
    u_xlat16_20 = min(u_xlat16_20, 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat11.xyz = vec3(u_xlat16_20) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_1 = u_xlat0;
    } else {
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _ClipRadius;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
lowp float u_xlat10_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
float u_xlat20;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat18 * u_xlat18;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_7.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_7.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_7.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_7.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat20 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat20 = u_xlat20 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat20) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_4.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_4.xy).xyz;
    u_xlat16_20 = u_xlat16_1.x * 0.00499999989;
    u_xlat16_20 = min(u_xlat16_20, 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat11.xyz = vec3(u_xlat16_20) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_1 = u_xlat0;
    } else {
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec2 u_xlat16_11;
float u_xlat13;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1.xy = u_xlat16_11.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat15 = u_xlat16_16 + (-_UV_Mix_Start_Distance);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_16);
    u_xlat16_6 = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_6) + 1.0;
    u_xlat5.x = u_xlat15 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat5.x * u_xlat5.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat5.x = _FrontRefractDistort * -0.75;
    u_xlat5.x = u_xlat16_6 * u_xlat5.x + _FrontRefractDistort;
    u_xlat16_1.xy = u_xlat5.xx * u_xlat16_1.xz;
    u_xlat16_1.z = 0.0;
    u_xlat5.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.x = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD5.z);
#else
    u_xlatb5 = u_xlat5.x>=vs_TEXCOORD5.z;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xyz = u_xlat16_1.xyz * u_xlat5.xxx + vs_TEXCOORD5.xyw;
    u_xlat16_1.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.xyz = texture(_RefractionTex, u_xlat16_1.xy).xyz;
    u_xlat16_1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat16_1.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.z);
    u_xlat8.xy = u_xlat3.xx * vec2(0.0500000007, -0.5);
    u_xlat4.xyz = u_xlat8.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_FrontRefractFade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat4.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat5.xyz) + _ReflectColor.xyz;
    u_xlat16_13 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_13;
    u_xlat13 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat15 = u_xlat3.x * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x + 9.99999975e-05;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _FrontShoreFade;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat1.w = min(u_xlat3.x, 1.0);
    u_xlat16_2.x = (-u_xlat15) + 1.0;
    u_xlat10_15 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_15 = u_xlat16_2.x * u_xlat10_15;
    u_xlat15 = u_xlat1.w * u_xlat16_15;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat8.xyz + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat15);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec2 u_xlat16_11;
float u_xlat13;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1.xy = u_xlat16_11.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat15 = u_xlat16_16 + (-_UV_Mix_Start_Distance);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_16);
    u_xlat16_6 = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_6) + 1.0;
    u_xlat5.x = u_xlat15 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat5.x * u_xlat5.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat5.x = _FrontRefractDistort * -0.75;
    u_xlat5.x = u_xlat16_6 * u_xlat5.x + _FrontRefractDistort;
    u_xlat16_1.xy = u_xlat5.xx * u_xlat16_1.xz;
    u_xlat16_1.z = 0.0;
    u_xlat5.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.x = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD5.z);
#else
    u_xlatb5 = u_xlat5.x>=vs_TEXCOORD5.z;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xyz = u_xlat16_1.xyz * u_xlat5.xxx + vs_TEXCOORD5.xyw;
    u_xlat16_1.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.xyz = texture(_RefractionTex, u_xlat16_1.xy).xyz;
    u_xlat16_1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat16_1.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.z);
    u_xlat8.xy = u_xlat3.xx * vec2(0.0500000007, -0.5);
    u_xlat4.xyz = u_xlat8.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_FrontRefractFade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat4.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat5.xyz) + _ReflectColor.xyz;
    u_xlat16_13 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_13;
    u_xlat13 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat15 = u_xlat3.x * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x + 9.99999975e-05;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _FrontShoreFade;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat1.w = min(u_xlat3.x, 1.0);
    u_xlat16_2.x = (-u_xlat15) + 1.0;
    u_xlat10_15 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_15 = u_xlat16_2.x * u_xlat10_15;
    u_xlat15 = u_xlat1.w * u_xlat16_15;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat8.xyz + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat15);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec2 u_xlat16_11;
float u_xlat13;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1.xy = u_xlat16_11.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat15 = u_xlat16_16 + (-_UV_Mix_Start_Distance);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_16);
    u_xlat16_6 = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_6) + 1.0;
    u_xlat5.x = u_xlat15 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat5.x * u_xlat5.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat5.x = _FrontRefractDistort * -0.75;
    u_xlat5.x = u_xlat16_6 * u_xlat5.x + _FrontRefractDistort;
    u_xlat16_1.xy = u_xlat5.xx * u_xlat16_1.xz;
    u_xlat16_1.z = 0.0;
    u_xlat5.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.x = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD5.z);
#else
    u_xlatb5 = u_xlat5.x>=vs_TEXCOORD5.z;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xyz = u_xlat16_1.xyz * u_xlat5.xxx + vs_TEXCOORD5.xyw;
    u_xlat16_1.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.xyz = texture(_RefractionTex, u_xlat16_1.xy).xyz;
    u_xlat16_1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat16_1.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.z);
    u_xlat8.xy = u_xlat3.xx * vec2(0.0500000007, -0.5);
    u_xlat4.xyz = u_xlat8.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_FrontRefractFade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat4.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat5.xyz) + _ReflectColor.xyz;
    u_xlat16_13 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_13;
    u_xlat13 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat15 = u_xlat3.x * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x + 9.99999975e-05;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _FrontShoreFade;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat1.w = min(u_xlat3.x, 1.0);
    u_xlat16_2.x = (-u_xlat15) + 1.0;
    u_xlat10_15 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_15 = u_xlat16_2.x * u_xlat10_15;
    u_xlat15 = u_xlat1.w * u_xlat16_15;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat8.xyz + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat15);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat18 * u_xlat18;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_2.x * u_xlat18 + _FrontRefractDistort;
    u_xlat16_2.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_2.z = 0.0;
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=vs_TEXCOORD5.z);
#else
    u_xlatb18 = u_xlat18>=vs_TEXCOORD5.z;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat21 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat21 = u_xlat21 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat21) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat16_21 = u_xlat16_19 * 0.00499999989;
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_19);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = min(u_xlat16_21, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat11.xyz = vec3(u_xlat16_6) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat11.xyz = (-u_xlat3.xyz) + u_xlat11.xyz;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat21 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _FrontShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat1.w = min(u_xlat18, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat10_18 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_18 = u_xlat16_2.x * u_xlat10_18;
    u_xlat18 = u_xlat1.w * u_xlat16_18;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat18);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat18 * u_xlat18;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_2.x * u_xlat18 + _FrontRefractDistort;
    u_xlat16_2.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_2.z = 0.0;
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=vs_TEXCOORD5.z);
#else
    u_xlatb18 = u_xlat18>=vs_TEXCOORD5.z;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat21 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat21 = u_xlat21 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat21) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat16_21 = u_xlat16_19 * 0.00499999989;
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_19);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = min(u_xlat16_21, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat11.xyz = vec3(u_xlat16_6) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat11.xyz = (-u_xlat3.xyz) + u_xlat11.xyz;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat21 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _FrontShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat1.w = min(u_xlat18, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat10_18 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_18 = u_xlat16_2.x * u_xlat10_18;
    u_xlat18 = u_xlat1.w * u_xlat16_18;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat18);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat18 * u_xlat18;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_2.x * u_xlat18 + _FrontRefractDistort;
    u_xlat16_2.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_2.z = 0.0;
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=vs_TEXCOORD5.z);
#else
    u_xlatb18 = u_xlat18>=vs_TEXCOORD5.z;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat21 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat21 = u_xlat21 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat21) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat16_21 = u_xlat16_19 * 0.00499999989;
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_19);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = min(u_xlat16_21, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat11.xyz = vec3(u_xlat16_6) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat11.xyz = (-u_xlat3.xyz) + u_xlat11.xyz;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat21 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _FrontShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat1.w = min(u_xlat18, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat10_18 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_18 = u_xlat16_2.x * u_xlat10_18;
    u_xlat18 = u_xlat1.w * u_xlat16_18;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat18);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec2 u_xlat16_11;
float u_xlat13;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1.xy = u_xlat16_11.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat15 = u_xlat16_16 + (-_UV_Mix_Start_Distance);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_16);
    u_xlat16_6 = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_6) + 1.0;
    u_xlat5.x = u_xlat15 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat5.x * u_xlat5.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat5.x = _FrontRefractDistort * -0.75;
    u_xlat5.x = u_xlat16_6 * u_xlat5.x + _FrontRefractDistort;
    u_xlat16_1.xy = u_xlat5.xx * u_xlat16_1.xz;
    u_xlat16_1.z = 0.0;
    u_xlat5.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.x = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD5.z);
#else
    u_xlatb5 = u_xlat5.x>=vs_TEXCOORD5.z;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xyz = u_xlat16_1.xyz * u_xlat5.xxx + vs_TEXCOORD5.xyw;
    u_xlat16_1.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.xyz = texture(_RefractionTex, u_xlat16_1.xy).xyz;
    u_xlat16_1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat16_1.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.z);
    u_xlat8.xy = u_xlat3.xx * vec2(0.0500000007, -0.5);
    u_xlat4.xyz = u_xlat8.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_FrontRefractFade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat4.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat5.xyz) + _ReflectColor.xyz;
    u_xlat16_13 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_13;
    u_xlat13 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat15 = u_xlat3.x * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x + 9.99999975e-05;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _FrontShoreFade;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat1.w = min(u_xlat3.x, 1.0);
    u_xlat16_2.x = (-u_xlat15) + 1.0;
    u_xlat10_15 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_15 = u_xlat16_2.x * u_xlat10_15;
    u_xlat15 = u_xlat1.w * u_xlat16_15;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat8.xyz + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat15);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec2 u_xlat16_11;
float u_xlat13;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1.xy = u_xlat16_11.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat15 = u_xlat16_16 + (-_UV_Mix_Start_Distance);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_16);
    u_xlat16_6 = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_6) + 1.0;
    u_xlat5.x = u_xlat15 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat5.x * u_xlat5.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat5.x = _FrontRefractDistort * -0.75;
    u_xlat5.x = u_xlat16_6 * u_xlat5.x + _FrontRefractDistort;
    u_xlat16_1.xy = u_xlat5.xx * u_xlat16_1.xz;
    u_xlat16_1.z = 0.0;
    u_xlat5.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.x = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD5.z);
#else
    u_xlatb5 = u_xlat5.x>=vs_TEXCOORD5.z;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xyz = u_xlat16_1.xyz * u_xlat5.xxx + vs_TEXCOORD5.xyw;
    u_xlat16_1.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.xyz = texture(_RefractionTex, u_xlat16_1.xy).xyz;
    u_xlat16_1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat16_1.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.z);
    u_xlat8.xy = u_xlat3.xx * vec2(0.0500000007, -0.5);
    u_xlat4.xyz = u_xlat8.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_FrontRefractFade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat4.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat5.xyz) + _ReflectColor.xyz;
    u_xlat16_13 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_13;
    u_xlat13 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat15 = u_xlat3.x * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x + 9.99999975e-05;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _FrontShoreFade;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat1.w = min(u_xlat3.x, 1.0);
    u_xlat16_2.x = (-u_xlat15) + 1.0;
    u_xlat10_15 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_15 = u_xlat16_2.x * u_xlat10_15;
    u_xlat15 = u_xlat1.w * u_xlat16_15;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat8.xyz + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat15);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec2 u_xlat16_11;
float u_xlat13;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1.xy = u_xlat16_11.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat15 = u_xlat16_16 + (-_UV_Mix_Start_Distance);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_16);
    u_xlat16_6 = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_6) + 1.0;
    u_xlat5.x = u_xlat15 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat5.x * u_xlat5.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat5.x = _FrontRefractDistort * -0.75;
    u_xlat5.x = u_xlat16_6 * u_xlat5.x + _FrontRefractDistort;
    u_xlat16_1.xy = u_xlat5.xx * u_xlat16_1.xz;
    u_xlat16_1.z = 0.0;
    u_xlat5.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.x = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD5.z);
#else
    u_xlatb5 = u_xlat5.x>=vs_TEXCOORD5.z;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xyz = u_xlat16_1.xyz * u_xlat5.xxx + vs_TEXCOORD5.xyw;
    u_xlat16_1.xy = u_xlat5.xy / u_xlat5.zz;
    u_xlat10_5.xyz = texture(_RefractionTex, u_xlat16_1.xy).xyz;
    u_xlat16_1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat16_1.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.z);
    u_xlat8.xy = u_xlat3.xx * vec2(0.0500000007, -0.5);
    u_xlat4.xyz = u_xlat8.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_FrontRefractFade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat4.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat5.xyz) + _ReflectColor.xyz;
    u_xlat16_13 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_13;
    u_xlat13 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat15 = u_xlat3.x * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x + 9.99999975e-05;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _FrontShoreFade;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat1.w = min(u_xlat3.x, 1.0);
    u_xlat16_2.x = (-u_xlat15) + 1.0;
    u_xlat10_15 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_15 = u_xlat16_2.x * u_xlat10_15;
    u_xlat15 = u_xlat1.w * u_xlat16_15;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat8.xyz + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat15);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat18 * u_xlat18;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_2.x * u_xlat18 + _FrontRefractDistort;
    u_xlat16_2.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_2.z = 0.0;
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=vs_TEXCOORD5.z);
#else
    u_xlatb18 = u_xlat18>=vs_TEXCOORD5.z;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat21 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat21 = u_xlat21 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat21) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat16_21 = u_xlat16_19 * 0.00499999989;
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_19);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = min(u_xlat16_21, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat11.xyz = vec3(u_xlat16_6) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat11.xyz = (-u_xlat3.xyz) + u_xlat11.xyz;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat21 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _FrontShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat1.w = min(u_xlat18, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat10_18 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_18 = u_xlat16_2.x * u_xlat10_18;
    u_xlat18 = u_xlat1.w * u_xlat16_18;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat18);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat18 * u_xlat18;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_2.x * u_xlat18 + _FrontRefractDistort;
    u_xlat16_2.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_2.z = 0.0;
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=vs_TEXCOORD5.z);
#else
    u_xlatb18 = u_xlat18>=vs_TEXCOORD5.z;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat21 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat21 = u_xlat21 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat21) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat16_21 = u_xlat16_19 * 0.00499999989;
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_19);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = min(u_xlat16_21, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat11.xyz = vec3(u_xlat16_6) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat11.xyz = (-u_xlat3.xyz) + u_xlat11.xyz;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat21 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _FrontShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat1.w = min(u_xlat18, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat10_18 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_18 = u_xlat16_2.x * u_xlat10_18;
    u_xlat18 = u_xlat1.w * u_xlat16_18;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat18);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat18 * u_xlat18;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_2.x * u_xlat18 + _FrontRefractDistort;
    u_xlat16_2.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_2.z = 0.0;
    u_xlat3.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=vs_TEXCOORD5.z);
#else
    u_xlatb18 = u_xlat18>=vs_TEXCOORD5.z;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_2.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_2.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat21 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat21 = u_xlat21 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat21) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat16_21 = u_xlat16_19 * 0.00499999989;
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_19);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = min(u_xlat16_21, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat11.xyz = vec3(u_xlat16_6) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat11.xyz = (-u_xlat3.xyz) + u_xlat11.xyz;
    u_xlat16_6 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat6 = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6 * u_xlat16_0 + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat21 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _FrontShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat1.w = min(u_xlat18, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat10_18 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_18 = u_xlat16_2.x * u_xlat10_18;
    u_xlat18 = u_xlat1.w * u_xlat16_18;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat18);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _ClipRadius;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp float u_xlat10_12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat18 * u_xlat18;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_1.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0.x + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_4 = u_xlat0;
    } else {
        u_xlat16_4 = u_xlat3;
    //ENDIF
    }
    u_xlat16_0.x = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_4.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_4.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _ClipRadius;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp float u_xlat10_12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat18 * u_xlat18;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_1.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0.x + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_4 = u_xlat0;
    } else {
        u_xlat16_4 = u_xlat3;
    //ENDIF
    }
    u_xlat16_0.x = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_4.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_4.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _ClipRadius;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp float u_xlat10_12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat18 * u_xlat18;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_1.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0.x + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_4 = u_xlat0;
    } else {
        u_xlat16_4 = u_xlat3;
    //ENDIF
    }
    u_xlat16_0.x = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_4.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_4.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _ClipRadius;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
lowp float u_xlat10_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
float u_xlat20;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_1);
    u_xlat18 = u_xlat16_1 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat18 * u_xlat18;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_7.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_7.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_7.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_7.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat20 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat20 = u_xlat20 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat20) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_4.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_4.xy).xyz;
    u_xlat16_20 = u_xlat16_1 * 0.00499999989;
    u_xlat16_20 = min(u_xlat16_20, 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat11.xyz = vec3(u_xlat16_20) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_1) + 1.0;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0.x + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1 * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_1 = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_4 = u_xlat0;
    } else {
        u_xlat16_4 = u_xlat3;
    //ENDIF
    }
    u_xlat16_0.x = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_4.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_4.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _ClipRadius;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
lowp float u_xlat10_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
float u_xlat20;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_1);
    u_xlat18 = u_xlat16_1 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat18 * u_xlat18;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_7.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_7.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_7.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_7.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat20 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat20 = u_xlat20 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat20) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_4.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_4.xy).xyz;
    u_xlat16_20 = u_xlat16_1 * 0.00499999989;
    u_xlat16_20 = min(u_xlat16_20, 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat11.xyz = vec3(u_xlat16_20) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_1) + 1.0;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0.x + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1 * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_1 = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_4 = u_xlat0;
    } else {
        u_xlat16_4 = u_xlat3;
    //ENDIF
    }
    u_xlat16_0.x = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_4.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_4.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _ClipRadius;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
lowp float u_xlat10_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
float u_xlat20;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_1);
    u_xlat18 = u_xlat16_1 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat18 * u_xlat18;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_7.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_7.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_7.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_7.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat20 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat20 = u_xlat20 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat20) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_4.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_4.xy).xyz;
    u_xlat16_20 = u_xlat16_1 * 0.00499999989;
    u_xlat16_20 = min(u_xlat16_20, 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat11.xyz = vec3(u_xlat16_20) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_1) + 1.0;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0.x + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1 * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_1 = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_4 = u_xlat0;
    } else {
        u_xlat16_4 = u_xlat3;
    //ENDIF
    }
    u_xlat16_0.x = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_4.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_4.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _ClipRadius;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp float u_xlat10_12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat18 * u_xlat18;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_1.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0.x + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_4 = u_xlat0;
    } else {
        u_xlat16_4 = u_xlat3;
    //ENDIF
    }
    u_xlat16_0.x = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_4.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_4.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _ClipRadius;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp float u_xlat10_12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat18 * u_xlat18;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_1.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0.x + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_4 = u_xlat0;
    } else {
        u_xlat16_4 = u_xlat3;
    //ENDIF
    }
    u_xlat16_0.x = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_4.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_4.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _ClipRadius;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp float u_xlat10_12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat18 = u_xlat16_1.x + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat18 * u_xlat18;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_1.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_13.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1.xy = u_xlat16_13.xy + u_xlat16_1.xy;
    u_xlat16_1.xz = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_1.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0.x + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1.x * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1.x;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_4 = u_xlat0;
    } else {
        u_xlat16_4 = u_xlat3;
    //ENDIF
    }
    u_xlat16_0.x = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_4.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_4.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _ClipRadius;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
lowp float u_xlat10_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
float u_xlat20;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_1);
    u_xlat18 = u_xlat16_1 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat18 * u_xlat18;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_7.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_7.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_7.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_7.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat20 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat20 = u_xlat20 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat20) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_4.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_4.xy).xyz;
    u_xlat16_20 = u_xlat16_1 * 0.00499999989;
    u_xlat16_20 = min(u_xlat16_20, 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat11.xyz = vec3(u_xlat16_20) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_1) + 1.0;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0.x + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1 * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_1 = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_4 = u_xlat0;
    } else {
        u_xlat16_4 = u_xlat3;
    //ENDIF
    }
    u_xlat16_0.x = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_4.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_4.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _ClipRadius;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
lowp float u_xlat10_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
float u_xlat20;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_1);
    u_xlat18 = u_xlat16_1 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat18 * u_xlat18;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_7.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_7.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_7.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_7.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat20 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat20 = u_xlat20 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat20) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_4.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_4.xy).xyz;
    u_xlat16_20 = u_xlat16_1 * 0.00499999989;
    u_xlat16_20 = min(u_xlat16_20, 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat11.xyz = vec3(u_xlat16_20) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_1) + 1.0;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0.x + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1 * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_1 = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_4 = u_xlat0;
    } else {
        u_xlat16_4 = u_xlat3;
    //ENDIF
    }
    u_xlat16_0.x = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_4.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_4.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _FrontDensity;
uniform 	float _FrontShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
vec2 u_xlat6;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat16_3.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat16_1.xy = in_TEXCOORD0.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD2 = u_xlat16_1;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD4.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _FrontDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD8.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD8.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _ReflectColor;
uniform 	vec4 _WaterColor;
uniform 	float _FrontRefractFade;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _ClipRadius;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _ShoreFoam;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp sampler2D _SPTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
lowp float u_xlat10_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
float u_xlat20;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_1);
    u_xlat18 = u_xlat16_1 + (-_UV_Mix_Start_Distance);
    u_xlat18 = u_xlat18 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat18 * u_xlat18;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat18 = _FrontRefractDistort * -0.75;
    u_xlat18 = u_xlat16_7.x * u_xlat18 + _FrontRefractDistort;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_7.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_7.xy = u_xlat16_7.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_7.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_7.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat16_3.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_3.xy = vec2(u_xlat18) * u_xlat16_7.xz;
    u_xlat16_3.z = 0.0;
    u_xlat8.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyw;
    u_xlat16_4.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat16_4.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = ceil(u_xlat18);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(u_xlat18) + vs_TEXCOORD5.xyw;
    u_xlat16_3.xy = u_xlat8.xy / u_xlat8.zz;
    u_xlat10_8.xyz = texture(_RefractionTex, u_xlat16_3.xy).xyz;
    u_xlat18 = u_xlat2.x + (-vs_TEXCOORD5.z);
    u_xlat2.x = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FrontShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat3.w = min(u_xlat2.x, 1.0);
    u_xlat5.xy = vec2(u_xlat18) * vec2(0.0500000007, -0.5);
    u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat5.yyy * vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.xyz = min(max(u_xlat11.xyz, 0.0), 1.0);
#else
    u_xlat11.xyz = clamp(u_xlat11.xyz, 0.0, 1.0);
#endif
    u_xlat11.xyz = u_xlat11.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat11.xyz = log2(u_xlat11.xyz);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_FrontRefractFade);
    u_xlat11.xyz = exp2(u_xlat11.xyz);
    u_xlat2.xyz = u_xlat10_8.xyz * u_xlat11.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat11.xy = u_xlat16_7.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat11.xy = u_xlat11.xy * vs_TEXCOORD5.ww;
    u_xlat11.xy = u_xlat5.xx * u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(0.5, 0.5);
    u_xlat20 = vs_TEXCOORD5.z * _ProjectionParams.w;
    u_xlat20 = u_xlat20 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat11.xy = vec2(u_xlat20) * (-u_xlat11.xy) + u_xlat11.xy;
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD5.xy;
    u_xlat16_4.xy = u_xlat11.xy / vs_TEXCOORD5.ww;
    u_xlat10_11.xyz = texture(_ReflectionTex, u_xlat16_4.xy).xyz;
    u_xlat16_20 = u_xlat16_1 * 0.00499999989;
    u_xlat16_20 = min(u_xlat16_20, 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat11.xyz = u_xlat10_11.xyz + (-_ReflectColor.xyz);
    u_xlat11.xyz = vec3(u_xlat16_20) * u_xlat11.xyz + _ReflectColor.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_1) + 1.0;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat6.x = (-_FrontFresnelBias) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat16_0.x + _FrontFresnelBias;
    u_xlat0.x = u_xlat0.x * _FrontReflectIntensity;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat18 * vs_TEXCOORD7.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10_2.x = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_1 * u_xlat10_2.x;
    u_xlat18 = u_xlat3.w * u_xlat16_18;
    u_xlat2.xyz = (-u_xlat0.xyz) + vs_TEXCOORD7.xyz;
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xz + (-vs_TEXCOORD9.xz);
    u_xlat10_12 = texture(_SPNoiseTex, vs_TEXCOORD8.zw).x;
    u_xlat18 = u_xlat10_12 * _SPNoiseScaler;
    u_xlat16_1 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_1 = u_xlat10_12 * _SPNoiseScaler + u_xlat16_1;
    u_xlat0.x = _SPTransition * _ClipRadius;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1;
#endif
    if(u_xlatb0){
        u_xlat10_1 = texture(_SPTex, vs_TEXCOORD8.xy);
        u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
        u_xlat16_4.x = u_xlat18 * 1.99000001 + -1.0;
        u_xlat0.x = _SPNoiseScaler * _SPTransition;
        u_xlat6.xy = u_xlat0.xx * vec2(1.70000005, 1.5) + (-u_xlat16_4.xx);
        u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
        u_xlat6.xy = floor(u_xlat6.xy);
        u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
        u_xlati6.xy = ivec2(u_xlat6.xy);
        u_xlat0.x = u_xlat0.x * 1.70000005 + (-u_xlat16_4.x);
        u_xlat0.x = u_xlat0.x * 10.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
        u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
        u_xlat16_4.xyz = (u_xlati6.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
        u_xlat0.x = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
        u_xlat16_2.xyz = (u_xlati6.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
        u_xlat1 = (-u_xlat3) + u_xlat16_2;
        u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
        u_xlat16_4 = u_xlat0;
    } else {
        u_xlat16_4 = u_xlat3;
    //ENDIF
    }
    u_xlat16_0.x = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_4.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_4.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
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
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
}
}
}
Fallback "Diffuse"
}