//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/Scene_DLC_PondWater" {
Properties {
[Header(Shading)] _WaterColor ("Water Color", Color) = (0.4,0.2,0.1,1)
[Header(Normal)] _NormalTexture1 ("Normal 1", 2D) = "white" { }
_NormalTexture2 ("Normal 2", 2D) = "bump" { }
_NormalSpeedU_1 ("Normal SpeedU 1", Float) = 0
_NormalSpeedV_1 ("Normal SpeedV 1", Float) = 0
_NormalSpeedU_2 ("Normal SpeedU 2", Float) = 0
_NormalSpeedV_2 ("Normal SpeedV 2", Float) = 0
_NormalIntensity ("Normal Intensity", Float) = 1
_NormalCoverageMin ("NormalCoverageMin", Range(0, 50000)) = 2
_NormalCoverageMax ("NormalCoverageMax", Range(0, 50000)) = 10
[Header(Reflection)] _Fresnel0 ("F0", Range(0, 1)) = 0.04
_Gloss ("Gloss", Range(0, 10)) = 1
_SpecularPower ("SpecularPower", Range(0, 1)) = 1
_SpecularIntensity ("SpecularIntensity", Float) = 1
_WaterReflectionTexture ("WaterReflectionTexture", Cube) = "white" { }
[Header(Refraction)] _Opacity ("Opacity", Range(0, 1)) = 0.01
_DepthDiffScale ("DepthDiff Scale", Range(0, 2)) = 1
_DistortionFactor ("Distortion Factor", Range(0, 1)) = 1
_HeightDiff ("HeightDiff", Range(-20, 20)) = 1.3
_Tests ("Tests", Range(-5, 5)) = 1.3
[Header(Caustics)] _CausticTex ("CausticTex", 2D) = "white" { }
_CausticColor ("CausticColor", Color) = (1,1,1,0)
_CausticIntensity ("CausticIntensity", Float) = 1
_CausticTiling ("CausticTiling", Range(0, 1)) = 1
_CausticDistortionSpeed ("CausticDistortionSpeed", Range(0.1, 1)) = 1
_CausticDistortionTiling ("CausticDistortionTiling", Range(0, 1)) = 0.03588236
_CausticDistortionValue ("CausticDistortionValue", Range(0, 1)) = 0.1
_CausticFade ("CausticFade", Range(0.01, 10)) = 1
_CausticFadePower ("CausticFadePower", Range(0.1, 10)) = 0.1
[Header(Edge Effect)] _EdgeFoamColor ("EdgeFoam Color", Color) = (1,1,1,0)
_EdgeFoamWidth ("EdgeFoam Width", Range(0, 5)) = 0.8
_EdgeTransparentWidth ("EdgeFoam Transparent Width", Range(0, 5)) = 0.8
[Header(FogCT)] [Toggle(LERP_SKY)] _Lerp ("Lerp SKy", Float) = 0
_FogCT ("FogColor", Color) = (1,1,1,1)
_FogIntensity ("FogIntensity", Range(0, 10)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 42235
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_REFLECTION" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_REFLECTION" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_REFLECTION" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat5 = u_xlat4 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat5.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat5.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat6;
    u_xlat7.xz = u_xlat6.xw * vec2(0.5, 0.5);
    u_xlat24 = u_xlat6.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat24 * 0.5;
    vs_TEXCOORD2.xy = u_xlat7.zz + u_xlat7.xw;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat5.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat7.zxy;
    u_xlat1.xyz = u_xlat7.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    vs_TEXCOORD7.xyz = vec3(u_xlat24) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat1.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat1.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat2.w = min(u_xlat24, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat1.x) + 1.0;
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.zw = u_xlat6.zw;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    u_xlat0.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    u_xlat0.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    u_xlat0.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    u_xlat0.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    u_xlat0.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    u_xlat0.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    u_xlat0.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    u_xlat0.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    u_xlat0.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    u_xlat0.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    u_xlat0.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _FogIntensity;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _SpecularPower;
uniform 	float _SpecularIntensity;
uniform 	vec3 _WaterColor;
uniform 	float _Fresnel0;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	vec3 _EdgeFoamColor;
uniform 	float _EdgeFoamWidth;
uniform 	float _EdgeTransparentWidth;
uniform 	vec3 _FogCT;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp samplerCube _WaterReflectionTexture;
uniform lowp sampler2D _CausticTex;
in highp vec3 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec2 u_xlat29;
lowp vec2 u_xlat10_29;
float u_xlat33;
mediump float u_xlat16_33;
float u_xlat34;
float u_xlat38;
float u_xlat39;
lowp float u_xlat10_39;
bool u_xlatb39;
void main()
{
    u_xlat0.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat2.x = _Time.y * _NormalSpeedU_2 + u_xlat1.x;
    u_xlat2.y = _Time.y * _NormalSpeedV_2 + u_xlat1.y;
    u_xlat10_1.xyz = texture(_NormalTexture2, u_xlat2.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTexture1, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_3.xyz = u_xlat10_1.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wzw;
    u_xlat16_4.xz = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_3.xz = u_xlat16_3.xz * vec2(_NormalIntensity);
    u_xlat16_4.y = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_33) + vec3(-0.0, -1.0, -0.0);
    u_xlat5.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat33 = (-u_xlat33) + _NormalCoverageMax;
    u_xlat34 = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat33 = u_xlat33 / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat16_1.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat0.x, 0.300000012);
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = u_xlat0.x * _LightColor0.x;
    u_xlat11.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + _ES_SunDirection.xyz;
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = abs(u_xlat34) + 1.0;
    u_xlat7.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat38);
    u_xlat8.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat8.xyz = vec3(_Opacity) / u_xlat8.xyz;
    u_xlat9.xyz = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat8.xyz = u_xlat8.xyz * _WaterColor.xyz;
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat9.xyz;
    u_xlat9.xyz = max(u_xlat9.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat38 = _HeightDiff / abs(u_xlat34);
    u_xlat38 = u_xlat38 * _DepthDiffScale;
    u_xlat9.xyz = vec3(u_xlat38) * (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat9.xyz = exp2(u_xlat9.xyz);
    u_xlat10.xyz = (-u_xlat9.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(-0.99000001<abs(u_xlat34));
#else
    u_xlatb39 = -0.99000001<abs(u_xlat34);
#endif
    u_xlat34 = -abs(u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _SpecularPower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat8.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat7.xyz = (bool(u_xlatb39)) ? u_xlat7.xyz : u_xlat8.xyz;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat7.xyz;
    u_xlat7.xy = u_xlat1.xz * vec2(vec2(_DistortionFactor, _DistortionFactor));
    u_xlat7.xy = vec2(u_xlat38) * u_xlat7.xy + vs_TEXCOORD2.xy;
    u_xlat7.xy = u_xlat7.xy / vs_TEXCOORD2.ww;
    u_xlat10_7.xyz = texture(_BeforeAlphaTexture, u_xlat7.xy).xyz;
    u_xlat11.xyz = u_xlat10_7.xyz * u_xlat9.xyz + u_xlat11.xyz;
    u_xlat39 = _CausticDistortionTiling * 200.0;
    u_xlat7.xy = vec2(u_xlat39) * vs_TEXCOORD1.xy;
    u_xlat29.x = _Time.y * _CausticDistortionSpeed;
    u_xlat7.xy = u_xlat7.xy * vec2(1.5, 1.5) + (-u_xlat29.xx);
    u_xlat29.xy = vs_TEXCOORD1.xy * vec2(u_xlat39) + u_xlat29.xx;
    u_xlat10_29.xy = texture(_CausticTex, u_xlat29.xy).yz;
    u_xlat10_7.xy = texture(_CausticTex, u_xlat7.xy).yz;
    u_xlat16_7.xy = (-u_xlat10_29.xy) + u_xlat10_7.xy;
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.600000024, 0.600000024) + u_xlat10_29.xy;
    u_xlat7.xy = u_xlat16_7.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat29.xy = u_xlat6.xz * vec2(u_xlat38) + vs_TEXCOORD3.xz;
    u_xlat7.xy = vec2(_CausticTiling) * u_xlat29.xy + u_xlat7.xy;
    u_xlat10_39 = texture(_CausticTex, u_xlat7.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_39;
    u_xlat39 = _CausticIntensity * _CausticColor.x;
    u_xlat0.x = u_xlat0.x * u_xlat39;
    u_xlat39 = float(1.0) / _CausticFade;
    u_xlat38 = u_xlat38 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat38 = log2(u_xlat38);
    u_xlat38 = u_xlat38 * _CausticFadePower;
    u_xlat38 = exp2(u_xlat38);
    u_xlat0.xyz = u_xlat0.xxx * vec3(u_xlat38) + u_xlat11.xyz;
    u_xlat33 = -abs(u_xlat6.y) + 1.0;
    u_xlat38 = u_xlat33 * u_xlat33;
    u_xlat38 = u_xlat38 * u_xlat38;
    u_xlat39 = u_xlat33 * u_xlat38;
    u_xlat33 = (-u_xlat38) * u_xlat33 + 1.0;
    u_xlat33 = _Fresnel0 * u_xlat33 + u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat38);
    u_xlat38 = dot((-u_xlat6.xyz), u_xlat1.xyz);
    u_xlat38 = u_xlat38 + u_xlat38;
    u_xlat6.xyz = u_xlat1.xyz * (-vec3(u_xlat38)) + (-u_xlat6.xyz);
    u_xlat10_6.xyz = texture(_WaterReflectionTexture, u_xlat6.xyz).xyz;
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat1.x = max(abs(u_xlat1.x), 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + u_xlat10_6.xyz;
    u_xlat34 = vs_COLOR0.x * _EdgeFoamWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat1.xyz = _EdgeFoamColor.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat33) + u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat10_1.xyz);
    u_xlat33 = vs_COLOR0.x * _EdgeTransparentWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    u_xlat0.xyz = vec3(vs_COLOR1.x * _FogCT.xxyz.y, vs_COLOR1.y * _FogCT.xxyz.z, vs_COLOR1.z * float(_FogCT.z));
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_FogIntensity, _FogIntensity, _FogIntensity)) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
in highp vec4 in_POSITION0;
in highp vec3 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD1.z = (-u_xlat15);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _NormalTexture1_ST;
uniform 	vec4 _NormalTexture2_ST;
uniform 	float _NormalIntensity;
uniform 	float _NormalSpeedU_1;
uniform 	float _NormalSpeedV_1;
uniform 	float _NormalSpeedU_2;
uniform 	float _NormalSpeedV_2;
uniform 	float _NormalCoverageMax;
uniform 	float _NormalCoverageMin;
uniform 	vec3 _ES_SunDirection;
uniform 	vec3 _WaterColor;
uniform 	float _Opacity;
uniform 	float _DepthDiffScale;
uniform 	float _DistortionFactor;
uniform 	float _HeightDiff;
uniform lowp sampler2D _NormalTexture1;
uniform lowp sampler2D _NormalTexture2;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _NormalTexture2_ST.xy + _NormalTexture2_ST.zw;
    u_xlat1.x = _Time.y * _NormalSpeedU_2 + u_xlat0.x;
    u_xlat1.y = _Time.y * _NormalSpeedV_2 + u_xlat0.y;
    u_xlat10_0.xyz = texture(_NormalTexture2, u_xlat1.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NormalTexture1_ST.xy + _NormalTexture1_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_NormalSpeedU_1, _NormalSpeedV_1) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTexture1, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.w = -1.0;
    u_xlat16_2.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.wzw;
    u_xlat16_3.xz = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(_NormalIntensity);
    u_xlat16_3.y = -1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + vec3(-0.0, -1.0, -0.0);
    u_xlat4.xyz = vs_TEXCOORD3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat27 = (-u_xlat27) + _NormalCoverageMax;
    u_xlat4.x = (-_NormalCoverageMin) + _NormalCoverageMax;
    u_xlat27 = u_xlat27 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + vec3(0.0, 1.0, 0.0);
    u_xlat4.xyz = max(_ES_SunDirection.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.300000012);
    u_xlat4.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(-0.99000001<abs(u_xlat9));
#else
    u_xlatb27 = -0.99000001<abs(u_xlat9);
#endif
    u_xlat31 = abs(u_xlat9) + 1.0;
    u_xlat0.y = _HeightDiff / abs(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat0.x * float(_DistortionFactor), u_xlat0.y * float(_DepthDiffScale), u_xlat0.z * float(_DistortionFactor));
    u_xlat5.xyz = _WaterColor.xyz + _WaterColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat31);
    u_xlat6.xyz = max(_WaterColor.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat6.xyz = vec3(_Opacity) / u_xlat6.xyz;
    u_xlat7.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat6.xyz = u_xlat6.xyz * _WaterColor.xyz;
    u_xlat6.xyz = u_xlat0.yyy * u_xlat6.xyz;
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat7.xyz = max(u_xlat7.xyz, vec3(9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat7.xyz = u_xlat0.yyy * (-u_xlat7.xyz);
    u_xlat0.xy = u_xlat0.yy * u_xlat0.xz + vs_TEXCOORD2.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat7.xyz = exp2(u_xlat7.xyz);
    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat8.xyz;
    u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat7.xyz + u_xlat4.xyz;
    SV_Target0.w = 1.0;
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
Keywords { "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_REFLECTION" "LERP_SKY" }
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
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
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
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" "LERP_SKY" }
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
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
""
}
}
}
}
}