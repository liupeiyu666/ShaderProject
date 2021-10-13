//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/Ice" {
Properties {
_Highlight_Color ("Highlight_Color", Color) = (0.7334559,0.8970082,0.9779412,1)
_Fresnal_Scale ("Fresnal_Scale", Float) = 6.97
_Fresnal_Power ("Fresnal_Power", Float) = 5.68
_IceLightColor ("IceLightColor", Color) = (0.5073529,0.9692103,1,1)
_IceDarkColor ("IceDarkColor", Color) = (0.1098039,0.1686275,0.172549,1)
_CubeMap ("CubeMap", Cube) = "white" { }
_CubeMapBrightness ("CubeMapBrightness", Float) = 1
_MatCapTex ("MatCapTex", 2D) = "white" { }
_MatCapSize ("MatCapSize", Range(0, 2)) = 1
_MatCapColor ("MatCapColor", Color) = (1,1,1,1)
_NormalMap ("NormalMap", 2D) = "white" { }
_NormalIntensity ("NormalIntensity", Color) = (1,1,0.916,1)
[Toggle(_GRADIENTCOLORTOGGLE_ON)] _GradientColorToggle ("GradientColorToggle", Float) = 0
_GradientColor ("GradientColor", Color) = (0.2352941,0.4304256,1,0)
_GradientRange ("GradientRange", Float) = 1
_GradientOffset ("GradientOffset", Float) = 0
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
  GpuProgramID 8818
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat14;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0 = 0.0<_GradientColorToggle;
#endif
    u_xlat7 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat14.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat2.xyz = u_xlat14.xxx * vs_TEXCOORD3.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat14.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = u_xlat16_5.xyz * _NormalIntensity.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat6.y = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.xy = vec2(u_xlat21) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat14.xx + u_xlat3.xy;
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat6.z = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat23 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat23) + u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat14.xy * vec2(0.5, 0.5);
    u_xlat10_3.xyz = texture(_MatCapTex, u_xlat14.xy).xyz;
    u_xlat14.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat4.xyz = u_xlat6.xyz * (-u_xlat14.xxx) + (-u_xlat2.xyz);
    u_xlat14.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat14.x = (-u_xlat14.x) + 1.0;
    u_xlat14.x = max(u_xlat14.x, 9.99999975e-05);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat10_21 = texture(_CubeMap, u_xlat2.xyz).x;
    u_xlat21 = u_xlat10_21 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat21) * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat2 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat2 = vec4(u_xlat7) * u_xlat2 + u_xlat1.yyzw;
    u_xlat1 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
    u_xlat0.x = u_xlat14.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = _Highlight_Color.xxyz * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat10_3.xxyz * _MatCapColor.xxyz + u_xlat0;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat14;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0 = 0.0<_GradientColorToggle;
#endif
    u_xlat7 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat14.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat2.xyz = u_xlat14.xxx * vs_TEXCOORD3.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat14.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = u_xlat16_5.xyz * _NormalIntensity.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat6.y = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.xy = vec2(u_xlat21) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat14.xx + u_xlat3.xy;
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat6.z = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat23 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat23) + u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat14.xy * vec2(0.5, 0.5);
    u_xlat10_3.xyz = texture(_MatCapTex, u_xlat14.xy).xyz;
    u_xlat14.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat4.xyz = u_xlat6.xyz * (-u_xlat14.xxx) + (-u_xlat2.xyz);
    u_xlat14.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat14.x = (-u_xlat14.x) + 1.0;
    u_xlat14.x = max(u_xlat14.x, 9.99999975e-05);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat10_21 = texture(_CubeMap, u_xlat2.xyz).x;
    u_xlat21 = u_xlat10_21 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat21) * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat2 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat2 = vec4(u_xlat7) * u_xlat2 + u_xlat1.yyzw;
    u_xlat1 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
    u_xlat0.x = u_xlat14.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = _Highlight_Color.xxyz * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat10_3.xxyz * _MatCapColor.xxyz + u_xlat0;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat14;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0 = 0.0<_GradientColorToggle;
#endif
    u_xlat7 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat14.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat2.xyz = u_xlat14.xxx * vs_TEXCOORD3.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat14.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = u_xlat16_5.xyz * _NormalIntensity.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat6.y = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.xy = vec2(u_xlat21) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat14.xx + u_xlat3.xy;
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat6.z = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat23 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat23) + u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat14.xy * vec2(0.5, 0.5);
    u_xlat10_3.xyz = texture(_MatCapTex, u_xlat14.xy).xyz;
    u_xlat14.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat4.xyz = u_xlat6.xyz * (-u_xlat14.xxx) + (-u_xlat2.xyz);
    u_xlat14.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat14.x = (-u_xlat14.x) + 1.0;
    u_xlat14.x = max(u_xlat14.x, 9.99999975e-05);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat10_21 = texture(_CubeMap, u_xlat2.xyz).x;
    u_xlat21 = u_xlat10_21 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat21) * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat2 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat2 = vec4(u_xlat7) * u_xlat2 + u_xlat1.yyzw;
    u_xlat1 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
    u_xlat0.x = u_xlat14.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = _Highlight_Color.xxyz * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat10_3.xxyz * _MatCapColor.xxyz + u_xlat0;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD3.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat14;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0 = 0.0<_GradientColorToggle;
#endif
    u_xlat7 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat14.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat2.xyz = u_xlat14.xxx * vs_TEXCOORD3.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat14.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = u_xlat16_5.xyz * _NormalIntensity.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat6.y = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.xy = vec2(u_xlat21) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat14.xx + u_xlat3.xy;
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat6.z = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat23 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat23) + u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat14.xy * vec2(0.5, 0.5);
    u_xlat10_3.xyz = texture(_MatCapTex, u_xlat14.xy).xyz;
    u_xlat14.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat4.xyz = u_xlat6.xyz * (-u_xlat14.xxx) + (-u_xlat2.xyz);
    u_xlat14.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat14.x = (-u_xlat14.x) + 1.0;
    u_xlat14.x = max(u_xlat14.x, 9.99999975e-05);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat10_21 = texture(_CubeMap, u_xlat2.xyz).x;
    u_xlat21 = u_xlat10_21 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat21) * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat2 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat2 = vec4(u_xlat7) * u_xlat2 + u_xlat1.yyzw;
    u_xlat1 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
    u_xlat0.x = u_xlat14.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = _Highlight_Color.xxyz * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat10_3.xxyz * _MatCapColor.xxyz + u_xlat0;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD3.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat14;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0 = 0.0<_GradientColorToggle;
#endif
    u_xlat7 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat14.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat2.xyz = u_xlat14.xxx * vs_TEXCOORD3.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat14.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = u_xlat16_5.xyz * _NormalIntensity.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat6.y = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.xy = vec2(u_xlat21) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat14.xx + u_xlat3.xy;
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat6.z = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat23 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat23) + u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat14.xy * vec2(0.5, 0.5);
    u_xlat10_3.xyz = texture(_MatCapTex, u_xlat14.xy).xyz;
    u_xlat14.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat4.xyz = u_xlat6.xyz * (-u_xlat14.xxx) + (-u_xlat2.xyz);
    u_xlat14.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat14.x = (-u_xlat14.x) + 1.0;
    u_xlat14.x = max(u_xlat14.x, 9.99999975e-05);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat10_21 = texture(_CubeMap, u_xlat2.xyz).x;
    u_xlat21 = u_xlat10_21 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat21) * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat2 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat2 = vec4(u_xlat7) * u_xlat2 + u_xlat1.yyzw;
    u_xlat1 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
    u_xlat0.x = u_xlat14.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = _Highlight_Color.xxyz * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat10_3.xxyz * _MatCapColor.xxyz + u_xlat0;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD3.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat14;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0 = 0.0<_GradientColorToggle;
#endif
    u_xlat7 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat14.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat2.xyz = u_xlat14.xxx * vs_TEXCOORD3.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat14.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = u_xlat16_5.xyz * _NormalIntensity.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat6.y = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.xy = vec2(u_xlat21) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat14.xx + u_xlat3.xy;
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat6.z = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat23 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat23) + u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat14.xy * vec2(0.5, 0.5);
    u_xlat10_3.xyz = texture(_MatCapTex, u_xlat14.xy).xyz;
    u_xlat14.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat4.xyz = u_xlat6.xyz * (-u_xlat14.xxx) + (-u_xlat2.xyz);
    u_xlat14.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat14.x = (-u_xlat14.x) + 1.0;
    u_xlat14.x = max(u_xlat14.x, 9.99999975e-05);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat10_21 = texture(_CubeMap, u_xlat2.xyz).x;
    u_xlat21 = u_xlat10_21 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat21) * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat2 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat2 = vec4(u_xlat7) * u_xlat2 + u_xlat1.yyzw;
    u_xlat1 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
    u_xlat0.x = u_xlat14.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = _Highlight_Color.xxyz * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat10_3.xxyz * _MatCapColor.xxyz + u_xlat0;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat14;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0 = 0.0<_GradientColorToggle;
#endif
    u_xlat7 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat14.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat2.xyz = u_xlat14.xxx * vs_TEXCOORD3.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat14.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = u_xlat16_5.xyz * _NormalIntensity.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat6.y = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.xy = vec2(u_xlat21) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat14.xx + u_xlat3.xy;
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat6.z = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat23 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat23) + u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat14.xy * vec2(0.5, 0.5);
    u_xlat10_3.xyz = texture(_MatCapTex, u_xlat14.xy).xyz;
    u_xlat14.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat4.xyz = u_xlat6.xyz * (-u_xlat14.xxx) + (-u_xlat2.xyz);
    u_xlat14.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat14.x = (-u_xlat14.x) + 1.0;
    u_xlat14.x = max(u_xlat14.x, 9.99999975e-05);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat10_21 = texture(_CubeMap, u_xlat2.xyz).x;
    u_xlat21 = u_xlat10_21 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat21) * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat2 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat2 = vec4(u_xlat7) * u_xlat2 + u_xlat1.yyzw;
    u_xlat1 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
    u_xlat0.x = u_xlat14.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = _Highlight_Color.xxyz * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat10_3.xxyz * _MatCapColor.xxyz + u_xlat0;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat14;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0 = 0.0<_GradientColorToggle;
#endif
    u_xlat7 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat14.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat2.xyz = u_xlat14.xxx * vs_TEXCOORD3.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat14.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = u_xlat16_5.xyz * _NormalIntensity.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat6.y = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.xy = vec2(u_xlat21) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat14.xx + u_xlat3.xy;
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat6.z = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat23 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat23) + u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat14.xy * vec2(0.5, 0.5);
    u_xlat10_3.xyz = texture(_MatCapTex, u_xlat14.xy).xyz;
    u_xlat14.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat4.xyz = u_xlat6.xyz * (-u_xlat14.xxx) + (-u_xlat2.xyz);
    u_xlat14.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat14.x = (-u_xlat14.x) + 1.0;
    u_xlat14.x = max(u_xlat14.x, 9.99999975e-05);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat10_21 = texture(_CubeMap, u_xlat2.xyz).x;
    u_xlat21 = u_xlat10_21 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat21) * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat2 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat2 = vec4(u_xlat7) * u_xlat2 + u_xlat1.yyzw;
    u_xlat1 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
    u_xlat0.x = u_xlat14.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = _Highlight_Color.xxyz * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat10_3.xxyz * _MatCapColor.xxyz + u_xlat0;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat14;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0 = 0.0<_GradientColorToggle;
#endif
    u_xlat7 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat14.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat2.xyz = u_xlat14.xxx * vs_TEXCOORD3.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat14.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = u_xlat16_5.xyz * _NormalIntensity.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat6.y = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.xy = vec2(u_xlat21) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat14.xx + u_xlat3.xy;
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat6.z = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat23 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat23) + u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat14.xy * vec2(0.5, 0.5);
    u_xlat10_3.xyz = texture(_MatCapTex, u_xlat14.xy).xyz;
    u_xlat14.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat4.xyz = u_xlat6.xyz * (-u_xlat14.xxx) + (-u_xlat2.xyz);
    u_xlat14.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat14.x = (-u_xlat14.x) + 1.0;
    u_xlat14.x = max(u_xlat14.x, 9.99999975e-05);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat10_21 = texture(_CubeMap, u_xlat2.xyz).x;
    u_xlat21 = u_xlat10_21 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat21) * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat2 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat2 = vec4(u_xlat7) * u_xlat2 + u_xlat1.yyzw;
    u_xlat1 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
    u_xlat0.x = u_xlat14.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = _Highlight_Color.xxyz * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat10_3.xxyz * _MatCapColor.xxyz + u_xlat0;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD3.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat14;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0 = 0.0<_GradientColorToggle;
#endif
    u_xlat7 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat14.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat2.xyz = u_xlat14.xxx * vs_TEXCOORD3.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat14.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = u_xlat16_5.xyz * _NormalIntensity.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat6.y = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.xy = vec2(u_xlat21) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat14.xx + u_xlat3.xy;
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat6.z = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat23 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat23) + u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat14.xy * vec2(0.5, 0.5);
    u_xlat10_3.xyz = texture(_MatCapTex, u_xlat14.xy).xyz;
    u_xlat14.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat4.xyz = u_xlat6.xyz * (-u_xlat14.xxx) + (-u_xlat2.xyz);
    u_xlat14.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat14.x = (-u_xlat14.x) + 1.0;
    u_xlat14.x = max(u_xlat14.x, 9.99999975e-05);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat10_21 = texture(_CubeMap, u_xlat2.xyz).x;
    u_xlat21 = u_xlat10_21 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat21) * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat2 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat2 = vec4(u_xlat7) * u_xlat2 + u_xlat1.yyzw;
    u_xlat1 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
    u_xlat0.x = u_xlat14.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = _Highlight_Color.xxyz * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat10_3.xxyz * _MatCapColor.xxyz + u_xlat0;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD3.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat14;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0 = 0.0<_GradientColorToggle;
#endif
    u_xlat7 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat14.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat2.xyz = u_xlat14.xxx * vs_TEXCOORD3.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat14.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = u_xlat16_5.xyz * _NormalIntensity.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat6.y = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.xy = vec2(u_xlat21) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat14.xx + u_xlat3.xy;
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat6.z = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat23 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat23) + u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat14.xy * vec2(0.5, 0.5);
    u_xlat10_3.xyz = texture(_MatCapTex, u_xlat14.xy).xyz;
    u_xlat14.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat4.xyz = u_xlat6.xyz * (-u_xlat14.xxx) + (-u_xlat2.xyz);
    u_xlat14.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat14.x = (-u_xlat14.x) + 1.0;
    u_xlat14.x = max(u_xlat14.x, 9.99999975e-05);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat10_21 = texture(_CubeMap, u_xlat2.xyz).x;
    u_xlat21 = u_xlat10_21 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat21) * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat2 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat2 = vec4(u_xlat7) * u_xlat2 + u_xlat1.yyzw;
    u_xlat1 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
    u_xlat0.x = u_xlat14.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = _Highlight_Color.xxyz * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat10_3.xxyz * _MatCapColor.xxyz + u_xlat0;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD3.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat14;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0 = 0.0<_GradientColorToggle;
#endif
    u_xlat7 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat14.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat2.xyz = u_xlat14.xxx * vs_TEXCOORD3.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat14.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat14.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = u_xlat16_5.xyz * _NormalIntensity.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat6.y = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat3.xy = vec2(u_xlat21) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat14.xx + u_xlat3.xy;
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat6.z = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat23 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat14.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat23) + u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat14.xy * vec2(0.5, 0.5);
    u_xlat10_3.xyz = texture(_MatCapTex, u_xlat14.xy).xyz;
    u_xlat14.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
    u_xlat14.x = u_xlat14.x + u_xlat14.x;
    u_xlat4.xyz = u_xlat6.xyz * (-u_xlat14.xxx) + (-u_xlat2.xyz);
    u_xlat14.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat14.x = (-u_xlat14.x) + 1.0;
    u_xlat14.x = max(u_xlat14.x, 9.99999975e-05);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat10_21 = texture(_CubeMap, u_xlat2.xyz).x;
    u_xlat21 = u_xlat10_21 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat21) * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat2 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat2 = vec4(u_xlat7) * u_xlat2 + u_xlat1.yyzw;
    u_xlat1 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
    u_xlat0.x = u_xlat14.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * u_xlat14.x;
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = _Highlight_Color.xxyz * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat10_3.xxyz * _MatCapColor.xxyz + u_xlat0;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD4.y;
    u_xlat5.y = vs_TEXCOORD6.y;
    u_xlat5.z = vs_TEXCOORD5.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD4.z;
    u_xlat6.y = vs_TEXCOORD6.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat1.x = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0.x = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0.x * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat0.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat4 = u_xlat0.xxxx * u_xlat4 + u_xlat1.yyzw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0.x = 0.0<_GradientColorToggle;
#endif
    u_xlat1 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat14 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat3.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat14) + u_xlat0.xy;
    u_xlat14 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _Fresnal_Power;
    u_xlat14 = exp2(u_xlat14);
    u_xlat1 = _Highlight_Color.xxyz * vec4(u_xlat14) + u_xlat1;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCapTex, u_xlat0.xy).xyz;
    u_xlat0 = u_xlat10_0.xxyz * _MatCapColor.xxyz + u_xlat1;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD4.y;
    u_xlat5.y = vs_TEXCOORD6.y;
    u_xlat5.z = vs_TEXCOORD5.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD4.z;
    u_xlat6.y = vs_TEXCOORD6.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat1.x = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0.x = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0.x * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat0.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat4 = u_xlat0.xxxx * u_xlat4 + u_xlat1.yyzw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0.x = 0.0<_GradientColorToggle;
#endif
    u_xlat1 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat14 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat3.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat14) + u_xlat0.xy;
    u_xlat14 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _Fresnal_Power;
    u_xlat14 = exp2(u_xlat14);
    u_xlat1 = _Highlight_Color.xxyz * vec4(u_xlat14) + u_xlat1;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCapTex, u_xlat0.xy).xyz;
    u_xlat0 = u_xlat10_0.xxyz * _MatCapColor.xxyz + u_xlat1;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD4.y;
    u_xlat5.y = vs_TEXCOORD6.y;
    u_xlat5.z = vs_TEXCOORD5.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD4.z;
    u_xlat6.y = vs_TEXCOORD6.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat1.x = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0.x = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0.x * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat0.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat4 = u_xlat0.xxxx * u_xlat4 + u_xlat1.yyzw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0.x = 0.0<_GradientColorToggle;
#endif
    u_xlat1 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat14 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat3.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat14) + u_xlat0.xy;
    u_xlat14 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _Fresnal_Power;
    u_xlat14 = exp2(u_xlat14);
    u_xlat1 = _Highlight_Color.xxyz * vec4(u_xlat14) + u_xlat1;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCapTex, u_xlat0.xy).xyz;
    u_xlat0 = u_xlat10_0.xxyz * _MatCapColor.xxyz + u_xlat1;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD3.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD4.y;
    u_xlat5.y = vs_TEXCOORD6.y;
    u_xlat5.z = vs_TEXCOORD5.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD4.z;
    u_xlat6.y = vs_TEXCOORD6.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat1.x = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0.x = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0.x * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat0.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat4 = u_xlat0.xxxx * u_xlat4 + u_xlat1.yyzw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0.x = 0.0<_GradientColorToggle;
#endif
    u_xlat1 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat14 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat3.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat14) + u_xlat0.xy;
    u_xlat14 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _Fresnal_Power;
    u_xlat14 = exp2(u_xlat14);
    u_xlat1 = _Highlight_Color.xxyz * vec4(u_xlat14) + u_xlat1;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCapTex, u_xlat0.xy).xyz;
    u_xlat0 = u_xlat10_0.xxyz * _MatCapColor.xxyz + u_xlat1;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD3.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD4.y;
    u_xlat5.y = vs_TEXCOORD6.y;
    u_xlat5.z = vs_TEXCOORD5.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD4.z;
    u_xlat6.y = vs_TEXCOORD6.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat1.x = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0.x = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0.x * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat0.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat4 = u_xlat0.xxxx * u_xlat4 + u_xlat1.yyzw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0.x = 0.0<_GradientColorToggle;
#endif
    u_xlat1 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat14 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat3.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat14) + u_xlat0.xy;
    u_xlat14 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _Fresnal_Power;
    u_xlat14 = exp2(u_xlat14);
    u_xlat1 = _Highlight_Color.xxyz * vec4(u_xlat14) + u_xlat1;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCapTex, u_xlat0.xy).xyz;
    u_xlat0 = u_xlat10_0.xxyz * _MatCapColor.xxyz + u_xlat1;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD3.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD4.y;
    u_xlat5.y = vs_TEXCOORD6.y;
    u_xlat5.z = vs_TEXCOORD5.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD4.z;
    u_xlat6.y = vs_TEXCOORD6.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat1.x = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0.x = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0.x * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat0.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat4 = u_xlat0.xxxx * u_xlat4 + u_xlat1.yyzw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0.x = 0.0<_GradientColorToggle;
#endif
    u_xlat1 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat14 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat3.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat14) + u_xlat0.xy;
    u_xlat14 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _Fresnal_Power;
    u_xlat14 = exp2(u_xlat14);
    u_xlat1 = _Highlight_Color.xxyz * vec4(u_xlat14) + u_xlat1;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCapTex, u_xlat0.xy).xyz;
    u_xlat0 = u_xlat10_0.xxyz * _MatCapColor.xxyz + u_xlat1;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD4.y;
    u_xlat5.y = vs_TEXCOORD6.y;
    u_xlat5.z = vs_TEXCOORD5.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD4.z;
    u_xlat6.y = vs_TEXCOORD6.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat1.x = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0.x = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0.x * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat0.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat4 = u_xlat0.xxxx * u_xlat4 + u_xlat1.yyzw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0.x = 0.0<_GradientColorToggle;
#endif
    u_xlat1 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat14 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat3.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat14) + u_xlat0.xy;
    u_xlat14 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _Fresnal_Power;
    u_xlat14 = exp2(u_xlat14);
    u_xlat1 = _Highlight_Color.xxyz * vec4(u_xlat14) + u_xlat1;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCapTex, u_xlat0.xy).xyz;
    u_xlat0 = u_xlat10_0.xxyz * _MatCapColor.xxyz + u_xlat1;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD4.y;
    u_xlat5.y = vs_TEXCOORD6.y;
    u_xlat5.z = vs_TEXCOORD5.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD4.z;
    u_xlat6.y = vs_TEXCOORD6.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat1.x = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0.x = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0.x * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat0.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat4 = u_xlat0.xxxx * u_xlat4 + u_xlat1.yyzw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0.x = 0.0<_GradientColorToggle;
#endif
    u_xlat1 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat14 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat3.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat14) + u_xlat0.xy;
    u_xlat14 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _Fresnal_Power;
    u_xlat14 = exp2(u_xlat14);
    u_xlat1 = _Highlight_Color.xxyz * vec4(u_xlat14) + u_xlat1;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCapTex, u_xlat0.xy).xyz;
    u_xlat0 = u_xlat10_0.xxyz * _MatCapColor.xxyz + u_xlat1;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD4.y;
    u_xlat5.y = vs_TEXCOORD6.y;
    u_xlat5.z = vs_TEXCOORD5.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD4.z;
    u_xlat6.y = vs_TEXCOORD6.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat1.x = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0.x = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0.x * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat0.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat4 = u_xlat0.xxxx * u_xlat4 + u_xlat1.yyzw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0.x = 0.0<_GradientColorToggle;
#endif
    u_xlat1 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat14 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat3.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat14) + u_xlat0.xy;
    u_xlat14 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _Fresnal_Power;
    u_xlat14 = exp2(u_xlat14);
    u_xlat1 = _Highlight_Color.xxyz * vec4(u_xlat14) + u_xlat1;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCapTex, u_xlat0.xy).xyz;
    u_xlat0 = u_xlat10_0.xxyz * _MatCapColor.xxyz + u_xlat1;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD3.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD4.y;
    u_xlat5.y = vs_TEXCOORD6.y;
    u_xlat5.z = vs_TEXCOORD5.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD4.z;
    u_xlat6.y = vs_TEXCOORD6.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat1.x = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0.x = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0.x * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat0.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat4 = u_xlat0.xxxx * u_xlat4 + u_xlat1.yyzw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0.x = 0.0<_GradientColorToggle;
#endif
    u_xlat1 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat14 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat3.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat14) + u_xlat0.xy;
    u_xlat14 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _Fresnal_Power;
    u_xlat14 = exp2(u_xlat14);
    u_xlat1 = _Highlight_Color.xxyz * vec4(u_xlat14) + u_xlat1;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCapTex, u_xlat0.xy).xyz;
    u_xlat0 = u_xlat10_0.xxyz * _MatCapColor.xxyz + u_xlat1;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD3.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD4.y;
    u_xlat5.y = vs_TEXCOORD6.y;
    u_xlat5.z = vs_TEXCOORD5.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD4.z;
    u_xlat6.y = vs_TEXCOORD6.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat1.x = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0.x = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0.x * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat0.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat4 = u_xlat0.xxxx * u_xlat4 + u_xlat1.yyzw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0.x = 0.0<_GradientColorToggle;
#endif
    u_xlat1 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat14 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat3.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat14) + u_xlat0.xy;
    u_xlat14 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _Fresnal_Power;
    u_xlat14 = exp2(u_xlat14);
    u_xlat1 = _Highlight_Color.xxyz * vec4(u_xlat14) + u_xlat1;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCapTex, u_xlat0.xy).xyz;
    u_xlat0 = u_xlat10_0.xxyz * _MatCapColor.xxyz + u_xlat1;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD3.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _GradientColorToggle;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD4.x;
    u_xlat3.y = vs_TEXCOORD6.x;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD4.y;
    u_xlat5.y = vs_TEXCOORD6.y;
    u_xlat5.z = vs_TEXCOORD5.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD4.z;
    u_xlat6.y = vs_TEXCOORD6.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat1.x = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0.x = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0.x * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = (-_IceDarkColor.xxyz) + _IceLightColor.xxyz;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + _IceDarkColor.xxyz;
    u_xlat0.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _GradientColor.xxyz * u_xlat1.yyzw + (-u_xlat1.yyzw);
    u_xlat4 = u_xlat0.xxxx * u_xlat4 + u_xlat1.yyzw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_GradientColorToggle);
#else
    u_xlatb0.x = 0.0<_GradientColorToggle;
#endif
    u_xlat1 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat14 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat3.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat14) + u_xlat0.xy;
    u_xlat14 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _Fresnal_Power;
    u_xlat14 = exp2(u_xlat14);
    u_xlat1 = _Highlight_Color.xxyz * vec4(u_xlat14) + u_xlat1;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCapTex, u_xlat0.xy).xyz;
    u_xlat0 = u_xlat10_0.xxyz * _MatCapColor.xxyz + u_xlat1;
    u_xlat0 = u_xlat0 * _DayColor.wxyz;
    u_xlat0 = u_xlat0 * vs_COLOR0.wxyz;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.yzw;
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
}
CustomEditor "MiHoYoASEMaterialInspector"
}