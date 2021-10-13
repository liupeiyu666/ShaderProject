//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_DepthFade" {
Properties {
_MainTexture ("MainTexture", 2D) = "white" { }
_MainColor ("MainColor", Color) = (0,0,0,0)
_Opacity ("Opacity", Range(0, 1)) = 0
_DepthRange ("DepthRange", Float) = 0
_DepthTexture ("DepthTexture", 2D) = "white" { }
_DepthTextureColor ("DepthTextureColor", Color) = (0,0,0,0)
_DepthTextureIntensity ("DepthTextureIntensity", Float) = 1
_DepthColor ("DepthColor", Color) = (0,0,0,0)
_DepthColorIntensity ("DepthColorIntensity", Float) = 1
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 30174
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _Opacity;
uniform 	vec4 _DepthTexture_ST;
uniform 	float _DepthTextureIntensity;
uniform 	float _DepthColorIntensity;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _DepthTextureColor;
uniform 	vec4 _DepthColor;
uniform 	float _DepthRange;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _DepthTexture;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x / _DepthRange;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _DepthTexture_ST.xy + _DepthTexture_ST.zw;
    u_xlat10_2.xyz = texture(_DepthTexture, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _DepthTextureColor.xyz;
    u_xlat1.xyz = vec3(vec3(_DepthColorIntensity, _DepthColorIntensity, _DepthColorIntensity)) * _DepthColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_DepthTextureIntensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1.xyz = texture(_MainTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _MainColor.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _Opacity;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _Opacity;
uniform 	vec4 _DepthTexture_ST;
uniform 	float _DepthTextureIntensity;
uniform 	float _DepthColorIntensity;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _DepthTextureColor;
uniform 	vec4 _DepthColor;
uniform 	float _DepthRange;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _DepthTexture;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x / _DepthRange;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _DepthTexture_ST.xy + _DepthTexture_ST.zw;
    u_xlat10_2.xyz = texture(_DepthTexture, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _DepthTextureColor.xyz;
    u_xlat1.xyz = vec3(vec3(_DepthColorIntensity, _DepthColorIntensity, _DepthColorIntensity)) * _DepthColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_DepthTextureIntensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1.xyz = texture(_MainTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _MainColor.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _Opacity;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _Opacity;
uniform 	vec4 _DepthTexture_ST;
uniform 	float _DepthTextureIntensity;
uniform 	float _DepthColorIntensity;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _DepthTextureColor;
uniform 	vec4 _DepthColor;
uniform 	float _DepthRange;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _DepthTexture;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x / _DepthRange;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _DepthTexture_ST.xy + _DepthTexture_ST.zw;
    u_xlat10_2.xyz = texture(_DepthTexture, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _DepthTextureColor.xyz;
    u_xlat1.xyz = vec3(vec3(_DepthColorIntensity, _DepthColorIntensity, _DepthColorIntensity)) * _DepthColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_DepthTextureIntensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1.xyz = texture(_MainTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _MainColor.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _Opacity;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _Opacity;
uniform 	vec4 _DepthTexture_ST;
uniform 	float _DepthTextureIntensity;
uniform 	float _DepthColorIntensity;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _DepthTextureColor;
uniform 	vec4 _DepthColor;
uniform 	float _DepthRange;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _DepthTexture;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
float u_xlat6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x / _DepthRange;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _DepthTexture_ST.xy + _DepthTexture_ST.zw;
    u_xlat10_2.xyz = texture(_DepthTexture, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _DepthTextureColor.xyz;
    u_xlat1.xyz = vec3(vec3(_DepthColorIntensity, _DepthColorIntensity, _DepthColorIntensity)) * _DepthColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_DepthTextureIntensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1.xyz = texture(_MainTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _MainColor.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat6 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(u_xlat6);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _Opacity;
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
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _Opacity;
uniform 	vec4 _DepthTexture_ST;
uniform 	float _DepthTextureIntensity;
uniform 	float _DepthColorIntensity;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _DepthTextureColor;
uniform 	vec4 _DepthColor;
uniform 	float _DepthRange;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _DepthTexture;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
float u_xlat6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x / _DepthRange;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _DepthTexture_ST.xy + _DepthTexture_ST.zw;
    u_xlat10_2.xyz = texture(_DepthTexture, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _DepthTextureColor.xyz;
    u_xlat1.xyz = vec3(vec3(_DepthColorIntensity, _DepthColorIntensity, _DepthColorIntensity)) * _DepthColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_DepthTextureIntensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1.xyz = texture(_MainTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _MainColor.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat6 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(u_xlat6);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _Opacity;
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
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _Opacity;
uniform 	vec4 _DepthTexture_ST;
uniform 	float _DepthTextureIntensity;
uniform 	float _DepthColorIntensity;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _DepthTextureColor;
uniform 	vec4 _DepthColor;
uniform 	float _DepthRange;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _DepthTexture;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
float u_xlat6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_2.x = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x / _DepthRange;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _DepthTexture_ST.xy + _DepthTexture_ST.zw;
    u_xlat10_2.xyz = texture(_DepthTexture, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _DepthTextureColor.xyz;
    u_xlat1.xyz = vec3(vec3(_DepthColorIntensity, _DepthColorIntensity, _DepthColorIntensity)) * _DepthColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_DepthTextureIntensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1.xyz = texture(_MainTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _MainColor.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat6 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(u_xlat6);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _Opacity;
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
}
}
}
CustomEditor "ASEMaterialInspector"
}