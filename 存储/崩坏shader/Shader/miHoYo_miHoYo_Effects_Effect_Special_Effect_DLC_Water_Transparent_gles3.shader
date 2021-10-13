//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/DLC_Water_Transparent" {
Properties {
_ShallowColor ("ShallowColor", Color) = (0,1,0.5862069,0)
_DeepColor ("DeepColor", Color) = (0,0,0,0)
_ShoreTransparency ("ShoreTransparency", Range(0, 10)) = 0.04
_ShoreFade ("ShoreFade", Range(0, 5)) = 5
_Normal01 ("Normal01", 2D) = "white" { }
_DeepColorDepth ("DeepColorDepth", Range(0, 10)) = 0.04
_DeepColorFade ("DeepColorFade", Range(0, 5)) = 1
_Normal01_U_Speed ("Normal01_U_Speed", Float) = 0
_Normal01_VSpeed ("Normal01_V-Speed", Float) = 0
_Normal02 ("Normal02", 2D) = "bump" { }
_Normal02_U_Speed ("Normal02_U_Speed", Float) = 0
_Normal02_V_Speed ("Normal02_V_Speed", Float) = 0
_ReflectionTex ("Reflection", 2D) = "white" { }
_DistortionIntensity ("DistortionIntensity", Color) = (1,1,1,0)
_NormalMapBias ("NormalMapBias", Float) = -1
_NormalMapScale ("NormalMapScale", Float) = 1
_ReflectionIntensity ("ReflectionIntensity", Range(0, 1)) = 0.6
_ShoreReflectionFade ("ShoreReflectionFade", Range(0, 10)) = 2.6
_FresnelPower ("FresnelPower", Range(0, 5)) = 5
[MHYToggle] _SSRToggle ("SSRToggle", Float) = 1
_SSRDistortion ("SSRDistortion", Float) = 2
_SSRDistortion_Shore ("SSRDistortion_Shore", Float) = 0.01
_RefractionIntensity ("RefractionIntensity", Float) = 0
_ES_SunDirection ("Sun Direction", Vector) = (1,1,1,0)
_Gloss ("Gloss", Float) = 1
_SpecularIntensity ("SpecularIntensity", Float) = 1
_SpecularPower ("SpecularPower", Range(0, 10)) = 1
_FoamTexture ("FoamTexture", 2D) = "black" { }
_FoamColor ("FoamColor", Color) = (1,1,1,1)
_FoamWidth ("FoamWidth", Range(0, 5)) = 0.5
_FoamFade ("FoamFade", Range(0, 2)) = 2
_FoamSpeed ("FoamSpeed", Float) = 0
_FoamFadeDistance ("FoamFadeDistance", Float) = 2
_FoamFadeOffset ("FoamFadeOffset", Float) = 0
_OpacityByDepth ("OpacityByDepth", Range(0, 1)) = 0.04
_WaterMeshScale ("WaterMeshScale", Vector) = (1,1,1,0)
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
  Name "SUBSHADER 0 PASS 0"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 37506
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat7;
float u_xlat18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat7;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD2.z = (-u_xlat1.x);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat18) * u_xlat0.xyz;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
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
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRDistortion_Shore;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	float _ShoreReflectionFade;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat11;
mediump float u_xlat16_11;
lowp float u_xlat10_11;
float u_xlat13;
vec2 u_xlat20;
lowp float u_xlat10_20;
vec2 u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump vec2 u_xlat16_22;
float u_xlat23;
mediump float u_xlat16_23;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xy = texture(_Normal02, u_xlat1.xy, _NormalMapBias).xy;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat0.xy = vs_TEXCOORD2.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xy;
    u_xlat16_22.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xz = u_xlat16_22.xy * vec2(_NormalMapScale) + u_xlat16_2.xy;
    u_xlat0.xy = u_xlat16_2.xz * _DistortionIntensity.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(_SSRDistortion);
    u_xlat20.xy = u_xlat16_2.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat1.x = float(1.0) / vs_TEXCOORD3.w;
    u_xlat1.x = u_xlat1.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.zw = u_xlat20.xy * u_xlat1.xx;
    u_xlat0 = u_xlat0 * vs_TEXCOORD3.wwww;
    u_xlat1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_1.x = texture(_CustomDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat10_1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD3.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vec2(u_xlat0.z * u_xlat1.x, u_xlat0.w * u_xlat1.x);
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat20.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_20 = texture(_CustomDepthTexture, u_xlat20.xy).x;
    u_xlat20.x = _ZBufferParams.z * u_xlat10_20 + _ZBufferParams.w;
    u_xlat20.x = float(1.0) / u_xlat20.x;
    u_xlat20.x = u_xlat20.x + (-vs_TEXCOORD3.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat20.x = min(max(u_xlat20.x, 0.0), 1.0);
#else
    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat20.xxx * u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat20.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD3.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat10_20 = texture(_CustomDepthTexture, u_xlat20.xy).x;
    u_xlat20.x = _ZBufferParams.z * u_xlat10_20 + _ZBufferParams.w;
    u_xlat20.x = float(1.0) / u_xlat20.x;
    u_xlat20.x = u_xlat20.x + (-vs_TEXCOORD3.w);
    u_xlat30 = u_xlat20.x * _SSRDistortion_Shore;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat30) + vs_TEXCOORD3.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD3.ww;
    u_xlat10_0.xyw = texture(_ReflectionTex, u_xlat0.xy).xyz;
    u_xlat31 = 0.100000001 / _DeepColorDepth;
    u_xlat31 = u_xlat20.x * u_xlat31;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 9.99999975e-05);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _DeepColorFade;
    u_xlat31 = exp2(u_xlat31);
    u_xlat3.x = float(1.0) / _ShoreTransparency;
    u_xlat13 = u_xlat20.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat13 = max(u_xlat13, 9.99999975e-05);
    u_xlat13 = log2(u_xlat13);
    u_xlat13 = u_xlat13 * _ShoreFade;
    u_xlat13 = exp2(u_xlat13);
    u_xlat4.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = vec3(u_xlat13) * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = (-u_xlat4.xyz) * u_xlat10_1.xyz + _DeepColor.xyz;
    u_xlat6.xyz = u_xlat10_1.xyz * u_xlat4.xyz;
    u_xlat5.xyz = vec3(u_xlat31) * u_xlat5.xyz + u_xlat6.xyz;
    u_xlat0.xyw = u_xlat10_0.xyw + (-u_xlat5.xyz);
    u_xlat31 = float(1.0) / _ShoreReflectionFade;
    u_xlat31 = u_xlat20.x * u_xlat31;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_2.y = 1.0;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_7.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23);
    u_xlat8.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat9.xyz = vec3(u_xlat23) * u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23) + _ES_SunDirection.xyz;
    u_xlat23 = dot(u_xlat9.xyz, u_xlat16_7.xyz);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999975e-05);
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _FresnelPower;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = u_xlat23 * _ReflectionIntensity;
    u_xlat31 = u_xlat31 * u_xlat23;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat0.xyw = vec3(u_xlat31) * u_xlat0.xyw + u_xlat5.xyz;
    u_xlat0.xyw = (-u_xlat4.xyz) * u_xlat10_1.xyz + u_xlat0.xyw;
    u_xlat0.xyw = vec3(u_xlat13) * u_xlat0.xyw + u_xlat6.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = dot(u_xlat16_7.xyz, u_xlat1.xyz);
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat11 = _Gloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat11;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat31 = u_xlat20.x + -1.0;
    u_xlat31 = u_xlat3.x * u_xlat31;
    u_xlat31 = u_xlat31 * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.0>=_ES_SunDirection.y);
#else
    u_xlatb31 = 0.0>=_ES_SunDirection.y;
#endif
    u_xlat1.xyz = (bool(u_xlatb31)) ? vec3(0.0, 0.0, 0.0) : u_xlat1.xyz;
    u_xlat31 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * vs_TEXCOORD5.xyz;
    u_xlat31 = dot(u_xlat9.xyz, u_xlat3.xyz);
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat31 = max(u_xlat31, 9.99999975e-05);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _SpecularPower;
    u_xlat31 = exp2(u_xlat31);
    u_xlat0.xyw = u_xlat1.xyz * vec3(u_xlat31) + u_xlat0.xyw;
    u_xlat1.x = float(1.0) / _FoamFade;
    u_xlat1.x = u_xlat20.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = _Time.y * _FoamSpeed;
    u_xlat21.xy = vec2(u_xlat11) * vec2(-0.0480000004, 0.027999999);
    u_xlat3.xy = vs_TEXCOORD2.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat21.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat21.xy;
    u_xlat3.xy = vec2(u_xlat11) * vec2(0.0599999987, 0.0399999991) + u_xlat3.xy;
    u_xlat10_11 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat10_21 = texture(_FoamTexture, u_xlat21.xy).x;
    u_xlat16_21 = u_xlat10_21 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_21 * u_xlat10_11;
    u_xlat1.x = u_xlat1.x * u_xlat16_11;
    u_xlat11 = vs_TEXCOORD2.z + (-_ProjectionParams.y);
    u_xlat11 = u_xlat11 + (-_FoamFadeOffset);
    u_xlat11 = u_xlat11 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat11 * _FoamWidth;
    u_xlat11 = float(1.0) / u_xlat11;
    u_xlat20.x = u_xlat20.x * u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlat20.x = min(max(u_xlat20.x, 0.0), 1.0);
#else
    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
#endif
    u_xlat20.x = (-u_xlat20.x) + 1.0;
    u_xlat20.x = u_xlat20.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat20.xxx * _FoamColor.xyz + u_xlat0.xyw;
    u_xlat0.w = 0.100000001 / _OpacityByDepth;
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
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat7;
float u_xlat18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat7;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD2.z = (-u_xlat1.x);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat18) * u_xlat0.xyz;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
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
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRDistortion_Shore;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	float _ShoreReflectionFade;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat11;
mediump float u_xlat16_11;
lowp float u_xlat10_11;
float u_xlat13;
vec2 u_xlat20;
lowp float u_xlat10_20;
vec2 u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump vec2 u_xlat16_22;
float u_xlat23;
mediump float u_xlat16_23;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xy = texture(_Normal02, u_xlat1.xy, _NormalMapBias).xy;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat0.xy = vs_TEXCOORD2.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xy;
    u_xlat16_22.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xz = u_xlat16_22.xy * vec2(_NormalMapScale) + u_xlat16_2.xy;
    u_xlat0.xy = u_xlat16_2.xz * _DistortionIntensity.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(_SSRDistortion);
    u_xlat20.xy = u_xlat16_2.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat1.x = float(1.0) / vs_TEXCOORD3.w;
    u_xlat1.x = u_xlat1.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.zw = u_xlat20.xy * u_xlat1.xx;
    u_xlat0 = u_xlat0 * vs_TEXCOORD3.wwww;
    u_xlat1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_1.x = texture(_CustomDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat10_1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD3.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vec2(u_xlat0.z * u_xlat1.x, u_xlat0.w * u_xlat1.x);
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat20.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_20 = texture(_CustomDepthTexture, u_xlat20.xy).x;
    u_xlat20.x = _ZBufferParams.z * u_xlat10_20 + _ZBufferParams.w;
    u_xlat20.x = float(1.0) / u_xlat20.x;
    u_xlat20.x = u_xlat20.x + (-vs_TEXCOORD3.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat20.x = min(max(u_xlat20.x, 0.0), 1.0);
#else
    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat20.xxx * u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat20.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD3.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat10_20 = texture(_CustomDepthTexture, u_xlat20.xy).x;
    u_xlat20.x = _ZBufferParams.z * u_xlat10_20 + _ZBufferParams.w;
    u_xlat20.x = float(1.0) / u_xlat20.x;
    u_xlat20.x = u_xlat20.x + (-vs_TEXCOORD3.w);
    u_xlat30 = u_xlat20.x * _SSRDistortion_Shore;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat30) + vs_TEXCOORD3.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD3.ww;
    u_xlat10_0.xyw = texture(_ReflectionTex, u_xlat0.xy).xyz;
    u_xlat31 = 0.100000001 / _DeepColorDepth;
    u_xlat31 = u_xlat20.x * u_xlat31;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 9.99999975e-05);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _DeepColorFade;
    u_xlat31 = exp2(u_xlat31);
    u_xlat3.x = float(1.0) / _ShoreTransparency;
    u_xlat13 = u_xlat20.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat13 = max(u_xlat13, 9.99999975e-05);
    u_xlat13 = log2(u_xlat13);
    u_xlat13 = u_xlat13 * _ShoreFade;
    u_xlat13 = exp2(u_xlat13);
    u_xlat4.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = vec3(u_xlat13) * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = (-u_xlat4.xyz) * u_xlat10_1.xyz + _DeepColor.xyz;
    u_xlat6.xyz = u_xlat10_1.xyz * u_xlat4.xyz;
    u_xlat5.xyz = vec3(u_xlat31) * u_xlat5.xyz + u_xlat6.xyz;
    u_xlat0.xyw = u_xlat10_0.xyw + (-u_xlat5.xyz);
    u_xlat31 = float(1.0) / _ShoreReflectionFade;
    u_xlat31 = u_xlat20.x * u_xlat31;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_2.y = 1.0;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_7.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23);
    u_xlat8.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat9.xyz = vec3(u_xlat23) * u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23) + _ES_SunDirection.xyz;
    u_xlat23 = dot(u_xlat9.xyz, u_xlat16_7.xyz);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999975e-05);
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _FresnelPower;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = u_xlat23 * _ReflectionIntensity;
    u_xlat31 = u_xlat31 * u_xlat23;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat0.xyw = vec3(u_xlat31) * u_xlat0.xyw + u_xlat5.xyz;
    u_xlat0.xyw = (-u_xlat4.xyz) * u_xlat10_1.xyz + u_xlat0.xyw;
    u_xlat0.xyw = vec3(u_xlat13) * u_xlat0.xyw + u_xlat6.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = dot(u_xlat16_7.xyz, u_xlat1.xyz);
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat11 = _Gloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat11;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat31 = u_xlat20.x + -1.0;
    u_xlat31 = u_xlat3.x * u_xlat31;
    u_xlat31 = u_xlat31 * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.0>=_ES_SunDirection.y);
#else
    u_xlatb31 = 0.0>=_ES_SunDirection.y;
#endif
    u_xlat1.xyz = (bool(u_xlatb31)) ? vec3(0.0, 0.0, 0.0) : u_xlat1.xyz;
    u_xlat31 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * vs_TEXCOORD5.xyz;
    u_xlat31 = dot(u_xlat9.xyz, u_xlat3.xyz);
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat31 = max(u_xlat31, 9.99999975e-05);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _SpecularPower;
    u_xlat31 = exp2(u_xlat31);
    u_xlat0.xyw = u_xlat1.xyz * vec3(u_xlat31) + u_xlat0.xyw;
    u_xlat1.x = float(1.0) / _FoamFade;
    u_xlat1.x = u_xlat20.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = _Time.y * _FoamSpeed;
    u_xlat21.xy = vec2(u_xlat11) * vec2(-0.0480000004, 0.027999999);
    u_xlat3.xy = vs_TEXCOORD2.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat21.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat21.xy;
    u_xlat3.xy = vec2(u_xlat11) * vec2(0.0599999987, 0.0399999991) + u_xlat3.xy;
    u_xlat10_11 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat10_21 = texture(_FoamTexture, u_xlat21.xy).x;
    u_xlat16_21 = u_xlat10_21 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_21 * u_xlat10_11;
    u_xlat1.x = u_xlat1.x * u_xlat16_11;
    u_xlat11 = vs_TEXCOORD2.z + (-_ProjectionParams.y);
    u_xlat11 = u_xlat11 + (-_FoamFadeOffset);
    u_xlat11 = u_xlat11 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat11 * _FoamWidth;
    u_xlat11 = float(1.0) / u_xlat11;
    u_xlat20.x = u_xlat20.x * u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlat20.x = min(max(u_xlat20.x, 0.0), 1.0);
#else
    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
#endif
    u_xlat20.x = (-u_xlat20.x) + 1.0;
    u_xlat20.x = u_xlat20.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat20.xxx * _FoamColor.xyz + u_xlat0.xyw;
    u_xlat0.w = 0.100000001 / _OpacityByDepth;
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
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat7;
float u_xlat18;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat7;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD2.z = (-u_xlat1.x);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat18) * u_xlat0.xyz;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
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
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRDistortion_Shore;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	float _ShoreReflectionFade;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat11;
mediump float u_xlat16_11;
lowp float u_xlat10_11;
float u_xlat13;
vec2 u_xlat20;
lowp float u_xlat10_20;
vec2 u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump vec2 u_xlat16_22;
float u_xlat23;
mediump float u_xlat16_23;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xy = texture(_Normal02, u_xlat1.xy, _NormalMapBias).xy;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat0.xy = vs_TEXCOORD2.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xy;
    u_xlat16_22.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xz = u_xlat16_22.xy * vec2(_NormalMapScale) + u_xlat16_2.xy;
    u_xlat0.xy = u_xlat16_2.xz * _DistortionIntensity.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(_SSRDistortion);
    u_xlat20.xy = u_xlat16_2.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat1.x = float(1.0) / vs_TEXCOORD3.w;
    u_xlat1.x = u_xlat1.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.zw = u_xlat20.xy * u_xlat1.xx;
    u_xlat0 = u_xlat0 * vs_TEXCOORD3.wwww;
    u_xlat1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_1.x = texture(_CustomDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat10_1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD3.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vec2(u_xlat0.z * u_xlat1.x, u_xlat0.w * u_xlat1.x);
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat20.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_20 = texture(_CustomDepthTexture, u_xlat20.xy).x;
    u_xlat20.x = _ZBufferParams.z * u_xlat10_20 + _ZBufferParams.w;
    u_xlat20.x = float(1.0) / u_xlat20.x;
    u_xlat20.x = u_xlat20.x + (-vs_TEXCOORD3.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat20.x = min(max(u_xlat20.x, 0.0), 1.0);
#else
    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat20.xxx * u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat20.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD3.ww;
    u_xlat10_1.xyz = texture(_BeforeAlphaTexture, u_xlat1.xy).xyz;
    u_xlat10_20 = texture(_CustomDepthTexture, u_xlat20.xy).x;
    u_xlat20.x = _ZBufferParams.z * u_xlat10_20 + _ZBufferParams.w;
    u_xlat20.x = float(1.0) / u_xlat20.x;
    u_xlat20.x = u_xlat20.x + (-vs_TEXCOORD3.w);
    u_xlat30 = u_xlat20.x * _SSRDistortion_Shore;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat30) + vs_TEXCOORD3.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD3.ww;
    u_xlat10_0.xyw = texture(_ReflectionTex, u_xlat0.xy).xyz;
    u_xlat31 = 0.100000001 / _DeepColorDepth;
    u_xlat31 = u_xlat20.x * u_xlat31;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 9.99999975e-05);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _DeepColorFade;
    u_xlat31 = exp2(u_xlat31);
    u_xlat3.x = float(1.0) / _ShoreTransparency;
    u_xlat13 = u_xlat20.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat13 = max(u_xlat13, 9.99999975e-05);
    u_xlat13 = log2(u_xlat13);
    u_xlat13 = u_xlat13 * _ShoreFade;
    u_xlat13 = exp2(u_xlat13);
    u_xlat4.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = vec3(u_xlat13) * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = (-u_xlat4.xyz) * u_xlat10_1.xyz + _DeepColor.xyz;
    u_xlat6.xyz = u_xlat10_1.xyz * u_xlat4.xyz;
    u_xlat5.xyz = vec3(u_xlat31) * u_xlat5.xyz + u_xlat6.xyz;
    u_xlat0.xyw = u_xlat10_0.xyw + (-u_xlat5.xyz);
    u_xlat31 = float(1.0) / _ShoreReflectionFade;
    u_xlat31 = u_xlat20.x * u_xlat31;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_2.y = 1.0;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_7.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23);
    u_xlat8.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat9.xyz = vec3(u_xlat23) * u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23) + _ES_SunDirection.xyz;
    u_xlat23 = dot(u_xlat9.xyz, u_xlat16_7.xyz);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999975e-05);
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _FresnelPower;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = u_xlat23 * _ReflectionIntensity;
    u_xlat31 = u_xlat31 * u_xlat23;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat0.xyw = vec3(u_xlat31) * u_xlat0.xyw + u_xlat5.xyz;
    u_xlat0.xyw = (-u_xlat4.xyz) * u_xlat10_1.xyz + u_xlat0.xyw;
    u_xlat0.xyw = vec3(u_xlat13) * u_xlat0.xyw + u_xlat6.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = dot(u_xlat16_7.xyz, u_xlat1.xyz);
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat11 = _Gloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat11;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat31 = u_xlat20.x + -1.0;
    u_xlat31 = u_xlat3.x * u_xlat31;
    u_xlat31 = u_xlat31 * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.0>=_ES_SunDirection.y);
#else
    u_xlatb31 = 0.0>=_ES_SunDirection.y;
#endif
    u_xlat1.xyz = (bool(u_xlatb31)) ? vec3(0.0, 0.0, 0.0) : u_xlat1.xyz;
    u_xlat31 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * vs_TEXCOORD5.xyz;
    u_xlat31 = dot(u_xlat9.xyz, u_xlat3.xyz);
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat31 = max(u_xlat31, 9.99999975e-05);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _SpecularPower;
    u_xlat31 = exp2(u_xlat31);
    u_xlat0.xyw = u_xlat1.xyz * vec3(u_xlat31) + u_xlat0.xyw;
    u_xlat1.x = float(1.0) / _FoamFade;
    u_xlat1.x = u_xlat20.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = _Time.y * _FoamSpeed;
    u_xlat21.xy = vec2(u_xlat11) * vec2(-0.0480000004, 0.027999999);
    u_xlat3.xy = vs_TEXCOORD2.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat21.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat21.xy;
    u_xlat3.xy = vec2(u_xlat11) * vec2(0.0599999987, 0.0399999991) + u_xlat3.xy;
    u_xlat10_11 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat10_21 = texture(_FoamTexture, u_xlat21.xy).x;
    u_xlat16_21 = u_xlat10_21 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_21 * u_xlat10_11;
    u_xlat1.x = u_xlat1.x * u_xlat16_11;
    u_xlat11 = vs_TEXCOORD2.z + (-_ProjectionParams.y);
    u_xlat11 = u_xlat11 + (-_FoamFadeOffset);
    u_xlat11 = u_xlat11 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat11 * _FoamWidth;
    u_xlat11 = float(1.0) / u_xlat11;
    u_xlat20.x = u_xlat20.x * u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlat20.x = min(max(u_xlat20.x, 0.0), 1.0);
#else
    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
#endif
    u_xlat20.x = (-u_xlat20.x) + 1.0;
    u_xlat20.x = u_xlat20.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat20.xxx * _FoamColor.xyz + u_xlat0.xyw;
    u_xlat0.w = 0.100000001 / _OpacityByDepth;
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
CustomEditor "MiHoYoASEMaterialInspector"
}