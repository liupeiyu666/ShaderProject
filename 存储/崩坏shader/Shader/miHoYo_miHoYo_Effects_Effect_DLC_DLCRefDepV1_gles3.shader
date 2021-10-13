//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/DLCRefDepV1" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainColor ("MainColor", Color) = (0.9044118,0.9044118,0.9044118,0)
_ChromaticAberration ("ChromaticAberration", Range(-0.5, 0.5)) = 0.05
_ChromaticAberrationIndensity ("ChromaticAberrationIndensity", Float) = -20
_Opacity ("Opacity", Range(0, 1)) = 1
_FresnelPower ("Fresnel Power", Float) = 0
_FresnelScale ("Fresnel Scale", Float) = 0
_FresnelReFrection ("FresnelReFrection", Vector) = (0,1,5,0)
_DepthFadeTex ("DepthFadeTex", 2D) = "white" { }
_Depth ("Depth", Float) = 0.68
_DepthFadeColor1 ("DepthFadeColor1", Color) = (0,0.6542087,0.9779412,0)
_DepthFadeColor1Indensity ("DepthFadeColor1Indensity", Float) = 1
_DepthFadeColor2 ("DepthFadeColor2", Color) = (0.02205884,0.6358014,1,0)
_DepthFadeColor2Indensity ("DepthFadeColor2Indensity", Float) = 15
_RimColor ("RimColor", Color) = (0,0.462069,1,0)
_RimColorIndensity ("RimColorIndensity", Float) = 4
_DisTexture ("DisTexture", 2D) = "white" { }
_DisAmount ("DisAmount", Range(0, 2)) = 0
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 61501
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
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
float u_xlat7;
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
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD4.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _DisAmount;
uniform 	vec4 _DisTexture_ST;
uniform 	mediump float _Opacity;
uniform 	vec3 _FresnelReFrection;
uniform 	float _ChromaticAberration;
uniform 	float _ChromaticAberrationIndensity;
uniform 	vec4 _MainColor;
uniform 	float _FresnelScale;
uniform 	float _FresnelPower;
uniform 	vec4 _RimColor;
uniform 	float _RimColorIndensity;
uniform 	mediump float _Depth;
uniform 	mediump vec4 _DepthFadeColor1;
uniform 	float _DepthFadeColor1Indensity;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	mediump vec4 _DepthFadeColor2;
uniform 	float _DepthFadeColor2Indensity;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _DisTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp float u_xlat10_5;
float u_xlat8;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat4.x = u_xlat0.x * _FresnelReFrection.z;
    u_xlat0.x = u_xlat0.x * _FresnelPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelScale;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat1.x = _FresnelReFrection.y * u_xlat4.x + _FresnelReFrection.x;
    u_xlat4.x = vs_TEXCOORD5.w * 0.5;
    u_xlat8 = (-vs_TEXCOORD5.w) * 0.5 + vs_TEXCOORD5.y;
    u_xlat4.y = u_xlat8 * _ProjectionParams.x + u_xlat4.x;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat2.yz = u_xlat4.xy / vs_TEXCOORD5.ww;
    u_xlat2.x = u_xlat2.y + _ChromaticAberration;
    u_xlat3.xy = u_xlat1.xx + u_xlat2.xz;
    u_xlat1.y = float(0.0599999987);
    u_xlat1.z = float(0.0299999993);
    u_xlat3.z = u_xlat2.z;
    u_xlat4.xy = vec2(u_xlat1.x + u_xlat2.y, u_xlat1.x + u_xlat2.z);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat4.xy).xyz;
    u_xlat2 = u_xlat1.yxzx + u_xlat3.xzxz;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat3.xy).x;
    u_xlat5.x = (-u_xlat10_5) + 1.0;
    u_xlat1.x = u_xlat1.x * _ChromaticAberrationIndensity;
    u_xlat9.x = texture(_BeforeAlphaTexture, u_xlat2.xy).x;
    u_xlat9.y = texture(_BeforeAlphaTexture, u_xlat2.zw).x;
    u_xlat5.yz = (-u_xlat9.xy) + vec2(1.0, 1.0);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat10_4.xyz + u_xlat2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _RimColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_RimColorIndensity) + (-u_xlat4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vs_TEXCOORD6.zxy / vs_TEXCOORD6.www;
    u_xlat12 = texture(_CameraDepthTexture, u_xlat1.yz).x;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat12 = _ZBufferParams.z * u_xlat12 + _ZBufferParams.w;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = (-u_xlat1.x) + u_xlat12;
    u_xlat12 = u_xlat12 / _Depth;
    u_xlat12 = abs(u_xlat12) + 2.6400001;
    u_xlat12 = u_xlat12 * -0.222717166 + 1.0;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_1.xyz = texture(_DepthFadeTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = _DepthFadeColor2.xyz * vec3(_DepthFadeColor2Indensity) + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = _DepthFadeColor1.xyz * vec3(_DepthFadeColor1Indensity);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    u_xlat0.x = texture(_DisTexture, u_xlat0.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_DisAmount);
#else
    u_xlatb0 = u_xlat0.x>=_DisAmount;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    SV_Target0.w = u_xlat0.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
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
float u_xlat7;
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
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD4.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _DisAmount;
uniform 	vec4 _DisTexture_ST;
uniform 	mediump float _Opacity;
uniform 	vec3 _FresnelReFrection;
uniform 	float _ChromaticAberration;
uniform 	float _ChromaticAberrationIndensity;
uniform 	vec4 _MainColor;
uniform 	float _FresnelScale;
uniform 	float _FresnelPower;
uniform 	vec4 _RimColor;
uniform 	float _RimColorIndensity;
uniform 	mediump float _Depth;
uniform 	mediump vec4 _DepthFadeColor1;
uniform 	float _DepthFadeColor1Indensity;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	mediump vec4 _DepthFadeColor2;
uniform 	float _DepthFadeColor2Indensity;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _DisTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp float u_xlat10_5;
float u_xlat8;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat4.x = u_xlat0.x * _FresnelReFrection.z;
    u_xlat0.x = u_xlat0.x * _FresnelPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelScale;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat1.x = _FresnelReFrection.y * u_xlat4.x + _FresnelReFrection.x;
    u_xlat4.x = vs_TEXCOORD5.w * 0.5;
    u_xlat8 = (-vs_TEXCOORD5.w) * 0.5 + vs_TEXCOORD5.y;
    u_xlat4.y = u_xlat8 * _ProjectionParams.x + u_xlat4.x;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat2.yz = u_xlat4.xy / vs_TEXCOORD5.ww;
    u_xlat2.x = u_xlat2.y + _ChromaticAberration;
    u_xlat3.xy = u_xlat1.xx + u_xlat2.xz;
    u_xlat1.y = float(0.0599999987);
    u_xlat1.z = float(0.0299999993);
    u_xlat3.z = u_xlat2.z;
    u_xlat4.xy = vec2(u_xlat1.x + u_xlat2.y, u_xlat1.x + u_xlat2.z);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat4.xy).xyz;
    u_xlat2 = u_xlat1.yxzx + u_xlat3.xzxz;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat3.xy).x;
    u_xlat5.x = (-u_xlat10_5) + 1.0;
    u_xlat1.x = u_xlat1.x * _ChromaticAberrationIndensity;
    u_xlat9.x = texture(_BeforeAlphaTexture, u_xlat2.xy).x;
    u_xlat9.y = texture(_BeforeAlphaTexture, u_xlat2.zw).x;
    u_xlat5.yz = (-u_xlat9.xy) + vec2(1.0, 1.0);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat10_4.xyz + u_xlat2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _RimColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_RimColorIndensity) + (-u_xlat4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vs_TEXCOORD6.zxy / vs_TEXCOORD6.www;
    u_xlat12 = texture(_CameraDepthTexture, u_xlat1.yz).x;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat12 = _ZBufferParams.z * u_xlat12 + _ZBufferParams.w;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = (-u_xlat1.x) + u_xlat12;
    u_xlat12 = u_xlat12 / _Depth;
    u_xlat12 = abs(u_xlat12) + 2.6400001;
    u_xlat12 = u_xlat12 * -0.222717166 + 1.0;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_1.xyz = texture(_DepthFadeTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = _DepthFadeColor2.xyz * vec3(_DepthFadeColor2Indensity) + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = _DepthFadeColor1.xyz * vec3(_DepthFadeColor1Indensity);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    u_xlat0.x = texture(_DisTexture, u_xlat0.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_DisAmount);
#else
    u_xlatb0 = u_xlat0.x>=_DisAmount;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    SV_Target0.w = u_xlat0.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
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
float u_xlat7;
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
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD4.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _DisAmount;
uniform 	vec4 _DisTexture_ST;
uniform 	mediump float _Opacity;
uniform 	vec3 _FresnelReFrection;
uniform 	float _ChromaticAberration;
uniform 	float _ChromaticAberrationIndensity;
uniform 	vec4 _MainColor;
uniform 	float _FresnelScale;
uniform 	float _FresnelPower;
uniform 	vec4 _RimColor;
uniform 	float _RimColorIndensity;
uniform 	mediump float _Depth;
uniform 	mediump vec4 _DepthFadeColor1;
uniform 	float _DepthFadeColor1Indensity;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	mediump vec4 _DepthFadeColor2;
uniform 	float _DepthFadeColor2Indensity;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _DisTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp float u_xlat10_5;
float u_xlat8;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat4.x = u_xlat0.x * _FresnelReFrection.z;
    u_xlat0.x = u_xlat0.x * _FresnelPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelScale;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat1.x = _FresnelReFrection.y * u_xlat4.x + _FresnelReFrection.x;
    u_xlat4.x = vs_TEXCOORD5.w * 0.5;
    u_xlat8 = (-vs_TEXCOORD5.w) * 0.5 + vs_TEXCOORD5.y;
    u_xlat4.y = u_xlat8 * _ProjectionParams.x + u_xlat4.x;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat2.yz = u_xlat4.xy / vs_TEXCOORD5.ww;
    u_xlat2.x = u_xlat2.y + _ChromaticAberration;
    u_xlat3.xy = u_xlat1.xx + u_xlat2.xz;
    u_xlat1.y = float(0.0599999987);
    u_xlat1.z = float(0.0299999993);
    u_xlat3.z = u_xlat2.z;
    u_xlat4.xy = vec2(u_xlat1.x + u_xlat2.y, u_xlat1.x + u_xlat2.z);
    u_xlat10_4.xyz = texture(_BeforeAlphaTexture, u_xlat4.xy).xyz;
    u_xlat2 = u_xlat1.yxzx + u_xlat3.xzxz;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat3.xy).x;
    u_xlat5.x = (-u_xlat10_5) + 1.0;
    u_xlat1.x = u_xlat1.x * _ChromaticAberrationIndensity;
    u_xlat9.x = texture(_BeforeAlphaTexture, u_xlat2.xy).x;
    u_xlat9.y = texture(_BeforeAlphaTexture, u_xlat2.zw).x;
    u_xlat5.yz = (-u_xlat9.xy) + vec2(1.0, 1.0);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat10_4.xyz + u_xlat2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _RimColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_RimColorIndensity) + (-u_xlat4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vs_TEXCOORD6.zxy / vs_TEXCOORD6.www;
    u_xlat12 = texture(_CameraDepthTexture, u_xlat1.yz).x;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat12 = _ZBufferParams.z * u_xlat12 + _ZBufferParams.w;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = (-u_xlat1.x) + u_xlat12;
    u_xlat12 = u_xlat12 / _Depth;
    u_xlat12 = abs(u_xlat12) + 2.6400001;
    u_xlat12 = u_xlat12 * -0.222717166 + 1.0;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_1.xyz = texture(_DepthFadeTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = _DepthFadeColor2.xyz * vec3(_DepthFadeColor2Indensity) + u_xlat10_1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = _DepthFadeColor1.xyz * vec3(_DepthFadeColor1Indensity);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    u_xlat0.x = texture(_DisTexture, u_xlat0.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_DisAmount);
#else
    u_xlatb0 = u_xlat0.x>=_DisAmount;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    SV_Target0.w = u_xlat0.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
 Pass {
  Name "CONSTANT_MAX"
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 80412
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
""
}
}
}
}
CustomEditor "ASEMaterialInspector"
}