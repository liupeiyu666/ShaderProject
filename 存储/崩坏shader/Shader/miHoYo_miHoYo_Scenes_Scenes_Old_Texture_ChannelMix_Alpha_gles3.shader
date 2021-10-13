//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Texture_ChannelMix_Alpha" {
Properties {
_MainTex ("Particle Texture", 2D) = "white" { }
_TintColor0 ("Tint Color0", Color) = (0.5,0.5,0.5,0.5)
_TintColor1 ("Tint Color1", Color) = (0.5,0.5,0.5,0.5)
_TintColor2 ("Tint Color2", Color) = (0.5,0.5,0.5,0.5)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emmision Scaler", Range(0, 10)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 15812
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _nextFrameOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy + _nextFrameOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _frameInterpolationFactor;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform 	float _BloomFactor;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_1.xyz);
    u_xlat16_2.xyz = vec3(_frameInterpolationFactor) * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat16_7 = u_xlat16_2.y * _TintColor1.w;
    u_xlat16_3.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_7) * u_xlat16_3.xyz + _TintColor0.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _TintColor2.xyz;
    u_xlat16_7 = u_xlat16_2.z * _TintColor2.w;
    SV_Target0.w = u_xlat16_2.x * _BloomFactor;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_7) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec2 _nextFrameOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy + _nextFrameOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _frameInterpolationFactor;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform 	float _BloomFactor;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_1.xyz);
    u_xlat16_2.xyz = vec3(_frameInterpolationFactor) * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat16_7 = u_xlat16_2.y * _TintColor1.w;
    u_xlat16_3.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_7) * u_xlat16_3.xyz + _TintColor0.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _TintColor2.xyz;
    u_xlat16_7 = u_xlat16_2.z * _TintColor2.w;
    SV_Target0.w = u_xlat16_2.x * _BloomFactor;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_7) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec2 _nextFrameOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy + _nextFrameOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _frameInterpolationFactor;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform 	float _BloomFactor;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_1.xyz);
    u_xlat16_2.xyz = vec3(_frameInterpolationFactor) * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat16_7 = u_xlat16_2.y * _TintColor1.w;
    u_xlat16_3.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_7) * u_xlat16_3.xyz + _TintColor0.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _TintColor2.xyz;
    u_xlat16_7 = u_xlat16_2.z * _TintColor2.w;
    SV_Target0.w = u_xlat16_2.x * _BloomFactor;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_7) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec2 _nextFrameOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy + _nextFrameOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _frameInterpolationFactor;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform 	float _BloomFactor;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_1.xyz);
    u_xlat16_2.xyz = vec3(_frameInterpolationFactor) * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat16_7 = u_xlat16_2.y * _TintColor1.w;
    u_xlat16_3.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_7) * u_xlat16_3.xyz + _TintColor0.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _TintColor2.xyz;
    u_xlat16_7 = u_xlat16_2.z * _TintColor2.w;
    SV_Target0.w = u_xlat16_2.x * _BloomFactor;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_7) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(u_xlat15);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec2 _nextFrameOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy + _nextFrameOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _frameInterpolationFactor;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform 	float _BloomFactor;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_1.xyz);
    u_xlat16_2.xyz = vec3(_frameInterpolationFactor) * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat16_7 = u_xlat16_2.y * _TintColor1.w;
    u_xlat16_3.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_7) * u_xlat16_3.xyz + _TintColor0.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _TintColor2.xyz;
    u_xlat16_7 = u_xlat16_2.z * _TintColor2.w;
    SV_Target0.w = u_xlat16_2.x * _BloomFactor;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_7) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(u_xlat15);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec2 _nextFrameOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy + _nextFrameOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _frameInterpolationFactor;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform 	float _BloomFactor;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_1.xyz);
    u_xlat16_2.xyz = vec3(_frameInterpolationFactor) * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat16_7 = u_xlat16_2.y * _TintColor1.w;
    u_xlat16_3.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_7) * u_xlat16_3.xyz + _TintColor0.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _TintColor2.xyz;
    u_xlat16_7 = u_xlat16_2.z * _TintColor2.w;
    SV_Target0.w = u_xlat16_2.x * _BloomFactor;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_7) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(u_xlat15);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
Fallback "Diffuse"
}