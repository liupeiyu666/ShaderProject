//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/Water_Transparent" {
Properties {
_ShallowColor ("ShallowColor", Color) = (0,1,0.5862069,0)
_DeepColor ("DeepColor", Color) = (0,0,0,0)
_ShoreTransparency ("ShoreTransparency", Range(0, 10)) = 0.04
_ShoreFade ("ShoreFade", Range(0, 5)) = 5
_DeepColorDepth ("DeepColorDepth", Range(0, 10)) = 0.04
_DeepColorFade ("DeepColorFade", Range(0, 5)) = 1
_Normal01 ("Normal01", 2D) = "white" { }
_Normal01_U_Speed ("Normal01_U_Speed", Float) = 0
_Normal01_V_Speed ("Normal01_V_Speed", Float) = 0
_Normal02 ("Normal02", 2D) = "bump" { }
_Normal02_U_Speed ("Normal02_U_Speed", Float) = 0
_Normal02_V_Speed ("Normal02_V_Speed", Float) = 0
_DistortionIntensity ("DistortionIntensity", Color) = (1,1,1,0)
_NormalMapScale ("NormalMapScale", Float) = 1
_ReflectionIntensity ("ReflectionIntensity", Range(0, 1)) = 0.6
_ShoreReflectionFade ("ShoreReflectionFade", Range(0, 10)) = 2.6
_FresnelPower ("FresnelPower", Range(0, 5)) = 5
_SSRDistortion ("SSRDistortion", Float) = 2
_SSRDistortion_Shore ("SSRDistortion_Shore", Float) = 0.01
_RefractionIntensity ("RefractionIntensity", Float) = 0
[Toggle(USE_SUNDIR)] _UseSundir ("Use Sun Dir", Float) = 1
_ES_SunDirection ("Sun Dir", Vector) = (1,1,1,1)
_Gloss ("Gloss", Float) = 1
_SpecularIntensity ("SpecularIntensity", Float) = 1
_SpecularPower ("SpecularPower", Range(0, 10)) = 1
_CausticTex ("CausticTex", 2D) = "white" { }
_CausticIntensity ("CausticIntensity", Float) = 1
_CausticColor ("CausticColor", Color) = (1,1,1,0)
_CausticTiling ("CausticTiling", Range(0, 1)) = 1
_CausticDistortionSpeed ("CausticDistortionSpeed", Range(0.1, 1)) = 1
_CausticDistortionTiling ("CausticDistortionTiling", Range(0, 1)) = 0.03588236
_CausticDistortionValue ("CausticDistortionValue", Range(0, 1)) = 0.1
_CausticFade ("CausticFade", Range(0.01, 10)) = 1
_CausticFadePower ("CausticFadePower", Range(0.1, 10)) = 0.1
_CausticDepth ("CausticDepth", Range(0.01, 50)) = 0.5
_CausticDistance ("CausticDistance", Float) = 2
_CausticOffset ("CausticOffset", Float) = 0
_OpacityByDepth ("OpacityByDepth", Range(0, 10)) = 0.04
_ReflectionTex ("Reflection Tex", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 63444
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat9;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat4 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD1.z = (-u_xlat1.x);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_V_Speed;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _RefractionIntensity;
uniform 	float _OpacityByDepth;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	mediump float _UseSundir;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _RefractionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
lowp vec2 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat12;
lowp float u_xlat10_12;
float u_xlat13;
vec2 u_xlat14;
mediump vec2 u_xlat16_16;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
float u_xlat20;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat6.xy = u_xlat0.xx * vs_TEXCOORD1.xy;
    u_xlat18 = _Time.y * _CausticDistortionSpeed;
    u_xlat6.xy = u_xlat6.xy * vec2(1.5, 1.5) + (-vec2(u_xlat18));
    u_xlat0.xw = vs_TEXCOORD1.xy * u_xlat0.xx + vec2(u_xlat18);
    u_xlat10_0.xw = texture(_CausticTex, u_xlat0.xw).yz;
    u_xlat10_6.xy = texture(_CausticTex, u_xlat6.xy).yz;
    u_xlat16_6.xy = (-u_xlat10_0.xw) + u_xlat10_6.xy;
    u_xlat16_0.xy = u_xlat16_6.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xw;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat12.x = _ProjectionParams.z / vs_TEXCOORD5.z;
    u_xlat1.xyz = u_xlat12.xxx * vs_TEXCOORD5.xyz;
    u_xlat12.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_12 = texture(_CustomDepthTexture, u_xlat12.xy).x;
    u_xlat12.xy = _ZBufferParams.zx * vec2(u_xlat10_12) + _ZBufferParams.wy;
    u_xlat12.xy = vec2(1.0, 1.0) / u_xlat12.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat12.yyy;
    u_xlat12.x = u_xlat12.x + (-vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat6.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat1.xyz = u_xlat6.xxx * vs_TEXCOORD4.xyz;
    u_xlat6.x = dot(_ES_SunDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _LightColor0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _CausticColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_CausticIntensity);
    u_xlat0.xyw = u_xlat10_0.xxx * u_xlat2.xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat3.x = _Time.y * _Normal02_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal02_V_Speed + u_xlat2.y;
    u_xlat10_2.xy = texture(_Normal02, u_xlat3.xy).xy;
    u_xlat16_4.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat2.xy = vs_TEXCOORD1.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_V_Speed + u_xlat2.y;
    u_xlat10_2.xy = texture(_Normal01, u_xlat3.xy).xy;
    u_xlat16_16.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_4.xz = u_xlat16_16.xy * vec2(_NormalMapScale) + u_xlat16_4.xy;
    u_xlat2.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat19 = float(1.0) / vs_TEXCOORD2.w;
    u_xlat19 = u_xlat19 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xy = vec2(u_xlat19) * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.ww;
    u_xlat2.xy = u_xlat12.xx * u_xlat2.xy;
    u_xlat2.z = 0.0;
    u_xlat3.xyz = u_xlat2.xyz + vs_TEXCOORD2.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_12 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat12.x = _ZBufferParams.z * u_xlat10_12 + _ZBufferParams.w;
    u_xlat12.x = float(1.0) / u_xlat12.x;
    u_xlat12.x = u_xlat12.x + (-vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat12.xxx * u_xlat2.xyz + vs_TEXCOORD2.xyw;
    u_xlat14.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat2.xy).xyz;
    u_xlat10_12 = texture(_CustomDepthTexture, u_xlat14.xy).x;
    u_xlat12.x = _ZBufferParams.z * u_xlat10_12 + _ZBufferParams.w;
    u_xlat12.x = float(1.0) / u_xlat12.x;
    u_xlat12.x = u_xlat12.x + (-vs_TEXCOORD2.w);
    u_xlat2.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat2.xy = u_xlat12.xx * u_xlat2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat19 = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = (-u_xlat2.y) + 1.0;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _CausticFadePower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat0.xyw = u_xlat0.xyw * vec3(u_xlat19);
    u_xlat0.xyw = u_xlat2.xxx * u_xlat0.xyw;
    u_xlat19 = vs_TEXCOORD1.z + (-_ProjectionParams.y);
    u_xlat19 = u_xlat19 + (-_CausticOffset);
    u_xlat19 = u_xlat19 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat0.xyw = u_xlat0.xyw * vec3(u_xlat19) + u_xlat10_3.xyz;
    u_xlat19 = float(1.0) / _ShoreTransparency;
    u_xlat2.x = u_xlat12.x * u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat2.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = (-u_xlat8.xyz) * u_xlat0.xyw + _DeepColor.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat8.xyz;
    u_xlat8.x = 0.100000001 / _DeepColorDepth;
    u_xlat8.x = u_xlat12.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = max(u_xlat8.x, 9.99999975e-05);
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _DeepColorFade;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.xyz = u_xlat3.xyz * u_xlat8.xxx;
    u_xlat0.xyw = u_xlat2.xxx * u_xlat8.xyz + u_xlat0.xyw;
    u_xlat2.x = u_xlat12.x + -1.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = u_xlat19 * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_4.y = 1.0;
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat20) + _ES_SunDirection.xyz;
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat7.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat3.xyz = u_xlat7.xxx * u_xlat5.xyz;
    u_xlat7.x = dot(u_xlat16_2.xyz, u_xlat3.xyz);
    u_xlat7.x = max(u_xlat7.x, 9.99999975e-05);
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat13 = _Gloss * 128.0;
    u_xlat7.x = u_xlat7.x * u_xlat13;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _SpecularIntensity;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.x = min(u_xlat7.x, 16.0);
    u_xlat2.xyz = u_xlat7.xxx * _LightColor0.xyz;
    u_xlat7.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.0<_UseSundir);
#else
    u_xlatb19 = 0.0<_UseSundir;
#endif
    u_xlat1.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyz, vec3(bvec3(u_xlatb19)));
    u_xlat1.xyz = u_xlat0.xyw + u_xlat1.xyz;
    u_xlat0.x = 0.100000001 / _OpacityByDepth;
    u_xlat1.w = u_xlat0.x * u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat9;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat4 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD1.z = (-u_xlat1.x);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_V_Speed;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _RefractionIntensity;
uniform 	float _OpacityByDepth;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	mediump float _UseSundir;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _RefractionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
lowp vec2 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat12;
lowp float u_xlat10_12;
float u_xlat13;
vec2 u_xlat14;
mediump vec2 u_xlat16_16;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
float u_xlat20;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat6.xy = u_xlat0.xx * vs_TEXCOORD1.xy;
    u_xlat18 = _Time.y * _CausticDistortionSpeed;
    u_xlat6.xy = u_xlat6.xy * vec2(1.5, 1.5) + (-vec2(u_xlat18));
    u_xlat0.xw = vs_TEXCOORD1.xy * u_xlat0.xx + vec2(u_xlat18);
    u_xlat10_0.xw = texture(_CausticTex, u_xlat0.xw).yz;
    u_xlat10_6.xy = texture(_CausticTex, u_xlat6.xy).yz;
    u_xlat16_6.xy = (-u_xlat10_0.xw) + u_xlat10_6.xy;
    u_xlat16_0.xy = u_xlat16_6.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xw;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat12.x = _ProjectionParams.z / vs_TEXCOORD5.z;
    u_xlat1.xyz = u_xlat12.xxx * vs_TEXCOORD5.xyz;
    u_xlat12.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_12 = texture(_CustomDepthTexture, u_xlat12.xy).x;
    u_xlat12.xy = _ZBufferParams.zx * vec2(u_xlat10_12) + _ZBufferParams.wy;
    u_xlat12.xy = vec2(1.0, 1.0) / u_xlat12.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat12.yyy;
    u_xlat12.x = u_xlat12.x + (-vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat6.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat1.xyz = u_xlat6.xxx * vs_TEXCOORD4.xyz;
    u_xlat6.x = dot(_ES_SunDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _LightColor0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _CausticColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_CausticIntensity);
    u_xlat0.xyw = u_xlat10_0.xxx * u_xlat2.xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat3.x = _Time.y * _Normal02_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal02_V_Speed + u_xlat2.y;
    u_xlat10_2.xy = texture(_Normal02, u_xlat3.xy).xy;
    u_xlat16_4.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat2.xy = vs_TEXCOORD1.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_V_Speed + u_xlat2.y;
    u_xlat10_2.xy = texture(_Normal01, u_xlat3.xy).xy;
    u_xlat16_16.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_4.xz = u_xlat16_16.xy * vec2(_NormalMapScale) + u_xlat16_4.xy;
    u_xlat2.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat19 = float(1.0) / vs_TEXCOORD2.w;
    u_xlat19 = u_xlat19 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xy = vec2(u_xlat19) * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.ww;
    u_xlat2.xy = u_xlat12.xx * u_xlat2.xy;
    u_xlat2.z = 0.0;
    u_xlat3.xyz = u_xlat2.xyz + vs_TEXCOORD2.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_12 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat12.x = _ZBufferParams.z * u_xlat10_12 + _ZBufferParams.w;
    u_xlat12.x = float(1.0) / u_xlat12.x;
    u_xlat12.x = u_xlat12.x + (-vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat12.xxx * u_xlat2.xyz + vs_TEXCOORD2.xyw;
    u_xlat14.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat2.xy).xyz;
    u_xlat10_12 = texture(_CustomDepthTexture, u_xlat14.xy).x;
    u_xlat12.x = _ZBufferParams.z * u_xlat10_12 + _ZBufferParams.w;
    u_xlat12.x = float(1.0) / u_xlat12.x;
    u_xlat12.x = u_xlat12.x + (-vs_TEXCOORD2.w);
    u_xlat2.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat2.xy = u_xlat12.xx * u_xlat2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat19 = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = (-u_xlat2.y) + 1.0;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _CausticFadePower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat0.xyw = u_xlat0.xyw * vec3(u_xlat19);
    u_xlat0.xyw = u_xlat2.xxx * u_xlat0.xyw;
    u_xlat19 = vs_TEXCOORD1.z + (-_ProjectionParams.y);
    u_xlat19 = u_xlat19 + (-_CausticOffset);
    u_xlat19 = u_xlat19 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat0.xyw = u_xlat0.xyw * vec3(u_xlat19) + u_xlat10_3.xyz;
    u_xlat19 = float(1.0) / _ShoreTransparency;
    u_xlat2.x = u_xlat12.x * u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat2.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = (-u_xlat8.xyz) * u_xlat0.xyw + _DeepColor.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat8.xyz;
    u_xlat8.x = 0.100000001 / _DeepColorDepth;
    u_xlat8.x = u_xlat12.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = max(u_xlat8.x, 9.99999975e-05);
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _DeepColorFade;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.xyz = u_xlat3.xyz * u_xlat8.xxx;
    u_xlat0.xyw = u_xlat2.xxx * u_xlat8.xyz + u_xlat0.xyw;
    u_xlat2.x = u_xlat12.x + -1.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = u_xlat19 * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_4.y = 1.0;
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat20) + _ES_SunDirection.xyz;
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat7.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat3.xyz = u_xlat7.xxx * u_xlat5.xyz;
    u_xlat7.x = dot(u_xlat16_2.xyz, u_xlat3.xyz);
    u_xlat7.x = max(u_xlat7.x, 9.99999975e-05);
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat13 = _Gloss * 128.0;
    u_xlat7.x = u_xlat7.x * u_xlat13;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _SpecularIntensity;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.x = min(u_xlat7.x, 16.0);
    u_xlat2.xyz = u_xlat7.xxx * _LightColor0.xyz;
    u_xlat7.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.0<_UseSundir);
#else
    u_xlatb19 = 0.0<_UseSundir;
#endif
    u_xlat1.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyz, vec3(bvec3(u_xlatb19)));
    u_xlat1.xyz = u_xlat0.xyw + u_xlat1.xyz;
    u_xlat0.x = 0.100000001 / _OpacityByDepth;
    u_xlat1.w = u_xlat0.x * u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat9;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat4 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD1.z = (-u_xlat1.x);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_V_Speed;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _RefractionIntensity;
uniform 	float _OpacityByDepth;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	mediump float _UseSundir;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _RefractionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
lowp vec2 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat12;
lowp float u_xlat10_12;
float u_xlat13;
vec2 u_xlat14;
mediump vec2 u_xlat16_16;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
float u_xlat20;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat6.xy = u_xlat0.xx * vs_TEXCOORD1.xy;
    u_xlat18 = _Time.y * _CausticDistortionSpeed;
    u_xlat6.xy = u_xlat6.xy * vec2(1.5, 1.5) + (-vec2(u_xlat18));
    u_xlat0.xw = vs_TEXCOORD1.xy * u_xlat0.xx + vec2(u_xlat18);
    u_xlat10_0.xw = texture(_CausticTex, u_xlat0.xw).yz;
    u_xlat10_6.xy = texture(_CausticTex, u_xlat6.xy).yz;
    u_xlat16_6.xy = (-u_xlat10_0.xw) + u_xlat10_6.xy;
    u_xlat16_0.xy = u_xlat16_6.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xw;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat12.x = _ProjectionParams.z / vs_TEXCOORD5.z;
    u_xlat1.xyz = u_xlat12.xxx * vs_TEXCOORD5.xyz;
    u_xlat12.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_12 = texture(_CustomDepthTexture, u_xlat12.xy).x;
    u_xlat12.xy = _ZBufferParams.zx * vec2(u_xlat10_12) + _ZBufferParams.wy;
    u_xlat12.xy = vec2(1.0, 1.0) / u_xlat12.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat12.yyy;
    u_xlat12.x = u_xlat12.x + (-vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat6.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat1.xyz = u_xlat6.xxx * vs_TEXCOORD4.xyz;
    u_xlat6.x = dot(_ES_SunDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _LightColor0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _CausticColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_CausticIntensity);
    u_xlat0.xyw = u_xlat10_0.xxx * u_xlat2.xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat3.x = _Time.y * _Normal02_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal02_V_Speed + u_xlat2.y;
    u_xlat10_2.xy = texture(_Normal02, u_xlat3.xy).xy;
    u_xlat16_4.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat2.xy = vs_TEXCOORD1.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_V_Speed + u_xlat2.y;
    u_xlat10_2.xy = texture(_Normal01, u_xlat3.xy).xy;
    u_xlat16_16.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_4.xz = u_xlat16_16.xy * vec2(_NormalMapScale) + u_xlat16_4.xy;
    u_xlat2.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat19 = float(1.0) / vs_TEXCOORD2.w;
    u_xlat19 = u_xlat19 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xy = vec2(u_xlat19) * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.ww;
    u_xlat2.xy = u_xlat12.xx * u_xlat2.xy;
    u_xlat2.z = 0.0;
    u_xlat3.xyz = u_xlat2.xyz + vs_TEXCOORD2.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_12 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat12.x = _ZBufferParams.z * u_xlat10_12 + _ZBufferParams.w;
    u_xlat12.x = float(1.0) / u_xlat12.x;
    u_xlat12.x = u_xlat12.x + (-vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat12.xxx * u_xlat2.xyz + vs_TEXCOORD2.xyw;
    u_xlat14.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat10_3.xyz = texture(_RefractionTex, u_xlat2.xy).xyz;
    u_xlat10_12 = texture(_CustomDepthTexture, u_xlat14.xy).x;
    u_xlat12.x = _ZBufferParams.z * u_xlat10_12 + _ZBufferParams.w;
    u_xlat12.x = float(1.0) / u_xlat12.x;
    u_xlat12.x = u_xlat12.x + (-vs_TEXCOORD2.w);
    u_xlat2.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat2.xy = u_xlat12.xx * u_xlat2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat19 = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = (-u_xlat2.y) + 1.0;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _CausticFadePower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat0.xyw = u_xlat0.xyw * vec3(u_xlat19);
    u_xlat0.xyw = u_xlat2.xxx * u_xlat0.xyw;
    u_xlat19 = vs_TEXCOORD1.z + (-_ProjectionParams.y);
    u_xlat19 = u_xlat19 + (-_CausticOffset);
    u_xlat19 = u_xlat19 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat0.xyw = u_xlat0.xyw * vec3(u_xlat19) + u_xlat10_3.xyz;
    u_xlat19 = float(1.0) / _ShoreTransparency;
    u_xlat2.x = u_xlat12.x * u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat2.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = (-u_xlat8.xyz) * u_xlat0.xyw + _DeepColor.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat8.xyz;
    u_xlat8.x = 0.100000001 / _DeepColorDepth;
    u_xlat8.x = u_xlat12.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = max(u_xlat8.x, 9.99999975e-05);
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _DeepColorFade;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.xyz = u_xlat3.xyz * u_xlat8.xxx;
    u_xlat0.xyw = u_xlat2.xxx * u_xlat8.xyz + u_xlat0.xyw;
    u_xlat2.x = u_xlat12.x + -1.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = u_xlat19 * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_4.y = 1.0;
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat20) + _ES_SunDirection.xyz;
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat7.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat3.xyz = u_xlat7.xxx * u_xlat5.xyz;
    u_xlat7.x = dot(u_xlat16_2.xyz, u_xlat3.xyz);
    u_xlat7.x = max(u_xlat7.x, 9.99999975e-05);
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat13 = _Gloss * 128.0;
    u_xlat7.x = u_xlat7.x * u_xlat13;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _SpecularIntensity;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.x = min(u_xlat7.x, 16.0);
    u_xlat2.xyz = u_xlat7.xxx * _LightColor0.xyz;
    u_xlat7.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.0<_UseSundir);
#else
    u_xlatb19 = 0.0<_UseSundir;
#endif
    u_xlat1.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyz, vec3(bvec3(u_xlatb19)));
    u_xlat1.xyz = u_xlat0.xyw + u_xlat1.xyz;
    u_xlat0.x = 0.100000001 / _OpacityByDepth;
    u_xlat1.w = u_xlat0.x * u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat9;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat4 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD1.z = (-u_xlat1.x);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_V_Speed;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _RefractionIntensity;
uniform 	float _OpacityByDepth;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRDistortion_Shore;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	float _ShoreReflectionFade;
uniform 	mediump float _UseSundir;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat11;
mediump vec2 u_xlat16_11;
lowp vec2 u_xlat10_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec3 u_xlat13;
vec2 u_xlat22;
lowp float u_xlat10_22;
float u_xlat23;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat37;
float u_xlat40;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat11.xy = u_xlat0.xx * vs_TEXCOORD1.xy;
    u_xlat33 = _Time.y * _CausticDistortionSpeed;
    u_xlat11.xy = u_xlat11.xy * vec2(1.5, 1.5) + (-vec2(u_xlat33));
    u_xlat0.xw = vs_TEXCOORD1.xy * u_xlat0.xx + vec2(u_xlat33);
    u_xlat10_0.xw = texture(_CausticTex, u_xlat0.xw).yz;
    u_xlat10_11.xy = texture(_CausticTex, u_xlat11.xy).yz;
    u_xlat16_11.xy = (-u_xlat10_0.xw) + u_xlat10_11.xy;
    u_xlat16_0.xy = u_xlat16_11.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xw;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat22.x = _ProjectionParams.z / vs_TEXCOORD5.z;
    u_xlat1.xyz = u_xlat22.xxx * vs_TEXCOORD5.xyz;
    u_xlat22.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_22 = texture(_CustomDepthTexture, u_xlat22.xy).x;
    u_xlat22.xy = _ZBufferParams.zx * vec2(u_xlat10_22) + _ZBufferParams.wy;
    u_xlat22.xy = vec2(1.0, 1.0) / u_xlat22.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat22.yyy;
    u_xlat22.x = u_xlat22.x + (-vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat22.x = min(max(u_xlat22.x, 0.0), 1.0);
#else
    u_xlat22.x = clamp(u_xlat22.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
    u_xlat11.x = dot(_ES_SunDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _CausticColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_CausticIntensity);
    u_xlat0.xyw = u_xlat10_0.xxx * u_xlat2.xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat3.x = _Time.y * _Normal02_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal02_V_Speed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal02, u_xlat3.xy).xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_V_Speed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.w = -1.0;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.wwz;
    u_xlat16_6.xy = u_xlat16_3.xy * vec2(_NormalMapScale);
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(_NormalMapScale);
    u_xlat16_6.z = -1.0;
    u_xlat16_5.xyz = u_xlat16_5.xzy + u_xlat16_6.xzy;
    u_xlat2.xy = u_xlat16_5.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat34 = float(1.0) / vs_TEXCOORD2.w;
    u_xlat34 = u_xlat34 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.ww;
    u_xlat2.xy = u_xlat22.xx * u_xlat2.xy;
    u_xlat2.z = 0.0;
    u_xlat4.xyz = u_xlat2.xyz + vs_TEXCOORD2.xyw;
    u_xlat4.xy = u_xlat4.xy / u_xlat4.zz;
    u_xlat10_22 = texture(_CustomDepthTexture, u_xlat4.xy).x;
    u_xlat22.x = _ZBufferParams.z * u_xlat10_22 + _ZBufferParams.w;
    u_xlat22.x = float(1.0) / u_xlat22.x;
    u_xlat22.x = u_xlat22.x + (-vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat22.x = min(max(u_xlat22.x, 0.0), 1.0);
#else
    u_xlat22.x = clamp(u_xlat22.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat22.xxx * u_xlat2.xyz + vs_TEXCOORD2.xyw;
    u_xlat24.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat10_4.xyz = texture(_RefractionTex, u_xlat2.xy).xyz;
    u_xlat10_22 = texture(_CustomDepthTexture, u_xlat24.xy).x;
    u_xlat22.x = _ZBufferParams.z * u_xlat10_22 + _ZBufferParams.w;
    u_xlat22.x = float(1.0) / u_xlat22.x;
    u_xlat22.x = u_xlat22.x + (-vs_TEXCOORD2.w);
    u_xlat2.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat2.xy = u_xlat22.xx * u_xlat2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat34 = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = (-u_xlat2.y) + 1.0;
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _CausticFadePower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat0.xyw = u_xlat0.xyw * vec3(u_xlat34);
    u_xlat0.xyw = u_xlat2.xxx * u_xlat0.xyw;
    u_xlat34 = vs_TEXCOORD1.z + (-_ProjectionParams.y);
    u_xlat34 = u_xlat34 + (-_CausticOffset);
    u_xlat34 = u_xlat34 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat0.xyw = u_xlat0.xyw * vec3(u_xlat34) + u_xlat10_4.xyz;
    u_xlat34 = float(1.0) / _ShoreTransparency;
    u_xlat2.x = u_xlat22.x * u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat13.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat13.xyz = u_xlat2.xxx * u_xlat13.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat13.xyz) * u_xlat0.xyw + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyw * u_xlat13.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat22.x * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz + u_xlat7.xyz;
    u_xlat8.xy = u_xlat16_5.xz * _DistortionIntensity.xy;
    u_xlat8.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat8.xy = u_xlat8.xy * vs_TEXCOORD2.ww;
    u_xlat37 = u_xlat22.x * _SSRDistortion_Shore;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xy = u_xlat8.xy * vec2(u_xlat37) + vs_TEXCOORD2.xy;
    u_xlat8.xy = u_xlat8.xy / vs_TEXCOORD2.ww;
    u_xlat10_8.xyz = texture(_ReflectionTex, u_xlat8.xy).xyz;
    u_xlat8.xyz = (-u_xlat4.xyz) + u_xlat10_8.xyz;
    u_xlat37 = float(1.0) / _ShoreReflectionFade;
    u_xlat37 = u_xlat22.x * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat10.xyz = vec3(u_xlat40) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat40) + _ES_SunDirection.xyz;
    u_xlat40 = dot(u_xlat10.xzy, u_xlat16_5.xyz);
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat12.x = (-u_xlat40) + 1.0;
    u_xlat12.x = max(u_xlat12.x, 9.99999975e-05);
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _FresnelPower;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _ReflectionIntensity;
    u_xlat12.x = u_xlat37 * u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat12.xxx * u_xlat8.xyz + u_xlat4.xyz;
    u_xlat0.xyw = (-u_xlat13.xyz) * u_xlat0.xyw + u_xlat4.xyz;
    u_xlat0.xyw = u_xlat2.xxx * u_xlat0.xyw + u_xlat7.xyz;
    u_xlat12.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat2.xyz = u_xlat12.xxx * u_xlat9.xyz;
    u_xlat16_5.y = 1.0;
    u_xlat16_12 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_4.xyz = vec3(u_xlat16_12) * u_xlat16_5.xyz;
    u_xlat12.x = dot(u_xlat16_4.xyz, u_xlat2.xyz);
    u_xlat12.x = max(u_xlat12.x, 9.99999975e-05);
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat23 = _Gloss * 128.0;
    u_xlat12.x = u_xlat12.x * u_xlat23;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _SpecularIntensity;
    u_xlat12.x = max(u_xlat12.x, 0.0);
    u_xlat12.x = min(u_xlat12.x, 16.0);
    u_xlat2.xyz = u_xlat12.xxx * _LightColor0.xyz;
    u_xlat12.x = u_xlat22.x + -1.0;
    u_xlat12.x = u_xlat34 * u_xlat12.x;
    u_xlat12.x = u_xlat12.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat12.xyz = u_xlat12.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat12.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.0<_UseSundir);
#else
    u_xlatb34 = 0.0<_UseSundir;
#endif
    u_xlat1.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyz, vec3(bvec3(u_xlatb34)));
    u_xlat1.xyz = u_xlat0.xyw + u_xlat1.xyz;
    u_xlat0.x = 0.100000001 / _OpacityByDepth;
    u_xlat1.w = u_xlat0.x * u_xlat22.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat9;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat4 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD1.z = (-u_xlat1.x);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_V_Speed;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _RefractionIntensity;
uniform 	float _OpacityByDepth;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRDistortion_Shore;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	float _ShoreReflectionFade;
uniform 	mediump float _UseSundir;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat11;
mediump vec2 u_xlat16_11;
lowp vec2 u_xlat10_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec3 u_xlat13;
vec2 u_xlat22;
lowp float u_xlat10_22;
float u_xlat23;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat37;
float u_xlat40;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat11.xy = u_xlat0.xx * vs_TEXCOORD1.xy;
    u_xlat33 = _Time.y * _CausticDistortionSpeed;
    u_xlat11.xy = u_xlat11.xy * vec2(1.5, 1.5) + (-vec2(u_xlat33));
    u_xlat0.xw = vs_TEXCOORD1.xy * u_xlat0.xx + vec2(u_xlat33);
    u_xlat10_0.xw = texture(_CausticTex, u_xlat0.xw).yz;
    u_xlat10_11.xy = texture(_CausticTex, u_xlat11.xy).yz;
    u_xlat16_11.xy = (-u_xlat10_0.xw) + u_xlat10_11.xy;
    u_xlat16_0.xy = u_xlat16_11.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xw;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat22.x = _ProjectionParams.z / vs_TEXCOORD5.z;
    u_xlat1.xyz = u_xlat22.xxx * vs_TEXCOORD5.xyz;
    u_xlat22.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_22 = texture(_CustomDepthTexture, u_xlat22.xy).x;
    u_xlat22.xy = _ZBufferParams.zx * vec2(u_xlat10_22) + _ZBufferParams.wy;
    u_xlat22.xy = vec2(1.0, 1.0) / u_xlat22.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat22.yyy;
    u_xlat22.x = u_xlat22.x + (-vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat22.x = min(max(u_xlat22.x, 0.0), 1.0);
#else
    u_xlat22.x = clamp(u_xlat22.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
    u_xlat11.x = dot(_ES_SunDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _CausticColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_CausticIntensity);
    u_xlat0.xyw = u_xlat10_0.xxx * u_xlat2.xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat3.x = _Time.y * _Normal02_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal02_V_Speed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal02, u_xlat3.xy).xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_V_Speed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.w = -1.0;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.wwz;
    u_xlat16_6.xy = u_xlat16_3.xy * vec2(_NormalMapScale);
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(_NormalMapScale);
    u_xlat16_6.z = -1.0;
    u_xlat16_5.xyz = u_xlat16_5.xzy + u_xlat16_6.xzy;
    u_xlat2.xy = u_xlat16_5.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat34 = float(1.0) / vs_TEXCOORD2.w;
    u_xlat34 = u_xlat34 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.ww;
    u_xlat2.xy = u_xlat22.xx * u_xlat2.xy;
    u_xlat2.z = 0.0;
    u_xlat4.xyz = u_xlat2.xyz + vs_TEXCOORD2.xyw;
    u_xlat4.xy = u_xlat4.xy / u_xlat4.zz;
    u_xlat10_22 = texture(_CustomDepthTexture, u_xlat4.xy).x;
    u_xlat22.x = _ZBufferParams.z * u_xlat10_22 + _ZBufferParams.w;
    u_xlat22.x = float(1.0) / u_xlat22.x;
    u_xlat22.x = u_xlat22.x + (-vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat22.x = min(max(u_xlat22.x, 0.0), 1.0);
#else
    u_xlat22.x = clamp(u_xlat22.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat22.xxx * u_xlat2.xyz + vs_TEXCOORD2.xyw;
    u_xlat24.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat10_4.xyz = texture(_RefractionTex, u_xlat2.xy).xyz;
    u_xlat10_22 = texture(_CustomDepthTexture, u_xlat24.xy).x;
    u_xlat22.x = _ZBufferParams.z * u_xlat10_22 + _ZBufferParams.w;
    u_xlat22.x = float(1.0) / u_xlat22.x;
    u_xlat22.x = u_xlat22.x + (-vs_TEXCOORD2.w);
    u_xlat2.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat2.xy = u_xlat22.xx * u_xlat2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat34 = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = (-u_xlat2.y) + 1.0;
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _CausticFadePower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat0.xyw = u_xlat0.xyw * vec3(u_xlat34);
    u_xlat0.xyw = u_xlat2.xxx * u_xlat0.xyw;
    u_xlat34 = vs_TEXCOORD1.z + (-_ProjectionParams.y);
    u_xlat34 = u_xlat34 + (-_CausticOffset);
    u_xlat34 = u_xlat34 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat0.xyw = u_xlat0.xyw * vec3(u_xlat34) + u_xlat10_4.xyz;
    u_xlat34 = float(1.0) / _ShoreTransparency;
    u_xlat2.x = u_xlat22.x * u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat13.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat13.xyz = u_xlat2.xxx * u_xlat13.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat13.xyz) * u_xlat0.xyw + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyw * u_xlat13.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat22.x * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz + u_xlat7.xyz;
    u_xlat8.xy = u_xlat16_5.xz * _DistortionIntensity.xy;
    u_xlat8.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat8.xy = u_xlat8.xy * vs_TEXCOORD2.ww;
    u_xlat37 = u_xlat22.x * _SSRDistortion_Shore;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xy = u_xlat8.xy * vec2(u_xlat37) + vs_TEXCOORD2.xy;
    u_xlat8.xy = u_xlat8.xy / vs_TEXCOORD2.ww;
    u_xlat10_8.xyz = texture(_ReflectionTex, u_xlat8.xy).xyz;
    u_xlat8.xyz = (-u_xlat4.xyz) + u_xlat10_8.xyz;
    u_xlat37 = float(1.0) / _ShoreReflectionFade;
    u_xlat37 = u_xlat22.x * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat10.xyz = vec3(u_xlat40) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat40) + _ES_SunDirection.xyz;
    u_xlat40 = dot(u_xlat10.xzy, u_xlat16_5.xyz);
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat12.x = (-u_xlat40) + 1.0;
    u_xlat12.x = max(u_xlat12.x, 9.99999975e-05);
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _FresnelPower;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _ReflectionIntensity;
    u_xlat12.x = u_xlat37 * u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat12.xxx * u_xlat8.xyz + u_xlat4.xyz;
    u_xlat0.xyw = (-u_xlat13.xyz) * u_xlat0.xyw + u_xlat4.xyz;
    u_xlat0.xyw = u_xlat2.xxx * u_xlat0.xyw + u_xlat7.xyz;
    u_xlat12.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat2.xyz = u_xlat12.xxx * u_xlat9.xyz;
    u_xlat16_5.y = 1.0;
    u_xlat16_12 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_4.xyz = vec3(u_xlat16_12) * u_xlat16_5.xyz;
    u_xlat12.x = dot(u_xlat16_4.xyz, u_xlat2.xyz);
    u_xlat12.x = max(u_xlat12.x, 9.99999975e-05);
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat23 = _Gloss * 128.0;
    u_xlat12.x = u_xlat12.x * u_xlat23;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _SpecularIntensity;
    u_xlat12.x = max(u_xlat12.x, 0.0);
    u_xlat12.x = min(u_xlat12.x, 16.0);
    u_xlat2.xyz = u_xlat12.xxx * _LightColor0.xyz;
    u_xlat12.x = u_xlat22.x + -1.0;
    u_xlat12.x = u_xlat34 * u_xlat12.x;
    u_xlat12.x = u_xlat12.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat12.xyz = u_xlat12.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat12.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.0<_UseSundir);
#else
    u_xlatb34 = 0.0<_UseSundir;
#endif
    u_xlat1.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyz, vec3(bvec3(u_xlatb34)));
    u_xlat1.xyz = u_xlat0.xyw + u_xlat1.xyz;
    u_xlat0.x = 0.100000001 / _OpacityByDepth;
    u_xlat1.w = u_xlat0.x * u_xlat22.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat9;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat4 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD1.z = (-u_xlat1.x);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_V_Speed;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _RefractionIntensity;
uniform 	float _OpacityByDepth;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	float _Gloss;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRDistortion_Shore;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	float _ShoreReflectionFade;
uniform 	mediump float _UseSundir;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _ReflectionTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat11;
mediump vec2 u_xlat16_11;
lowp vec2 u_xlat10_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec3 u_xlat13;
vec2 u_xlat22;
lowp float u_xlat10_22;
float u_xlat23;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat37;
float u_xlat40;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat11.xy = u_xlat0.xx * vs_TEXCOORD1.xy;
    u_xlat33 = _Time.y * _CausticDistortionSpeed;
    u_xlat11.xy = u_xlat11.xy * vec2(1.5, 1.5) + (-vec2(u_xlat33));
    u_xlat0.xw = vs_TEXCOORD1.xy * u_xlat0.xx + vec2(u_xlat33);
    u_xlat10_0.xw = texture(_CausticTex, u_xlat0.xw).yz;
    u_xlat10_11.xy = texture(_CausticTex, u_xlat11.xy).yz;
    u_xlat16_11.xy = (-u_xlat10_0.xw) + u_xlat10_11.xy;
    u_xlat16_0.xy = u_xlat16_11.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xw;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat22.x = _ProjectionParams.z / vs_TEXCOORD5.z;
    u_xlat1.xyz = u_xlat22.xxx * vs_TEXCOORD5.xyz;
    u_xlat22.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_22 = texture(_CustomDepthTexture, u_xlat22.xy).x;
    u_xlat22.xy = _ZBufferParams.zx * vec2(u_xlat10_22) + _ZBufferParams.wy;
    u_xlat22.xy = vec2(1.0, 1.0) / u_xlat22.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat22.yyy;
    u_xlat22.x = u_xlat22.x + (-vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat22.x = min(max(u_xlat22.x, 0.0), 1.0);
#else
    u_xlat22.x = clamp(u_xlat22.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
    u_xlat11.x = dot(_ES_SunDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat11.xxx * _LightColor0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _CausticColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_CausticIntensity);
    u_xlat0.xyw = u_xlat10_0.xxx * u_xlat2.xyz;
    u_xlat2.xy = vs_TEXCOORD1.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat3.x = _Time.y * _Normal02_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal02_V_Speed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal02, u_xlat3.xy).xyz;
    u_xlat3.xy = vs_TEXCOORD1.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_V_Speed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.w = -1.0;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.wwz;
    u_xlat16_6.xy = u_xlat16_3.xy * vec2(_NormalMapScale);
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(_NormalMapScale);
    u_xlat16_6.z = -1.0;
    u_xlat16_5.xyz = u_xlat16_5.xzy + u_xlat16_6.xzy;
    u_xlat2.xy = u_xlat16_5.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat34 = float(1.0) / vs_TEXCOORD2.w;
    u_xlat34 = u_xlat34 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.ww;
    u_xlat2.xy = u_xlat22.xx * u_xlat2.xy;
    u_xlat2.z = 0.0;
    u_xlat4.xyz = u_xlat2.xyz + vs_TEXCOORD2.xyw;
    u_xlat4.xy = u_xlat4.xy / u_xlat4.zz;
    u_xlat10_22 = texture(_CustomDepthTexture, u_xlat4.xy).x;
    u_xlat22.x = _ZBufferParams.z * u_xlat10_22 + _ZBufferParams.w;
    u_xlat22.x = float(1.0) / u_xlat22.x;
    u_xlat22.x = u_xlat22.x + (-vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat22.x = min(max(u_xlat22.x, 0.0), 1.0);
#else
    u_xlat22.x = clamp(u_xlat22.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat22.xxx * u_xlat2.xyz + vs_TEXCOORD2.xyw;
    u_xlat24.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat10_4.xyz = texture(_RefractionTex, u_xlat2.xy).xyz;
    u_xlat10_22 = texture(_CustomDepthTexture, u_xlat24.xy).x;
    u_xlat22.x = _ZBufferParams.z * u_xlat10_22 + _ZBufferParams.w;
    u_xlat22.x = float(1.0) / u_xlat22.x;
    u_xlat22.x = u_xlat22.x + (-vs_TEXCOORD2.w);
    u_xlat2.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat2.xy = u_xlat22.xx * u_xlat2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat34 = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = (-u_xlat2.y) + 1.0;
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _CausticFadePower;
    u_xlat34 = exp2(u_xlat34);
    u_xlat0.xyw = u_xlat0.xyw * vec3(u_xlat34);
    u_xlat0.xyw = u_xlat2.xxx * u_xlat0.xyw;
    u_xlat34 = vs_TEXCOORD1.z + (-_ProjectionParams.y);
    u_xlat34 = u_xlat34 + (-_CausticOffset);
    u_xlat34 = u_xlat34 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat0.xyw = u_xlat0.xyw * vec3(u_xlat34) + u_xlat10_4.xyz;
    u_xlat34 = float(1.0) / _ShoreTransparency;
    u_xlat2.x = u_xlat22.x * u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat13.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat13.xyz = u_xlat2.xxx * u_xlat13.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat13.xyz) * u_xlat0.xyw + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyw * u_xlat13.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat22.x * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz + u_xlat7.xyz;
    u_xlat8.xy = u_xlat16_5.xz * _DistortionIntensity.xy;
    u_xlat8.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat8.xy = u_xlat8.xy * vs_TEXCOORD2.ww;
    u_xlat37 = u_xlat22.x * _SSRDistortion_Shore;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xy = u_xlat8.xy * vec2(u_xlat37) + vs_TEXCOORD2.xy;
    u_xlat8.xy = u_xlat8.xy / vs_TEXCOORD2.ww;
    u_xlat10_8.xyz = texture(_ReflectionTex, u_xlat8.xy).xyz;
    u_xlat8.xyz = (-u_xlat4.xyz) + u_xlat10_8.xyz;
    u_xlat37 = float(1.0) / _ShoreReflectionFade;
    u_xlat37 = u_xlat22.x * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat10.xyz = vec3(u_xlat40) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat40) + _ES_SunDirection.xyz;
    u_xlat40 = dot(u_xlat10.xzy, u_xlat16_5.xyz);
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat12.x = (-u_xlat40) + 1.0;
    u_xlat12.x = max(u_xlat12.x, 9.99999975e-05);
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _FresnelPower;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _ReflectionIntensity;
    u_xlat12.x = u_xlat37 * u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat12.xxx * u_xlat8.xyz + u_xlat4.xyz;
    u_xlat0.xyw = (-u_xlat13.xyz) * u_xlat0.xyw + u_xlat4.xyz;
    u_xlat0.xyw = u_xlat2.xxx * u_xlat0.xyw + u_xlat7.xyz;
    u_xlat12.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat2.xyz = u_xlat12.xxx * u_xlat9.xyz;
    u_xlat16_5.y = 1.0;
    u_xlat16_12 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_4.xyz = vec3(u_xlat16_12) * u_xlat16_5.xyz;
    u_xlat12.x = dot(u_xlat16_4.xyz, u_xlat2.xyz);
    u_xlat12.x = max(u_xlat12.x, 9.99999975e-05);
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat23 = _Gloss * 128.0;
    u_xlat12.x = u_xlat12.x * u_xlat23;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _SpecularIntensity;
    u_xlat12.x = max(u_xlat12.x, 0.0);
    u_xlat12.x = min(u_xlat12.x, 16.0);
    u_xlat2.xyz = u_xlat12.xxx * _LightColor0.xyz;
    u_xlat12.x = u_xlat22.x + -1.0;
    u_xlat12.x = u_xlat34 * u_xlat12.x;
    u_xlat12.x = u_xlat12.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat12.xyz = u_xlat12.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat12.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.0<_UseSundir);
#else
    u_xlatb34 = 0.0<_UseSundir;
#endif
    u_xlat1.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyz, vec3(bvec3(u_xlatb34)));
    u_xlat1.xyz = u_xlat0.xyw + u_xlat1.xyz;
    u_xlat0.x = 0.100000001 / _OpacityByDepth;
    u_xlat1.w = u_xlat0.x * u_xlat22.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
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
}
}
}
}