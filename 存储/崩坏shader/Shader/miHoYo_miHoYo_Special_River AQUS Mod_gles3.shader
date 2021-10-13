//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/River AQUS Mod" {
Properties {
[Header(MainColor)] _RefractColor ("Refract Color", Color) = (0,0.4627451,1,1)
_ReflectColor ("Reflect Color", Color) = (1,1,1,1)
_WaterColor ("Water Color", Color) = (1,1,1,1)
_FrontRefractFade ("Front Refract Fade", Float) = 1.45
_BackRefractFade ("Back Refract Fade", Float) = 1.45
_FrontDensity ("Front Density", Range(0, 10)) = 1.74
_BackDensity ("Back Density", Range(0, 10)) = 1.74
[Header(Transparency)] _FrontShoreTransparency ("Front Shore Transparency", Range(0.0001, 100)) = 0.04
_FrontShoreFade ("Front Shore Fade", Range(0.0001, 100)) = 0.3
_BackShoreTransparency ("Back Shore Transparency", Range(0.0001, 10)) = 0.04
_BackShoreFade ("Back Shore Fade", Range(0.0001, 10)) = 0.3
[Header(Fresnel)] _FrontFresnelBias ("Front Fresnel Bias", Range(0, 1)) = 0.1
_BackFresnelBias ("Back Fresnel Bias", Range(0, 1)) = 0.1
[Header(Specular)] _SunDir ("Sun Dir", Vector) = (1,1,1,1)
_Specular ("Water Specular Color strength", Range(0, 3)) = 0.15
_Gloss ("Water Gloss", Float) = 0.7
[Header(Refraction)] _ReflectionTex ("Reflection", 2D) = "white" { }
_FrontRefractDistort ("Front Refraction Distort", Range(0, 0.1)) = 0.067
_BackRefractDistort ("Back Refraction Distort", Range(0, 1)) = 0.067
_FrontReflectIntensity ("Front Reflection Intensity", Range(0, 1)) = 0.6
_BackReflectIntensity ("Back Reflection Intensity", Range(0, 1)) = 0.6
_FrontReflectDistort ("Front Reflction Distortion", Range(0, 5)) = 0.3
_BackReflectDistort ("Back Reflection Distortion", Range(0, 5)) = 0.3
_FrontReflectLerpFactor ("Front Reflect Lerp Factor", Range(0, 0.1)) = 0.005
_BackReflectLerpFactor ("Back Reflect Lerp Factor", Range(0, 0.1)) = 0.005
_BackCriticalAngle ("Total Reflection Critial Angle", Range(0, 90)) = 65
_BackAngleDistort ("Critial Angle Distort", Range(0, 500)) = 65
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
_ShoreFoamDepth ("Shore Foam Depth", Range(0, 500)) = 0.3
}
SubShader {
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FRONT"
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 57682
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.x = texture(_CustomDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FrontShoreFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD1.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    u_xlat10.xy = u_xlat10.xy * in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy + u_xlat10.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    u_xlat10.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001);
    vs_TEXCOORD0.zw = u_xlat10.xy * u_xlat2.xy + u_xlat3.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _FrontDensity;
    u_xlat2.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat2.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
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
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat15);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12.y = sqrt(u_xlat15);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat12.xy = vec2(_Time.y * _ShoreFoamParams.z, _Time.y * _ShoreFoamParams.w);
    u_xlat12.xy = u_xlat12.xy * vec2(0.100000001, 0.100000001);
    u_xlat3.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * u_xlat2.xy + u_xlat12.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat13.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat13.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat12.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = 10.0 / _FrontDensity;
    u_xlat1.xyz = vec3(u_xlat15) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _FrontShoreTransparency;
    vs_TEXCOORD7.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD7.w = float(1.0) / _ShoreFoamDepth;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _SunDir;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _RefractColor;
uniform 	vec4 _ReflectColor;
uniform 	float _FrontFresnelBias;
uniform 	float _FrontShoreFade;
uniform 	float _FrontRefractDistort;
uniform 	float _FrontReflectIntensity;
uniform 	float _FrontReflectDistort;
uniform 	float _FrontReflectLerpFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_FrontReflectDistort, _FrontReflectDistort));
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD5.ww;
    u_xlat12 = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat12 = u_xlat12 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xy = vec2(u_xlat12) * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_ReflectColor.xyz);
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _FrontReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_19);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _ReflectColor.xyz;
    u_xlat18 = (-_FrontReflectIntensity) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * _ReflectColor.xyz;
    u_xlat0.xyz = vec3(vec3(_FrontReflectIntensity, _FrontReflectIntensity, _FrontReflectIntensity)) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat4.xy = u_xlat16_1.xz * vec2(vec2(_FrontRefractDistort, _FrontRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat18 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat4.xy / vec2(u_xlat18);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat5.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = (-u_xlat5.xyz) * u_xlat10_4.xyz + u_xlat0.xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat5.xyz;
    u_xlat16_19 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_19) + 1.0;
    u_xlat16_21 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_21;
    u_xlat21 = (-_FrontFresnelBias) + 1.0;
    u_xlat18 = u_xlat21 * u_xlat16_18 + _FrontFresnelBias;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
    u_xlat18 = dot(_SunDir, _SunDir);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = _SunDir.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = u_xlat18 * _SunDir.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat18);
#else
    u_xlatb18 = 0.0<u_xlat18;
#endif
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_1.x);
    u_xlat16_1.x = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_1.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat3.x = u_xlat16_3 * u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * _Specular;
    u_xlat18 = u_xlat18 * 0.200000003;
    u_xlat16_1.x = max(u_xlat18, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat0.xyz;
    u_xlat16_19 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_19) + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat10_3 + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
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
    u_xlat0.w = min(u_xlat3.x, 1.0);
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
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
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
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
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
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
}
}
 Pass {
  Name "BACK"
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 131024
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
uniform 	float _BackDensity;
uniform 	float _BackShoreTransparency;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat7;
vec2 u_xlat8;
float u_xlat10;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat7.xy;
    u_xlat1.zw = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat1 = u_xlat1 * in_TEXCOORD0.xyxy;
    u_xlat2.xy = vec2(u_xlat1.z + u_xlat1.z, u_xlat1.w + u_xlat1.w);
    u_xlat8.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat8.xy * vec2(0.150000006, 0.150000006) + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat8.xy * vec2(0.100000001, 0.100000001) + u_xlat1.zw;
    u_xlat7.xy = u_xlat1.xy + u_xlat1.xy;
    u_xlat2.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat2.xy * vec2(0.150000006, 0.150000006) + u_xlat7.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = 10.0 / _BackDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _BackShoreTransparency;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _WaterColor;
uniform 	vec4 _RefractColor;
uniform 	float _BackRefractFade;
uniform 	float _BackFresnelBias;
uniform 	float _BackShoreFade;
uniform 	float _BackRefractDistort;
uniform 	float _BackReflectIntensity;
uniform 	float _BackReflectDistort;
uniform 	float _BackReflectLerpFactor;
uniform 	float _BackCriticalAngle;
uniform 	float _BackAngleDistort;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_4;
bool u_xlatb4;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_8;
float u_xlat10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat18;
mediump float u_xlat16_18;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_1.zw = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1 = u_xlat16_1 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1.xz = vec2((-u_xlat16_1.z) + (-u_xlat16_1.x), (-u_xlat16_1.w) + (-u_xlat16_1.y));
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_BackRefractDistort, _BackRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat10 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat0.xy / vec2(u_xlat10);
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat15 * -0.5;
    u_xlat15 = u_xlat15 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + 9.99999975e-05;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _BackShoreFade;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, 1.0);
    SV_Target0.w = u_xlat15;
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat3.xyz = log2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(_BackRefractFade);
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat4.xyz = u_xlat4.xyz / vec3(u_xlat16_16);
    u_xlat15 = u_xlat16_16 * _BackReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16_6 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_6) + 1.0;
    u_xlat16_4 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_4;
    u_xlat4.x = (-_BackFresnelBias) + 1.0;
    u_xlat18 = u_xlat4.x * u_xlat16_18 + _BackFresnelBias;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18);
    u_xlat18 = u_xlat18 * _BackReflectIntensity;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat4.y)<u_xlat4.y);
#else
    u_xlatb3 = (-u_xlat4.y)<u_xlat4.y;
#endif
    u_xlat16_6 = abs(u_xlat4.y);
    u_xlat16_8 = u_xlat16_6 * -0.0187292993 + 0.0742610022;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_6 + -0.212114394;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_6 + 1.57072878;
    u_xlat16_13 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = sqrt(u_xlat16_13);
    u_xlat16_4 = u_xlat16_13 * u_xlat16_8;
    u_xlat4.x = u_xlat16_4 * -2.0 + 3.14159274;
    u_xlat3.x = u_xlatb3 ? u_xlat4.x : float(0.0);
    u_xlat3.x = u_xlat16_8 * u_xlat16_13 + u_xlat3.x;
    u_xlat16_6 = u_xlat16_1.z + u_xlat16_1.x;
    u_xlat8.xy = u_xlat16_1.xz * vec2(vec2(_BackReflectDistort, _BackReflectDistort));
    u_xlat8.xy = u_xlat8.xy * vs_TEXCOORD5.ww;
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat16_6 * _BackAngleDistort;
    u_xlat3.x = u_xlat3.x * 57.2958298 + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat3.x<_BackCriticalAngle);
#else
    u_xlatb4 = u_xlat3.x<_BackCriticalAngle;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BackCriticalAngle<u_xlat3.x);
#else
    u_xlatb3 = _BackCriticalAngle<u_xlat3.x;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb4)) ? u_xlat0.xyz : _WaterColor.xyz;
    u_xlat0.x = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xx * (-u_xlat8.xy) + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WaterColor.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _WaterColor.xyz;
    SV_Target0.xyz = (bool(u_xlatb3)) ? u_xlat0.xyz : u_xlat16_1.xyz;
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
uniform 	float _BackDensity;
uniform 	float _BackShoreTransparency;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat7;
vec2 u_xlat8;
float u_xlat10;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat7.xy;
    u_xlat1.zw = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat1 = u_xlat1 * in_TEXCOORD0.xyxy;
    u_xlat2.xy = vec2(u_xlat1.z + u_xlat1.z, u_xlat1.w + u_xlat1.w);
    u_xlat8.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat8.xy * vec2(0.150000006, 0.150000006) + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat8.xy * vec2(0.100000001, 0.100000001) + u_xlat1.zw;
    u_xlat7.xy = u_xlat1.xy + u_xlat1.xy;
    u_xlat2.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat2.xy * vec2(0.150000006, 0.150000006) + u_xlat7.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = 10.0 / _BackDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _BackShoreTransparency;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _WaterColor;
uniform 	vec4 _RefractColor;
uniform 	float _BackRefractFade;
uniform 	float _BackFresnelBias;
uniform 	float _BackShoreFade;
uniform 	float _BackRefractDistort;
uniform 	float _BackReflectIntensity;
uniform 	float _BackReflectDistort;
uniform 	float _BackReflectLerpFactor;
uniform 	float _BackCriticalAngle;
uniform 	float _BackAngleDistort;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_4;
bool u_xlatb4;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_8;
float u_xlat10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat18;
mediump float u_xlat16_18;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_1.zw = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1 = u_xlat16_1 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1.xz = vec2((-u_xlat16_1.z) + (-u_xlat16_1.x), (-u_xlat16_1.w) + (-u_xlat16_1.y));
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_BackRefractDistort, _BackRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat10 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat0.xy / vec2(u_xlat10);
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat15 * -0.5;
    u_xlat15 = u_xlat15 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + 9.99999975e-05;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _BackShoreFade;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, 1.0);
    SV_Target0.w = u_xlat15;
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat3.xyz = log2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(_BackRefractFade);
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat4.xyz = u_xlat4.xyz / vec3(u_xlat16_16);
    u_xlat15 = u_xlat16_16 * _BackReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16_6 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_6) + 1.0;
    u_xlat16_4 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_4;
    u_xlat4.x = (-_BackFresnelBias) + 1.0;
    u_xlat18 = u_xlat4.x * u_xlat16_18 + _BackFresnelBias;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18);
    u_xlat18 = u_xlat18 * _BackReflectIntensity;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat4.y)<u_xlat4.y);
#else
    u_xlatb3 = (-u_xlat4.y)<u_xlat4.y;
#endif
    u_xlat16_6 = abs(u_xlat4.y);
    u_xlat16_8 = u_xlat16_6 * -0.0187292993 + 0.0742610022;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_6 + -0.212114394;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_6 + 1.57072878;
    u_xlat16_13 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = sqrt(u_xlat16_13);
    u_xlat16_4 = u_xlat16_13 * u_xlat16_8;
    u_xlat4.x = u_xlat16_4 * -2.0 + 3.14159274;
    u_xlat3.x = u_xlatb3 ? u_xlat4.x : float(0.0);
    u_xlat3.x = u_xlat16_8 * u_xlat16_13 + u_xlat3.x;
    u_xlat16_6 = u_xlat16_1.z + u_xlat16_1.x;
    u_xlat8.xy = u_xlat16_1.xz * vec2(vec2(_BackReflectDistort, _BackReflectDistort));
    u_xlat8.xy = u_xlat8.xy * vs_TEXCOORD5.ww;
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat16_6 * _BackAngleDistort;
    u_xlat3.x = u_xlat3.x * 57.2958298 + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat3.x<_BackCriticalAngle);
#else
    u_xlatb4 = u_xlat3.x<_BackCriticalAngle;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BackCriticalAngle<u_xlat3.x);
#else
    u_xlatb3 = _BackCriticalAngle<u_xlat3.x;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb4)) ? u_xlat0.xyz : _WaterColor.xyz;
    u_xlat0.x = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xx * (-u_xlat8.xy) + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WaterColor.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _WaterColor.xyz;
    SV_Target0.xyz = (bool(u_xlatb3)) ? u_xlat0.xyz : u_xlat16_1.xyz;
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
uniform 	float _BackDensity;
uniform 	float _BackShoreTransparency;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat7;
vec2 u_xlat8;
float u_xlat10;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat7.xy;
    u_xlat1.zw = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat1 = u_xlat1 * in_TEXCOORD0.xyxy;
    u_xlat2.xy = vec2(u_xlat1.z + u_xlat1.z, u_xlat1.w + u_xlat1.w);
    u_xlat8.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat8.xy * vec2(0.150000006, 0.150000006) + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat8.xy * vec2(0.100000001, 0.100000001) + u_xlat1.zw;
    u_xlat7.xy = u_xlat1.xy + u_xlat1.xy;
    u_xlat2.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat2.xy * vec2(0.150000006, 0.150000006) + u_xlat7.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = 10.0 / _BackDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _BackShoreTransparency;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _WaterColor;
uniform 	vec4 _RefractColor;
uniform 	float _BackRefractFade;
uniform 	float _BackFresnelBias;
uniform 	float _BackShoreFade;
uniform 	float _BackRefractDistort;
uniform 	float _BackReflectIntensity;
uniform 	float _BackReflectDistort;
uniform 	float _BackReflectLerpFactor;
uniform 	float _BackCriticalAngle;
uniform 	float _BackAngleDistort;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_4;
bool u_xlatb4;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_8;
float u_xlat10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat18;
mediump float u_xlat16_18;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_11.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_1.zw = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_11.xy;
    u_xlat16_1 = u_xlat16_1 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1.xz = vec2((-u_xlat16_1.z) + (-u_xlat16_1.x), (-u_xlat16_1.w) + (-u_xlat16_1.y));
    u_xlat16_1.y = 1.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_BackRefractDistort, _BackRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat10 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat0.xy / vec2(u_xlat10);
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat15 * -0.5;
    u_xlat15 = u_xlat15 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + 9.99999975e-05;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _BackShoreFade;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, 1.0);
    SV_Target0.w = u_xlat15;
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat3.xyz = log2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(_BackRefractFade);
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_16 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat4.xyz = u_xlat4.xyz / vec3(u_xlat16_16);
    u_xlat15 = u_xlat16_16 * _BackReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16_6 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat16_6) + 1.0;
    u_xlat16_4 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_4;
    u_xlat4.x = (-_BackFresnelBias) + 1.0;
    u_xlat18 = u_xlat4.x * u_xlat16_18 + _BackFresnelBias;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18);
    u_xlat18 = u_xlat18 * _BackReflectIntensity;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat4.y)<u_xlat4.y);
#else
    u_xlatb3 = (-u_xlat4.y)<u_xlat4.y;
#endif
    u_xlat16_6 = abs(u_xlat4.y);
    u_xlat16_8 = u_xlat16_6 * -0.0187292993 + 0.0742610022;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_6 + -0.212114394;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_6 + 1.57072878;
    u_xlat16_13 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = sqrt(u_xlat16_13);
    u_xlat16_4 = u_xlat16_13 * u_xlat16_8;
    u_xlat4.x = u_xlat16_4 * -2.0 + 3.14159274;
    u_xlat3.x = u_xlatb3 ? u_xlat4.x : float(0.0);
    u_xlat3.x = u_xlat16_8 * u_xlat16_13 + u_xlat3.x;
    u_xlat16_6 = u_xlat16_1.z + u_xlat16_1.x;
    u_xlat8.xy = u_xlat16_1.xz * vec2(vec2(_BackReflectDistort, _BackReflectDistort));
    u_xlat8.xy = u_xlat8.xy * vs_TEXCOORD5.ww;
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat16_6 * _BackAngleDistort;
    u_xlat3.x = u_xlat3.x * 57.2958298 + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat3.x<_BackCriticalAngle);
#else
    u_xlatb4 = u_xlat3.x<_BackCriticalAngle;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BackCriticalAngle<u_xlat3.x);
#else
    u_xlatb3 = _BackCriticalAngle<u_xlat3.x;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb4)) ? u_xlat0.xyz : _WaterColor.xyz;
    u_xlat0.x = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xx * (-u_xlat8.xy) + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_2.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_2.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WaterColor.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _WaterColor.xyz;
    SV_Target0.xyz = (bool(u_xlatb3)) ? u_xlat0.xyz : u_xlat16_1.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _BackDensity;
uniform 	float _BackShoreTransparency;
uniform 	float _BackFogDensity;
uniform 	float _BackFogEffectLimit;
uniform 	float _BackFogEffectStart;
uniform 	float _BackFogStart;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat10;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat11.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat11.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat11.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat10.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xzy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _BackDensity;
    u_xlat1.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _BackShoreTransparency;
    u_xlat1.xyz = u_xlat0.xzy + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 + (-_BackFogStart);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = u_xlat12 * _BackFogDensity;
    u_xlat12 = u_xlat12 * _UWFogColorNFIntensity;
    u_xlat12 = u_xlat12 * (-u_xlat12);
    u_xlat12 = u_xlat12 * 1.44269502;
    u_xlat0.x = exp2(u_xlat12);
    u_xlat12 = u_xlat1.x * (-u_xlat1.x);
    u_xlat12 = u_xlat12 * 1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 * _BackFogEffectLimit;
    u_xlat12 = max(u_xlat12, _BackFogEffectStart);
    u_xlat12 = min(u_xlat12, _BackFogEffectLimit);
    u_xlat0.y = (-u_xlat12) + 1.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _WaterColor;
uniform 	vec4 _RefractColor;
uniform 	float _BackRefractFade;
uniform 	float _BackFresnelBias;
uniform 	float _BackShoreFade;
uniform 	float _BackRefractDistort;
uniform 	float _BackReflectIntensity;
uniform 	float _BackReflectDistort;
uniform 	float _BackReflectLerpFactor;
uniform 	float _BackCriticalAngle;
uniform 	float _BackAngleDistort;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_4;
bool u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_1.zw = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1 = u_xlat16_1 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1.xz = vec2((-u_xlat16_1.z) + (-u_xlat16_1.x), (-u_xlat16_1.w) + (-u_xlat16_1.y));
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_BackRefractDistort, _BackRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat12 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat0.xy / vec2(u_xlat12);
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat18 * -0.5;
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _BackShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.w = min(u_xlat18, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat3.xyz = log2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(_BackRefractFade);
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat4.xyz = u_xlat4.xyz / vec3(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _BackReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat16_7 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_7) + 1.0;
    u_xlat16_4 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_4;
    u_xlat4.x = (-_BackFresnelBias) + 1.0;
    u_xlat21 = u_xlat4.x * u_xlat16_21 + _BackFresnelBias;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat21);
    u_xlat21 = u_xlat21 * _BackReflectIntensity;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat4.y)<u_xlat4.y);
#else
    u_xlatb3 = (-u_xlat4.y)<u_xlat4.y;
#endif
    u_xlat16_7 = abs(u_xlat4.y);
    u_xlat16_9 = u_xlat16_7 * -0.0187292993 + 0.0742610022;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + -0.212114394;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + 1.57072878;
    u_xlat16_15 = (-u_xlat16_7) + 1.0;
    u_xlat16_15 = sqrt(u_xlat16_15);
    u_xlat16_4 = u_xlat16_15 * u_xlat16_9;
    u_xlat4.x = u_xlat16_4 * -2.0 + 3.14159274;
    u_xlat3.x = u_xlatb3 ? u_xlat4.x : float(0.0);
    u_xlat3.x = u_xlat16_9 * u_xlat16_15 + u_xlat3.x;
    u_xlat16_7 = u_xlat16_1.z + u_xlat16_1.x;
    u_xlat9.xy = u_xlat16_1.xz * vec2(vec2(_BackReflectDistort, _BackReflectDistort));
    u_xlat9.xy = u_xlat9.xy * vs_TEXCOORD5.ww;
    u_xlat9.xy = u_xlat9.xy * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat16_7 * _BackAngleDistort;
    u_xlat3.x = u_xlat3.x * 57.2958298 + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat3.x<_BackCriticalAngle);
#else
    u_xlatb4 = u_xlat3.x<_BackCriticalAngle;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BackCriticalAngle<u_xlat3.x);
#else
    u_xlatb3 = _BackCriticalAngle<u_xlat3.x;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb4)) ? u_xlat0.xyz : _WaterColor.xyz;
    u_xlat0.x = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xx * (-u_xlat9.xy) + u_xlat9.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_5.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_5.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WaterColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + _WaterColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb3)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat0.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vs_TEXCOORD7.xxx * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat2.xyz = vs_TEXCOORD7.yyy * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _BackDensity;
uniform 	float _BackShoreTransparency;
uniform 	float _BackFogDensity;
uniform 	float _BackFogEffectLimit;
uniform 	float _BackFogEffectStart;
uniform 	float _BackFogStart;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat10;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat11.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat11.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat11.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat10.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xzy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _BackDensity;
    u_xlat1.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _BackShoreTransparency;
    u_xlat1.xyz = u_xlat0.xzy + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 + (-_BackFogStart);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = u_xlat12 * _BackFogDensity;
    u_xlat12 = u_xlat12 * _UWFogColorNFIntensity;
    u_xlat12 = u_xlat12 * (-u_xlat12);
    u_xlat12 = u_xlat12 * 1.44269502;
    u_xlat0.x = exp2(u_xlat12);
    u_xlat12 = u_xlat1.x * (-u_xlat1.x);
    u_xlat12 = u_xlat12 * 1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 * _BackFogEffectLimit;
    u_xlat12 = max(u_xlat12, _BackFogEffectStart);
    u_xlat12 = min(u_xlat12, _BackFogEffectLimit);
    u_xlat0.y = (-u_xlat12) + 1.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _WaterColor;
uniform 	vec4 _RefractColor;
uniform 	float _BackRefractFade;
uniform 	float _BackFresnelBias;
uniform 	float _BackShoreFade;
uniform 	float _BackRefractDistort;
uniform 	float _BackReflectIntensity;
uniform 	float _BackReflectDistort;
uniform 	float _BackReflectLerpFactor;
uniform 	float _BackCriticalAngle;
uniform 	float _BackAngleDistort;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_4;
bool u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_1.zw = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1 = u_xlat16_1 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1.xz = vec2((-u_xlat16_1.z) + (-u_xlat16_1.x), (-u_xlat16_1.w) + (-u_xlat16_1.y));
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_BackRefractDistort, _BackRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat12 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat0.xy / vec2(u_xlat12);
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat18 * -0.5;
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _BackShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.w = min(u_xlat18, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat3.xyz = log2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(_BackRefractFade);
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat4.xyz = u_xlat4.xyz / vec3(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _BackReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat16_7 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_7) + 1.0;
    u_xlat16_4 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_4;
    u_xlat4.x = (-_BackFresnelBias) + 1.0;
    u_xlat21 = u_xlat4.x * u_xlat16_21 + _BackFresnelBias;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat21);
    u_xlat21 = u_xlat21 * _BackReflectIntensity;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat4.y)<u_xlat4.y);
#else
    u_xlatb3 = (-u_xlat4.y)<u_xlat4.y;
#endif
    u_xlat16_7 = abs(u_xlat4.y);
    u_xlat16_9 = u_xlat16_7 * -0.0187292993 + 0.0742610022;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + -0.212114394;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + 1.57072878;
    u_xlat16_15 = (-u_xlat16_7) + 1.0;
    u_xlat16_15 = sqrt(u_xlat16_15);
    u_xlat16_4 = u_xlat16_15 * u_xlat16_9;
    u_xlat4.x = u_xlat16_4 * -2.0 + 3.14159274;
    u_xlat3.x = u_xlatb3 ? u_xlat4.x : float(0.0);
    u_xlat3.x = u_xlat16_9 * u_xlat16_15 + u_xlat3.x;
    u_xlat16_7 = u_xlat16_1.z + u_xlat16_1.x;
    u_xlat9.xy = u_xlat16_1.xz * vec2(vec2(_BackReflectDistort, _BackReflectDistort));
    u_xlat9.xy = u_xlat9.xy * vs_TEXCOORD5.ww;
    u_xlat9.xy = u_xlat9.xy * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat16_7 * _BackAngleDistort;
    u_xlat3.x = u_xlat3.x * 57.2958298 + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat3.x<_BackCriticalAngle);
#else
    u_xlatb4 = u_xlat3.x<_BackCriticalAngle;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BackCriticalAngle<u_xlat3.x);
#else
    u_xlatb3 = _BackCriticalAngle<u_xlat3.x;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb4)) ? u_xlat0.xyz : _WaterColor.xyz;
    u_xlat0.x = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xx * (-u_xlat9.xy) + u_xlat9.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_5.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_5.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WaterColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + _WaterColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb3)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat0.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vs_TEXCOORD7.xxx * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat2.xyz = vs_TEXCOORD7.yyy * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _BackDensity;
uniform 	float _BackShoreTransparency;
uniform 	float _BackFogDensity;
uniform 	float _BackFogEffectLimit;
uniform 	float _BackFogEffectStart;
uniform 	float _BackFogStart;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat10;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat11.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat11.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat11.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat10.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xzy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _BackDensity;
    u_xlat1.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _BackShoreTransparency;
    u_xlat1.xyz = u_xlat0.xzy + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 + (-_BackFogStart);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = u_xlat12 * _BackFogDensity;
    u_xlat12 = u_xlat12 * _UWFogColorNFIntensity;
    u_xlat12 = u_xlat12 * (-u_xlat12);
    u_xlat12 = u_xlat12 * 1.44269502;
    u_xlat0.x = exp2(u_xlat12);
    u_xlat12 = u_xlat1.x * (-u_xlat1.x);
    u_xlat12 = u_xlat12 * 1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 * _BackFogEffectLimit;
    u_xlat12 = max(u_xlat12, _BackFogEffectStart);
    u_xlat12 = min(u_xlat12, _BackFogEffectLimit);
    u_xlat0.y = (-u_xlat12) + 1.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _WaterColor;
uniform 	vec4 _RefractColor;
uniform 	float _BackRefractFade;
uniform 	float _BackFresnelBias;
uniform 	float _BackShoreFade;
uniform 	float _BackRefractDistort;
uniform 	float _BackReflectIntensity;
uniform 	float _BackReflectDistort;
uniform 	float _BackReflectLerpFactor;
uniform 	float _BackCriticalAngle;
uniform 	float _BackAngleDistort;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_4;
bool u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_1.zw = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1 = u_xlat16_1 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1.xz = vec2((-u_xlat16_1.z) + (-u_xlat16_1.x), (-u_xlat16_1.w) + (-u_xlat16_1.y));
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_BackRefractDistort, _BackRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat12 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat0.xy / vec2(u_xlat12);
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat18 * -0.5;
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _BackShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.w = min(u_xlat18, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat3.xyz = log2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(_BackRefractFade);
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat4.xyz = u_xlat4.xyz / vec3(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _BackReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat16_7 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_7) + 1.0;
    u_xlat16_4 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_4;
    u_xlat4.x = (-_BackFresnelBias) + 1.0;
    u_xlat21 = u_xlat4.x * u_xlat16_21 + _BackFresnelBias;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat21);
    u_xlat21 = u_xlat21 * _BackReflectIntensity;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat4.y)<u_xlat4.y);
#else
    u_xlatb3 = (-u_xlat4.y)<u_xlat4.y;
#endif
    u_xlat16_7 = abs(u_xlat4.y);
    u_xlat16_9 = u_xlat16_7 * -0.0187292993 + 0.0742610022;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + -0.212114394;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + 1.57072878;
    u_xlat16_15 = (-u_xlat16_7) + 1.0;
    u_xlat16_15 = sqrt(u_xlat16_15);
    u_xlat16_4 = u_xlat16_15 * u_xlat16_9;
    u_xlat4.x = u_xlat16_4 * -2.0 + 3.14159274;
    u_xlat3.x = u_xlatb3 ? u_xlat4.x : float(0.0);
    u_xlat3.x = u_xlat16_9 * u_xlat16_15 + u_xlat3.x;
    u_xlat16_7 = u_xlat16_1.z + u_xlat16_1.x;
    u_xlat9.xy = u_xlat16_1.xz * vec2(vec2(_BackReflectDistort, _BackReflectDistort));
    u_xlat9.xy = u_xlat9.xy * vs_TEXCOORD5.ww;
    u_xlat9.xy = u_xlat9.xy * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat16_7 * _BackAngleDistort;
    u_xlat3.x = u_xlat3.x * 57.2958298 + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat3.x<_BackCriticalAngle);
#else
    u_xlatb4 = u_xlat3.x<_BackCriticalAngle;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BackCriticalAngle<u_xlat3.x);
#else
    u_xlatb3 = _BackCriticalAngle<u_xlat3.x;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb4)) ? u_xlat0.xyz : _WaterColor.xyz;
    u_xlat0.x = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xx * (-u_xlat9.xy) + u_xlat9.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_5.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_5.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WaterColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + _WaterColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb3)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat0.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vs_TEXCOORD7.xxx * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat2.xyz = vs_TEXCOORD7.yyy * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	float _BackDensity;
uniform 	float _BackShoreTransparency;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat7;
vec2 u_xlat8;
float u_xlat10;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat7.xy;
    u_xlat1.zw = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat1 = u_xlat1 * in_TEXCOORD0.xyxy;
    u_xlat2.xy = vec2(u_xlat1.z + u_xlat1.z, u_xlat1.w + u_xlat1.w);
    u_xlat8.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat8.xy * vec2(0.150000006, 0.150000006) + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat8.xy * vec2(0.100000001, 0.100000001) + u_xlat1.zw;
    u_xlat7.xy = u_xlat1.xy + u_xlat1.xy;
    u_xlat2.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat2.xy * vec2(0.150000006, 0.150000006) + u_xlat7.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = 10.0 / _BackDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _BackShoreTransparency;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _WaterColor;
uniform 	vec4 _RefractColor;
uniform 	float _BackRefractFade;
uniform 	float _BackFresnelBias;
uniform 	float _BackShoreFade;
uniform 	float _BackRefractDistort;
uniform 	float _BackReflectIntensity;
uniform 	float _BackReflectDistort;
uniform 	float _BackReflectLerpFactor;
uniform 	float _BackCriticalAngle;
uniform 	float _BackAngleDistort;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_4;
bool u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_1.zw = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1 = u_xlat16_1 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1.xz = vec2((-u_xlat16_1.z) + (-u_xlat16_1.x), (-u_xlat16_1.w) + (-u_xlat16_1.y));
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_BackRefractDistort, _BackRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat12 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat0.xy / vec2(u_xlat12);
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat18 * -0.5;
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _BackShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.w = min(u_xlat18, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat3.xyz = log2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(_BackRefractFade);
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat4.xyz = u_xlat4.xyz / vec3(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _BackReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat16_7 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_7) + 1.0;
    u_xlat16_4 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_4;
    u_xlat4.x = (-_BackFresnelBias) + 1.0;
    u_xlat21 = u_xlat4.x * u_xlat16_21 + _BackFresnelBias;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat21);
    u_xlat21 = u_xlat21 * _BackReflectIntensity;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat4.y)<u_xlat4.y);
#else
    u_xlatb3 = (-u_xlat4.y)<u_xlat4.y;
#endif
    u_xlat16_7 = abs(u_xlat4.y);
    u_xlat16_9 = u_xlat16_7 * -0.0187292993 + 0.0742610022;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + -0.212114394;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + 1.57072878;
    u_xlat16_15 = (-u_xlat16_7) + 1.0;
    u_xlat16_15 = sqrt(u_xlat16_15);
    u_xlat16_4 = u_xlat16_15 * u_xlat16_9;
    u_xlat4.x = u_xlat16_4 * -2.0 + 3.14159274;
    u_xlat3.x = u_xlatb3 ? u_xlat4.x : float(0.0);
    u_xlat3.x = u_xlat16_9 * u_xlat16_15 + u_xlat3.x;
    u_xlat16_7 = u_xlat16_1.z + u_xlat16_1.x;
    u_xlat9.xy = u_xlat16_1.xz * vec2(vec2(_BackReflectDistort, _BackReflectDistort));
    u_xlat9.xy = u_xlat9.xy * vs_TEXCOORD5.ww;
    u_xlat9.xy = u_xlat9.xy * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat16_7 * _BackAngleDistort;
    u_xlat3.x = u_xlat3.x * 57.2958298 + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat3.x<_BackCriticalAngle);
#else
    u_xlatb4 = u_xlat3.x<_BackCriticalAngle;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BackCriticalAngle<u_xlat3.x);
#else
    u_xlatb3 = _BackCriticalAngle<u_xlat3.x;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb4)) ? u_xlat0.xyz : _WaterColor.xyz;
    u_xlat0.x = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xx * (-u_xlat9.xy) + u_xlat9.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_5.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_5.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WaterColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + _WaterColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb3)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	float _BackDensity;
uniform 	float _BackShoreTransparency;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat7;
vec2 u_xlat8;
float u_xlat10;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat7.xy;
    u_xlat1.zw = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat1 = u_xlat1 * in_TEXCOORD0.xyxy;
    u_xlat2.xy = vec2(u_xlat1.z + u_xlat1.z, u_xlat1.w + u_xlat1.w);
    u_xlat8.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat8.xy * vec2(0.150000006, 0.150000006) + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat8.xy * vec2(0.100000001, 0.100000001) + u_xlat1.zw;
    u_xlat7.xy = u_xlat1.xy + u_xlat1.xy;
    u_xlat2.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat2.xy * vec2(0.150000006, 0.150000006) + u_xlat7.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = 10.0 / _BackDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _BackShoreTransparency;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _WaterColor;
uniform 	vec4 _RefractColor;
uniform 	float _BackRefractFade;
uniform 	float _BackFresnelBias;
uniform 	float _BackShoreFade;
uniform 	float _BackRefractDistort;
uniform 	float _BackReflectIntensity;
uniform 	float _BackReflectDistort;
uniform 	float _BackReflectLerpFactor;
uniform 	float _BackCriticalAngle;
uniform 	float _BackAngleDistort;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_4;
bool u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_1.zw = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1 = u_xlat16_1 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1.xz = vec2((-u_xlat16_1.z) + (-u_xlat16_1.x), (-u_xlat16_1.w) + (-u_xlat16_1.y));
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_BackRefractDistort, _BackRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat12 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat0.xy / vec2(u_xlat12);
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat18 * -0.5;
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _BackShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.w = min(u_xlat18, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat3.xyz = log2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(_BackRefractFade);
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat4.xyz = u_xlat4.xyz / vec3(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _BackReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat16_7 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_7) + 1.0;
    u_xlat16_4 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_4;
    u_xlat4.x = (-_BackFresnelBias) + 1.0;
    u_xlat21 = u_xlat4.x * u_xlat16_21 + _BackFresnelBias;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat21);
    u_xlat21 = u_xlat21 * _BackReflectIntensity;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat4.y)<u_xlat4.y);
#else
    u_xlatb3 = (-u_xlat4.y)<u_xlat4.y;
#endif
    u_xlat16_7 = abs(u_xlat4.y);
    u_xlat16_9 = u_xlat16_7 * -0.0187292993 + 0.0742610022;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + -0.212114394;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + 1.57072878;
    u_xlat16_15 = (-u_xlat16_7) + 1.0;
    u_xlat16_15 = sqrt(u_xlat16_15);
    u_xlat16_4 = u_xlat16_15 * u_xlat16_9;
    u_xlat4.x = u_xlat16_4 * -2.0 + 3.14159274;
    u_xlat3.x = u_xlatb3 ? u_xlat4.x : float(0.0);
    u_xlat3.x = u_xlat16_9 * u_xlat16_15 + u_xlat3.x;
    u_xlat16_7 = u_xlat16_1.z + u_xlat16_1.x;
    u_xlat9.xy = u_xlat16_1.xz * vec2(vec2(_BackReflectDistort, _BackReflectDistort));
    u_xlat9.xy = u_xlat9.xy * vs_TEXCOORD5.ww;
    u_xlat9.xy = u_xlat9.xy * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat16_7 * _BackAngleDistort;
    u_xlat3.x = u_xlat3.x * 57.2958298 + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat3.x<_BackCriticalAngle);
#else
    u_xlatb4 = u_xlat3.x<_BackCriticalAngle;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BackCriticalAngle<u_xlat3.x);
#else
    u_xlatb3 = _BackCriticalAngle<u_xlat3.x;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb4)) ? u_xlat0.xyz : _WaterColor.xyz;
    u_xlat0.x = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xx * (-u_xlat9.xy) + u_xlat9.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_5.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_5.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WaterColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + _WaterColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb3)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	float _BackDensity;
uniform 	float _BackShoreTransparency;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat7;
vec2 u_xlat8;
float u_xlat10;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat7.xy;
    u_xlat1.zw = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat1.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat1 = u_xlat1 * in_TEXCOORD0.xyxy;
    u_xlat2.xy = vec2(u_xlat1.z + u_xlat1.z, u_xlat1.w + u_xlat1.w);
    u_xlat8.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat8.xy * vec2(0.150000006, 0.150000006) + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat8.xy * vec2(0.100000001, 0.100000001) + u_xlat1.zw;
    u_xlat7.xy = u_xlat1.xy + u_xlat1.xy;
    u_xlat2.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat2.xy * vec2(0.150000006, 0.150000006) + u_xlat7.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = 10.0 / _BackDensity;
    u_xlat0.xyz = u_xlat0.xxx * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD6.w = float(1.0) / _BackShoreTransparency;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _WaterColor;
uniform 	vec4 _RefractColor;
uniform 	float _BackRefractFade;
uniform 	float _BackFresnelBias;
uniform 	float _BackShoreFade;
uniform 	float _BackRefractDistort;
uniform 	float _BackReflectIntensity;
uniform 	float _BackReflectDistort;
uniform 	float _BackReflectLerpFactor;
uniform 	float _BackCriticalAngle;
uniform 	float _BackAngleDistort;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_4;
bool u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_1.zw = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1 = u_xlat16_1 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1.xz = vec2((-u_xlat16_1.z) + (-u_xlat16_1.x), (-u_xlat16_1.w) + (-u_xlat16_1.y));
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_BackRefractDistort, _BackRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat12 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat0.xy / vec2(u_xlat12);
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat18 * -0.5;
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _BackShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.w = min(u_xlat18, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat3.xyz = log2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(_BackRefractFade);
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat4.xyz = u_xlat4.xyz / vec3(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _BackReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat16_7 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_7) + 1.0;
    u_xlat16_4 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_4;
    u_xlat4.x = (-_BackFresnelBias) + 1.0;
    u_xlat21 = u_xlat4.x * u_xlat16_21 + _BackFresnelBias;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat21);
    u_xlat21 = u_xlat21 * _BackReflectIntensity;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat4.y)<u_xlat4.y);
#else
    u_xlatb3 = (-u_xlat4.y)<u_xlat4.y;
#endif
    u_xlat16_7 = abs(u_xlat4.y);
    u_xlat16_9 = u_xlat16_7 * -0.0187292993 + 0.0742610022;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + -0.212114394;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + 1.57072878;
    u_xlat16_15 = (-u_xlat16_7) + 1.0;
    u_xlat16_15 = sqrt(u_xlat16_15);
    u_xlat16_4 = u_xlat16_15 * u_xlat16_9;
    u_xlat4.x = u_xlat16_4 * -2.0 + 3.14159274;
    u_xlat3.x = u_xlatb3 ? u_xlat4.x : float(0.0);
    u_xlat3.x = u_xlat16_9 * u_xlat16_15 + u_xlat3.x;
    u_xlat16_7 = u_xlat16_1.z + u_xlat16_1.x;
    u_xlat9.xy = u_xlat16_1.xz * vec2(vec2(_BackReflectDistort, _BackReflectDistort));
    u_xlat9.xy = u_xlat9.xy * vs_TEXCOORD5.ww;
    u_xlat9.xy = u_xlat9.xy * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat16_7 * _BackAngleDistort;
    u_xlat3.x = u_xlat3.x * 57.2958298 + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat3.x<_BackCriticalAngle);
#else
    u_xlatb4 = u_xlat3.x<_BackCriticalAngle;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BackCriticalAngle<u_xlat3.x);
#else
    u_xlatb3 = _BackCriticalAngle<u_xlat3.x;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb4)) ? u_xlat0.xyz : _WaterColor.xyz;
    u_xlat0.x = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xx * (-u_xlat9.xy) + u_xlat9.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_5.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_5.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WaterColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + _WaterColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb3)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _BackDensity;
uniform 	float _BackShoreTransparency;
uniform 	float _BackFogDensity;
uniform 	float _BackFogEffectLimit;
uniform 	float _BackFogEffectStart;
uniform 	float _BackFogStart;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat10;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat11.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat11.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat11.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat10.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xzy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _BackDensity;
    u_xlat1.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _BackShoreTransparency;
    u_xlat1.xyz = u_xlat0.xzy + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 + (-_BackFogStart);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = u_xlat12 * _BackFogDensity;
    u_xlat12 = u_xlat12 * _UWFogColorNFIntensity;
    u_xlat12 = u_xlat12 * (-u_xlat12);
    u_xlat12 = u_xlat12 * 1.44269502;
    u_xlat0.x = exp2(u_xlat12);
    u_xlat12 = u_xlat1.x * (-u_xlat1.x);
    u_xlat12 = u_xlat12 * 1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 * _BackFogEffectLimit;
    u_xlat12 = max(u_xlat12, _BackFogEffectStart);
    u_xlat12 = min(u_xlat12, _BackFogEffectLimit);
    u_xlat0.y = (-u_xlat12) + 1.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _WaterColor;
uniform 	vec4 _RefractColor;
uniform 	float _BackRefractFade;
uniform 	float _BackFresnelBias;
uniform 	float _BackShoreFade;
uniform 	float _BackRefractDistort;
uniform 	float _BackReflectIntensity;
uniform 	float _BackReflectDistort;
uniform 	float _BackReflectLerpFactor;
uniform 	float _BackCriticalAngle;
uniform 	float _BackAngleDistort;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_4;
bool u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_1.zw = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1 = u_xlat16_1 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1.xz = vec2((-u_xlat16_1.z) + (-u_xlat16_1.x), (-u_xlat16_1.w) + (-u_xlat16_1.y));
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_BackRefractDistort, _BackRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat12 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat0.xy / vec2(u_xlat12);
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat18 * -0.5;
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _BackShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.w = min(u_xlat18, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat3.xyz = log2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(_BackRefractFade);
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat4.xyz = u_xlat4.xyz / vec3(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _BackReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat16_7 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_7) + 1.0;
    u_xlat16_4 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_4;
    u_xlat4.x = (-_BackFresnelBias) + 1.0;
    u_xlat21 = u_xlat4.x * u_xlat16_21 + _BackFresnelBias;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat21);
    u_xlat21 = u_xlat21 * _BackReflectIntensity;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat4.y)<u_xlat4.y);
#else
    u_xlatb3 = (-u_xlat4.y)<u_xlat4.y;
#endif
    u_xlat16_7 = abs(u_xlat4.y);
    u_xlat16_9 = u_xlat16_7 * -0.0187292993 + 0.0742610022;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + -0.212114394;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + 1.57072878;
    u_xlat16_15 = (-u_xlat16_7) + 1.0;
    u_xlat16_15 = sqrt(u_xlat16_15);
    u_xlat16_4 = u_xlat16_15 * u_xlat16_9;
    u_xlat4.x = u_xlat16_4 * -2.0 + 3.14159274;
    u_xlat3.x = u_xlatb3 ? u_xlat4.x : float(0.0);
    u_xlat3.x = u_xlat16_9 * u_xlat16_15 + u_xlat3.x;
    u_xlat16_7 = u_xlat16_1.z + u_xlat16_1.x;
    u_xlat9.xy = u_xlat16_1.xz * vec2(vec2(_BackReflectDistort, _BackReflectDistort));
    u_xlat9.xy = u_xlat9.xy * vs_TEXCOORD5.ww;
    u_xlat9.xy = u_xlat9.xy * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat16_7 * _BackAngleDistort;
    u_xlat3.x = u_xlat3.x * 57.2958298 + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat3.x<_BackCriticalAngle);
#else
    u_xlatb4 = u_xlat3.x<_BackCriticalAngle;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BackCriticalAngle<u_xlat3.x);
#else
    u_xlatb3 = _BackCriticalAngle<u_xlat3.x;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb4)) ? u_xlat0.xyz : _WaterColor.xyz;
    u_xlat0.x = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xx * (-u_xlat9.xy) + u_xlat9.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_5.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_5.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WaterColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + _WaterColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb3)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat0.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vs_TEXCOORD7.xxx * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat0.xyz = vs_TEXCOORD7.yyy * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat18);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _BackDensity;
uniform 	float _BackShoreTransparency;
uniform 	float _BackFogDensity;
uniform 	float _BackFogEffectLimit;
uniform 	float _BackFogEffectStart;
uniform 	float _BackFogStart;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat10;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat11.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat11.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat11.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat10.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xzy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _BackDensity;
    u_xlat1.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _BackShoreTransparency;
    u_xlat1.xyz = u_xlat0.xzy + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 + (-_BackFogStart);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = u_xlat12 * _BackFogDensity;
    u_xlat12 = u_xlat12 * _UWFogColorNFIntensity;
    u_xlat12 = u_xlat12 * (-u_xlat12);
    u_xlat12 = u_xlat12 * 1.44269502;
    u_xlat0.x = exp2(u_xlat12);
    u_xlat12 = u_xlat1.x * (-u_xlat1.x);
    u_xlat12 = u_xlat12 * 1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 * _BackFogEffectLimit;
    u_xlat12 = max(u_xlat12, _BackFogEffectStart);
    u_xlat12 = min(u_xlat12, _BackFogEffectLimit);
    u_xlat0.y = (-u_xlat12) + 1.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _WaterColor;
uniform 	vec4 _RefractColor;
uniform 	float _BackRefractFade;
uniform 	float _BackFresnelBias;
uniform 	float _BackShoreFade;
uniform 	float _BackRefractDistort;
uniform 	float _BackReflectIntensity;
uniform 	float _BackReflectDistort;
uniform 	float _BackReflectLerpFactor;
uniform 	float _BackCriticalAngle;
uniform 	float _BackAngleDistort;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_4;
bool u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_1.zw = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1 = u_xlat16_1 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1.xz = vec2((-u_xlat16_1.z) + (-u_xlat16_1.x), (-u_xlat16_1.w) + (-u_xlat16_1.y));
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_BackRefractDistort, _BackRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat12 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat0.xy / vec2(u_xlat12);
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat18 * -0.5;
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _BackShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.w = min(u_xlat18, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat3.xyz = log2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(_BackRefractFade);
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat4.xyz = u_xlat4.xyz / vec3(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _BackReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat16_7 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_7) + 1.0;
    u_xlat16_4 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_4;
    u_xlat4.x = (-_BackFresnelBias) + 1.0;
    u_xlat21 = u_xlat4.x * u_xlat16_21 + _BackFresnelBias;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat21);
    u_xlat21 = u_xlat21 * _BackReflectIntensity;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat4.y)<u_xlat4.y);
#else
    u_xlatb3 = (-u_xlat4.y)<u_xlat4.y;
#endif
    u_xlat16_7 = abs(u_xlat4.y);
    u_xlat16_9 = u_xlat16_7 * -0.0187292993 + 0.0742610022;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + -0.212114394;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + 1.57072878;
    u_xlat16_15 = (-u_xlat16_7) + 1.0;
    u_xlat16_15 = sqrt(u_xlat16_15);
    u_xlat16_4 = u_xlat16_15 * u_xlat16_9;
    u_xlat4.x = u_xlat16_4 * -2.0 + 3.14159274;
    u_xlat3.x = u_xlatb3 ? u_xlat4.x : float(0.0);
    u_xlat3.x = u_xlat16_9 * u_xlat16_15 + u_xlat3.x;
    u_xlat16_7 = u_xlat16_1.z + u_xlat16_1.x;
    u_xlat9.xy = u_xlat16_1.xz * vec2(vec2(_BackReflectDistort, _BackReflectDistort));
    u_xlat9.xy = u_xlat9.xy * vs_TEXCOORD5.ww;
    u_xlat9.xy = u_xlat9.xy * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat16_7 * _BackAngleDistort;
    u_xlat3.x = u_xlat3.x * 57.2958298 + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat3.x<_BackCriticalAngle);
#else
    u_xlatb4 = u_xlat3.x<_BackCriticalAngle;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BackCriticalAngle<u_xlat3.x);
#else
    u_xlatb3 = _BackCriticalAngle<u_xlat3.x;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb4)) ? u_xlat0.xyz : _WaterColor.xyz;
    u_xlat0.x = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xx * (-u_xlat9.xy) + u_xlat9.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_5.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_5.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WaterColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + _WaterColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb3)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat0.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vs_TEXCOORD7.xxx * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat0.xyz = vs_TEXCOORD7.yyy * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat18);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _RefractColor;
uniform 	float _BackDensity;
uniform 	float _BackShoreTransparency;
uniform 	float _BackFogDensity;
uniform 	float _BackFogEffectLimit;
uniform 	float _BackFogEffectStart;
uniform 	float _BackFogStart;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat10;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = sqrt(u_xlat12);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.y = sqrt(u_xlat12);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat10.xy;
    u_xlat2.zw = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat2.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat2 = u_xlat2 * in_TEXCOORD0.xyxy;
    u_xlat3.xy = vec2(u_xlat2.z + u_xlat2.z, u_xlat2.w + u_xlat2.w);
    u_xlat11.xy = vec2(_Time.y * _SmallWavesParams.z, _Time.y * _SmallWavesParams.w);
    vs_TEXCOORD1.zw = u_xlat11.xy * vec2(0.150000006, 0.150000006) + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat11.xy * vec2(0.100000001, 0.100000001) + u_xlat2.zw;
    u_xlat10.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlat3.xy = vec2(_Time.y * _LargeWavesParams.z, _Time.y * _LargeWavesParams.w);
    vs_TEXCOORD2.zw = u_xlat3.xy * vec2(0.150000006, 0.150000006) + u_xlat10.xy;
    vs_TEXCOORD2.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat2.xy;
    vs_TEXCOORD3.xyz = u_xlat0.xzy;
    vs_TEXCOORD3.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = 10.0 / _BackDensity;
    u_xlat1.xyz = vec3(u_xlat12) * _RefractColor.xyz;
    vs_TEXCOORD6.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    vs_TEXCOORD6.w = float(1.0) / _BackShoreTransparency;
    u_xlat1.xyz = u_xlat0.xzy + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 + (-_BackFogStart);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = u_xlat12 * _BackFogDensity;
    u_xlat12 = u_xlat12 * _UWFogColorNFIntensity;
    u_xlat12 = u_xlat12 * (-u_xlat12);
    u_xlat12 = u_xlat12 * 1.44269502;
    u_xlat0.x = exp2(u_xlat12);
    u_xlat12 = u_xlat1.x * (-u_xlat1.x);
    u_xlat12 = u_xlat12 * 1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 * _BackFogEffectLimit;
    u_xlat12 = max(u_xlat12, _BackFogEffectStart);
    u_xlat12 = min(u_xlat12, _BackFogEffectLimit);
    u_xlat0.y = (-u_xlat12) + 1.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _WaterColor;
uniform 	vec4 _RefractColor;
uniform 	float _BackRefractFade;
uniform 	float _BackFresnelBias;
uniform 	float _BackShoreFade;
uniform 	float _BackRefractDistort;
uniform 	float _BackReflectIntensity;
uniform 	float _BackReflectDistort;
uniform 	float _BackReflectLerpFactor;
uniform 	float _BackCriticalAngle;
uniform 	float _BackAngleDistort;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_4;
bool u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_1.xy;
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_0.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_1.zw = u_xlat10_0.xy * vec2(2.0, 2.0) + u_xlat16_13.xy;
    u_xlat16_1 = u_xlat16_1 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1.xz = vec2((-u_xlat16_1.z) + (-u_xlat16_1.x), (-u_xlat16_1.w) + (-u_xlat16_1.y));
    u_xlat16_1.y = 1.0;
    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
    u_xlat0.xy = u_xlat16_1.xz * vec2(vec2(_BackRefractDistort, _BackRefractDistort)) + vs_TEXCOORD5.xy;
    u_xlat12 = vs_TEXCOORD5.w;
    u_xlat16_2.xy = u_xlat0.xy / vec2(u_xlat12);
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = _RefractColor.xyz + _RefractColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat18 * -0.5;
    u_xlat18 = u_xlat18 * vs_TEXCOORD6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + 9.99999975e-05;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _BackShoreFade;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.w = min(u_xlat18, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
#else
    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat3.xyz = log2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(_BackRefractFade);
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_19 = sqrt(u_xlat16_19);
    u_xlat4.xyz = u_xlat4.xyz / vec3(u_xlat16_19);
    u_xlat18 = u_xlat16_19 * _BackReflectLerpFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat16_7 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_7) + 1.0;
    u_xlat16_4 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_4;
    u_xlat4.x = (-_BackFresnelBias) + 1.0;
    u_xlat21 = u_xlat4.x * u_xlat16_21 + _BackFresnelBias;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat21);
    u_xlat21 = u_xlat21 * _BackReflectIntensity;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz + _WaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat4.y)<u_xlat4.y);
#else
    u_xlatb3 = (-u_xlat4.y)<u_xlat4.y;
#endif
    u_xlat16_7 = abs(u_xlat4.y);
    u_xlat16_9 = u_xlat16_7 * -0.0187292993 + 0.0742610022;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + -0.212114394;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7 + 1.57072878;
    u_xlat16_15 = (-u_xlat16_7) + 1.0;
    u_xlat16_15 = sqrt(u_xlat16_15);
    u_xlat16_4 = u_xlat16_15 * u_xlat16_9;
    u_xlat4.x = u_xlat16_4 * -2.0 + 3.14159274;
    u_xlat3.x = u_xlatb3 ? u_xlat4.x : float(0.0);
    u_xlat3.x = u_xlat16_9 * u_xlat16_15 + u_xlat3.x;
    u_xlat16_7 = u_xlat16_1.z + u_xlat16_1.x;
    u_xlat9.xy = u_xlat16_1.xz * vec2(vec2(_BackReflectDistort, _BackReflectDistort));
    u_xlat9.xy = u_xlat9.xy * vs_TEXCOORD5.ww;
    u_xlat9.xy = u_xlat9.xy * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat16_7 * _BackAngleDistort;
    u_xlat3.x = u_xlat3.x * 57.2958298 + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat3.x<_BackCriticalAngle);
#else
    u_xlatb4 = u_xlat3.x<_BackCriticalAngle;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BackCriticalAngle<u_xlat3.x);
#else
    u_xlatb3 = _BackCriticalAngle<u_xlat3.x;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb4)) ? u_xlat0.xyz : _WaterColor.xyz;
    u_xlat0.x = vs_TEXCOORD5.w * _ProjectionParams.w;
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xx * (-u_xlat9.xy) + u_xlat9.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD5.xy;
    u_xlat16_5.xy = u_xlat0.xy / vs_TEXCOORD5.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_5.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WaterColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + _WaterColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb3)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat0.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat0.xyz = vs_TEXCOORD7.xxx * u_xlat0.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat0.xyz = vs_TEXCOORD7.yyy * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat18);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
}
}
}
Fallback "Diffuse"
}