//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Terrain_Weather_LightMap (Reflecting Light)" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_Splat0Tex ("Splat0 Tex (RGB)", 2D) = "black" { }
_Splat1Tex ("Splat1 Tex (RGB)", 2D) = "black" { }
_Splat2Tex ("Splat2 Tex (RGB)", 2D) = "black" { }
_Splat3Tex ("Splat2 Tex (RGB)", 2D) = "black" { }
_ControlTex ("Control Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
[Toggle(USINGRIMGLOW)] _UsingRimGlow ("Using Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
_RGControlTexRRatio ("Rim Glow R Channel Ratio Of Control Tex", Range(0, 1)) = 1
_RGControlTexGRatio ("Rim Glow G Channel Ratio Of Control Tex", Range(0, 1)) = 1
_RGControlTexBRatio ("Rim Glow B Channel Ratio Of Control Tex", Range(0, 1)) = 1
_RGControlTexARatio ("Rim Glow A Channel Ratio Of Control Tex", Range(0, 1)) = 1
_ReflectionTex ("Reflection", 2D) = "black" { }
_ReflectMaskTex ("Reflect Mask Tex(R)", 2D) = "white" { }
_ReflectionEmissionAdjust ("Reflection Emission Adjust", Float) = 1
_FresnelParams ("Fresnel Parameters", Vector) = (1,1,0,0)
_MaskTex ("Mask", 2D) = "black" { }
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 26592
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD6 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _DiffuseRatio;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat18 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD1.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD1.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    SV_Target0.xyz = u_xlat0.xyz * vec3(_DiffuseRatio);
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD6 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _DiffuseRatio;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat18 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD1.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD1.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    SV_Target0.xyz = u_xlat0.xyz * vec3(_DiffuseRatio);
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD6 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _DiffuseRatio;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat18 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD1.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD1.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    SV_Target0.xyz = u_xlat0.xyz * vec3(_DiffuseRatio);
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD6 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _DiffuseRatio;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD1.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD1.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    SV_Target0.xyz = u_xlat0.xyz * vec3(_DiffuseRatio) + u_xlat16_1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD6 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _DiffuseRatio;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD1.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD1.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    SV_Target0.xyz = u_xlat0.xyz * vec3(_DiffuseRatio) + u_xlat16_1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD6 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _DiffuseRatio;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD1.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD1.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    SV_Target0.xyz = u_xlat0.xyz * vec3(_DiffuseRatio) + u_xlat16_1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
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
Fallback "Diffuse"
}