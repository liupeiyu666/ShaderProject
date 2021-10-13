//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Smoke_Common_New" {
Properties {
_LightColor ("LightColor", Color) = (0.097,0.097,0.097,0)
_DarkColor ("DarkColor", Color) = (0.038,0.038,0.038,0)
_RimColor ("RimColor", Color) = (0.5441177,0.5441177,0.5441177,0)
_SmokeBrightness ("SmokeBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
_SmokeShapeTex ("SmokeShapeTex", 2D) = "white" { }
_DistortionTex ("DistortionTex", 2D) = "white" { }
_SwirlItensity ("SwirlItensity", Float) = 0.05
_NoiseTex ("NoiseTex", 2D) = "white" { }
_DissolveDistortionNoiseTex ("DissolveDistortionNoiseTex", 2D) = "black" { }
_DissolveDistortionNoise_USpeed ("DissolveDistortionNoise_USpeed", Float) = 0
_DissolveDistortionNoise_VSpeed ("DissolveDistortionNoise_VSpeed", Float) = 0
_DistortionNoiseBrightness ("DistortionNoiseBrightness", Float) = 0
[Toggle(_FIRETOGGLE_ON)] _FireToggle ("FireToggle", Float) = 0
_FireColor ("FireColor", Color) = (1,0.8985802,0.08088237,0)
[MHYToggle] _CustomeFireColorToggle ("CustomeFireColorToggle", Float) = 0
_FireNoiseTex ("FireNoiseTex", 2D) = "white" { }
_DayColor ("DayColor", Color) = (1,1,1,1)
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "MAIN"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 17099
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat9 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat0.x = (-u_xlat9) + u_xlat10_0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_3.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_3.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_3.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat9 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat0.x = (-u_xlat9) + u_xlat10_0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_3.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_3.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_3.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat9 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat0.x = (-u_xlat9) + u_xlat10_0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_3.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_3.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_3.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat9 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat0.x = (-u_xlat9) + u_xlat10_0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_3.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_3.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_3.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat9 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat0.x = (-u_xlat9) + u_xlat10_0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_3.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_3.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_3.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat9 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat0.x = (-u_xlat9) + u_xlat10_0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_3.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_3.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_3.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_FIRETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec3 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat0.x = u_xlat10_0 + (-u_xlat1.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat4.xyz = _RimColor.xyz * u_xlat10_2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_SmokeBrightness);
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.yyy;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2.x = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_2 = u_xlat10_2.y * u_xlat10_2.x;
    u_xlat1.x = u_xlat16_2 * 7.0 + (-u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_FIRETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec3 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat0.x = u_xlat10_0 + (-u_xlat1.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat4.xyz = _RimColor.xyz * u_xlat10_2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_SmokeBrightness);
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.yyy;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2.x = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_2 = u_xlat10_2.y * u_xlat10_2.x;
    u_xlat1.x = u_xlat16_2 * 7.0 + (-u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_FIRETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec3 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat0.x = u_xlat10_0 + (-u_xlat1.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat4.xyz = _RimColor.xyz * u_xlat10_2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_SmokeBrightness);
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.yyy;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2.x = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_2 = u_xlat10_2.y * u_xlat10_2.x;
    u_xlat1.x = u_xlat16_2 * 7.0 + (-u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "_FIRETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec3 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat0.x = u_xlat10_0 + (-u_xlat1.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat4.xyz = _RimColor.xyz * u_xlat10_2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_SmokeBrightness);
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.yyy;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2.x = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_2 = u_xlat10_2.y * u_xlat10_2.x;
    u_xlat1.x = u_xlat16_2 * 7.0 + (-u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "_FIRETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec3 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat0.x = u_xlat10_0 + (-u_xlat1.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat4.xyz = _RimColor.xyz * u_xlat10_2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_SmokeBrightness);
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.yyy;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2.x = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_2 = u_xlat10_2.y * u_xlat10_2.x;
    u_xlat1.x = u_xlat16_2 * 7.0 + (-u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "_FIRETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec3 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat0.x = u_xlat10_0 + (-u_xlat1.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat4.xyz = _RimColor.xyz * u_xlat10_2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_SmokeBrightness);
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.yyy;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2.x = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_2 = u_xlat10_2.y * u_xlat10_2.x;
    u_xlat1.x = u_xlat16_2 * 7.0 + (-u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat9 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat0.x = (-u_xlat9) + u_xlat10_0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_3.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_3.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_3.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat9 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * _DayColor.xyz + vec3(u_xlat9);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat2.xyz;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat9 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat0.x = (-u_xlat9) + u_xlat10_0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_3.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_3.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_3.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat9 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * _DayColor.xyz + vec3(u_xlat9);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat2.xyz;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat9 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat0.x = (-u_xlat9) + u_xlat10_0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_3.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_3.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_3.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat9 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * _DayColor.xyz + vec3(u_xlat9);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "LUMINANCE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat9 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat0.x = (-u_xlat9) + u_xlat10_0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_3.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_3.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_3.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat9 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * _DayColor.xyz + vec3(u_xlat9);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "LUMINANCE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat9 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat0.x = (-u_xlat9) + u_xlat10_0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_3.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_3.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_3.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat9 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * _DayColor.xyz + vec3(u_xlat9);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "LUMINANCE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat9 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat0.x = (-u_xlat9) + u_xlat10_0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_3.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_3.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_3.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat9 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * _DayColor.xyz + vec3(u_xlat9);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_FIRETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec3 u_xlat4;
float u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat0.x = u_xlat10_0 + (-u_xlat1.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat4.xyz = _RimColor.xyz * u_xlat10_2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_SmokeBrightness);
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.yyy;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2.x = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_2 = u_xlat10_2.y * u_xlat10_2.x;
    u_xlat1.x = u_xlat16_2 * 7.0 + (-u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat10 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat1.xyz) * _DayColor.xyz + vec3(u_xlat10);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_FIRETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec3 u_xlat4;
float u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat0.x = u_xlat10_0 + (-u_xlat1.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat4.xyz = _RimColor.xyz * u_xlat10_2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_SmokeBrightness);
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.yyy;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2.x = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_2 = u_xlat10_2.y * u_xlat10_2.x;
    u_xlat1.x = u_xlat16_2 * 7.0 + (-u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat10 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat1.xyz) * _DayColor.xyz + vec3(u_xlat10);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_FIRETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec3 u_xlat4;
float u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat0.x = u_xlat10_0 + (-u_xlat1.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat4.xyz = _RimColor.xyz * u_xlat10_2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_SmokeBrightness);
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.yyy;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2.x = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_2 = u_xlat10_2.y * u_xlat10_2.x;
    u_xlat1.x = u_xlat16_2 * 7.0 + (-u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat10 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat1.xyz) * _DayColor.xyz + vec3(u_xlat10);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "LUMINANCE" "_FIRETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec3 u_xlat4;
float u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat0.x = u_xlat10_0 + (-u_xlat1.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat4.xyz = _RimColor.xyz * u_xlat10_2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_SmokeBrightness);
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.yyy;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2.x = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_2 = u_xlat10_2.y * u_xlat10_2.x;
    u_xlat1.x = u_xlat16_2 * 7.0 + (-u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat10 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat1.xyz) * _DayColor.xyz + vec3(u_xlat10);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "LUMINANCE" "_FIRETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec3 u_xlat4;
float u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat0.x = u_xlat10_0 + (-u_xlat1.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat4.xyz = _RimColor.xyz * u_xlat10_2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_SmokeBrightness);
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.yyy;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2.x = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_2 = u_xlat10_2.y * u_xlat10_2.x;
    u_xlat1.x = u_xlat16_2 * 7.0 + (-u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat10 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat1.xyz) * _DayColor.xyz + vec3(u_xlat10);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "LUMINANCE" "_FIRETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec3 u_xlat4;
float u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_3.xy = texture(_DistortionTex, u_xlat3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_3.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_3.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat1.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat0.x = u_xlat10_0 + (-u_xlat1.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_3.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat4.xyz = u_xlat10_2.xxx * u_xlat4.xyz + _DarkColor.xyz;
    u_xlat4.xyz = _RimColor.xyz * u_xlat10_2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_SmokeBrightness);
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.yyy;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2.x = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_2 = u_xlat10_2.y * u_xlat10_2.x;
    u_xlat1.x = u_xlat16_2 * 7.0 + (-u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat10 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat1.xyz) * _DayColor.xyz + vec3(u_xlat10);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat2.xyz;
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
Keywords { "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "_FIRETOGGLE_ON" }
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
Keywords { "INSTANCING_ON" "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "LUMINANCE" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "LUMINANCE" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "LUMINANCE" "_FIRETOGGLE_ON" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MiHoYoASEMaterialInspector"
}