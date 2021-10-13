//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Dissolution_2Color_Multiply_New" {
Properties {
[Header(Main Texture)] _MainTex ("Main Tex", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _ColorChannelMapping ("Color Channel Mapping", Float) = 0
[Enum(R, 0, G, 1, B, 2, A, 3)] _AlphaChannelMapping ("Alpha Channel Mapping", Float) = 3
[Toggle] _UseVertexColor ("Use Particle Color As Color A", Float) = 0
_ColorA ("Color A", Color) = (1,0,0,0)
[Toggle] _UseCustomColor ("Use Particle Custom Color As Color B", Float) = 0
_ColorB ("Color B", Color) = (1,1,0,0)
_LerpBrightness ("Lerp Brightness", Float) = 1
[Header(Dissolve Map)] _DissolveTex ("Dissolve Tex", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _DissolveChannelMapping ("Dissolve Channel Mapping", Float) = 0
_DissolveUSpeed ("U Speed", Float) = 0
_DissolveVSpeed ("V Speed", Float) = 0
_DissolveRandomRange ("Random Speed Range", Float) = 0
[Toggle] _DissolveUVRandom ("Random UV", Float) = 0
[Header(Noise Map)] [Toggle(_NOISE_ON)] _Noise ("Use Noise", Float) = 0
_NoiseTex ("Noise Tex", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _NoiseChannelMapping ("Noise Channel Mapping", Float) = 0
_NoiseUSpeed ("U Speed", Float) = 0
_NoiseVSpeed ("V Speed", Float) = 0
_NoiseRandomRange ("Random Speed Range", Float) = 0
_NoiseBrightness ("Noise Brightness", Float) = 0.1
[Toggle] _NoiseUVRandom ("Random UV", Float) = 0
[Header(Bloom)] _BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Header(Render Options)] [Enum(Off, 4, On, 0)] _AlwaysOnTop ("Always On Top", Float) = 4
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 12892
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	float _ColorChannelMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _UseVertexColor;
uniform 	mediump vec4 _ColorA;
uniform 	float _UseCustomColor;
uniform 	mediump vec4 _ColorB;
uniform 	float _LerpBrightness;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveChannelMapping;
uniform 	float _DissolveUSpeed;
uniform 	float _DissolveVSpeed;
uniform 	float _DissolveRandomRange;
uniform 	float _DissolveUVRandom;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec2 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
mediump vec3 u_xlat16_7;
vec2 u_xlat10;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w + -0.5;
    u_xlat0.x = u_xlat0.x * abs(_DissolveRandomRange) + 1.0;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.xy = vec2(_Time.y * float(_DissolveUSpeed), _Time.y * float(_DissolveVSpeed));
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + u_xlat5.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom);
#endif
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_DissolveChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 * _LerpBrightness;
    u_xlatb1 = equal(vec4(_ColorChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_7.x = (u_xlatb1.w) ? u_xlat3.w : 0.0;
    u_xlat16_7.x = (u_xlatb1.z) ? u_xlat3.z : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb1.y) ? u_xlat3.y : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat16_7.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor);
#endif
    u_xlat16_7.xyz = (bool(u_xlatb5)) ? vs_TEXCOORD1.xyz : _ColorB.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? vs_COLOR0.xyz : _ColorA.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb0.w) ? u_xlat3.w : 0.0;
    u_xlat16_4.x = (u_xlatb0.z) ? u_xlat3.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.y) ? u_xlat3.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.x) ? u_xlat3.x : u_xlat16_4.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.x;
    u_xlat16_4.x = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4.x>=u_xlat16_2);
#else
    u_xlatb0.x = u_xlat16_4.x>=u_xlat16_2;
#endif
    u_xlat16_2 = (u_xlatb0.x) ? 0.0 : 1.0;
    SV_TARGET0.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    SV_TARGET0.w = 1.0;
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
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	float _ColorChannelMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _UseVertexColor;
uniform 	mediump vec4 _ColorA;
uniform 	float _UseCustomColor;
uniform 	mediump vec4 _ColorB;
uniform 	float _LerpBrightness;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveChannelMapping;
uniform 	float _DissolveUSpeed;
uniform 	float _DissolveVSpeed;
uniform 	float _DissolveRandomRange;
uniform 	float _DissolveUVRandom;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec2 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
mediump vec3 u_xlat16_7;
vec2 u_xlat10;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w + -0.5;
    u_xlat0.x = u_xlat0.x * abs(_DissolveRandomRange) + 1.0;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.xy = vec2(_Time.y * float(_DissolveUSpeed), _Time.y * float(_DissolveVSpeed));
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + u_xlat5.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom);
#endif
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_DissolveChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 * _LerpBrightness;
    u_xlatb1 = equal(vec4(_ColorChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_7.x = (u_xlatb1.w) ? u_xlat3.w : 0.0;
    u_xlat16_7.x = (u_xlatb1.z) ? u_xlat3.z : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb1.y) ? u_xlat3.y : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat16_7.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor);
#endif
    u_xlat16_7.xyz = (bool(u_xlatb5)) ? vs_TEXCOORD1.xyz : _ColorB.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? vs_COLOR0.xyz : _ColorA.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb0.w) ? u_xlat3.w : 0.0;
    u_xlat16_4.x = (u_xlatb0.z) ? u_xlat3.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.y) ? u_xlat3.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.x) ? u_xlat3.x : u_xlat16_4.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.x;
    u_xlat16_4.x = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4.x>=u_xlat16_2);
#else
    u_xlatb0.x = u_xlat16_4.x>=u_xlat16_2;
#endif
    u_xlat16_2 = (u_xlatb0.x) ? 0.0 : 1.0;
    SV_TARGET0.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    SV_TARGET0.w = 1.0;
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
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	float _ColorChannelMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _UseVertexColor;
uniform 	mediump vec4 _ColorA;
uniform 	float _UseCustomColor;
uniform 	mediump vec4 _ColorB;
uniform 	float _LerpBrightness;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveChannelMapping;
uniform 	float _DissolveUSpeed;
uniform 	float _DissolveVSpeed;
uniform 	float _DissolveRandomRange;
uniform 	float _DissolveUVRandom;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec2 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
mediump vec3 u_xlat16_7;
vec2 u_xlat10;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w + -0.5;
    u_xlat0.x = u_xlat0.x * abs(_DissolveRandomRange) + 1.0;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.xy = vec2(_Time.y * float(_DissolveUSpeed), _Time.y * float(_DissolveVSpeed));
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + u_xlat5.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom);
#endif
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_DissolveChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 * _LerpBrightness;
    u_xlatb1 = equal(vec4(_ColorChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_7.x = (u_xlatb1.w) ? u_xlat3.w : 0.0;
    u_xlat16_7.x = (u_xlatb1.z) ? u_xlat3.z : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb1.y) ? u_xlat3.y : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat16_7.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor);
#endif
    u_xlat16_7.xyz = (bool(u_xlatb5)) ? vs_TEXCOORD1.xyz : _ColorB.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? vs_COLOR0.xyz : _ColorA.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb0.w) ? u_xlat3.w : 0.0;
    u_xlat16_4.x = (u_xlatb0.z) ? u_xlat3.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.y) ? u_xlat3.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.x) ? u_xlat3.x : u_xlat16_4.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.x;
    u_xlat16_4.x = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4.x>=u_xlat16_2);
#else
    u_xlatb0.x = u_xlat16_4.x>=u_xlat16_2;
#endif
    u_xlat16_2 = (u_xlatb0.x) ? 0.0 : 1.0;
    SV_TARGET0.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    SV_TARGET0.w = 1.0;
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
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	float _ColorChannelMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _UseVertexColor;
uniform 	mediump vec4 _ColorA;
uniform 	float _UseCustomColor;
uniform 	mediump vec4 _ColorB;
uniform 	float _LerpBrightness;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveChannelMapping;
uniform 	float _DissolveUSpeed;
uniform 	float _DissolveVSpeed;
uniform 	float _DissolveRandomRange;
uniform 	float _DissolveUVRandom;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec2 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
mediump vec3 u_xlat16_7;
vec2 u_xlat10;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w + -0.5;
    u_xlat0.x = u_xlat0.x * abs(_DissolveRandomRange) + 1.0;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.xy = vec2(_Time.y * float(_DissolveUSpeed), _Time.y * float(_DissolveVSpeed));
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + u_xlat5.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom);
#endif
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_DissolveChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat0.x = u_xlat16_2.x * _LerpBrightness;
    u_xlatb1 = equal(vec4(_ColorChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_7.x = (u_xlatb1.w) ? u_xlat3.w : 0.0;
    u_xlat16_7.x = (u_xlatb1.z) ? u_xlat3.z : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb1.y) ? u_xlat3.y : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat16_7.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor);
#endif
    u_xlat16_7.xyz = (bool(u_xlatb5)) ? vs_TEXCOORD1.xyz : _ColorB.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? vs_COLOR0.xyz : _ColorA.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb0.w) ? u_xlat3.w : 0.0;
    u_xlat16_4.x = (u_xlatb0.z) ? u_xlat3.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.y) ? u_xlat3.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.x) ? u_xlat3.x : u_xlat16_4.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_4.x;
    u_xlat16_4.x = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4.x>=u_xlat16_2.x);
#else
    u_xlatb0.x = u_xlat16_4.x>=u_xlat16_2.x;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz;
    SV_TARGET0.w = 1.0;
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
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	float _ColorChannelMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _UseVertexColor;
uniform 	mediump vec4 _ColorA;
uniform 	float _UseCustomColor;
uniform 	mediump vec4 _ColorB;
uniform 	float _LerpBrightness;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveChannelMapping;
uniform 	float _DissolveUSpeed;
uniform 	float _DissolveVSpeed;
uniform 	float _DissolveRandomRange;
uniform 	float _DissolveUVRandom;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec2 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
mediump vec3 u_xlat16_7;
vec2 u_xlat10;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w + -0.5;
    u_xlat0.x = u_xlat0.x * abs(_DissolveRandomRange) + 1.0;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.xy = vec2(_Time.y * float(_DissolveUSpeed), _Time.y * float(_DissolveVSpeed));
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + u_xlat5.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom);
#endif
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_DissolveChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat0.x = u_xlat16_2.x * _LerpBrightness;
    u_xlatb1 = equal(vec4(_ColorChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_7.x = (u_xlatb1.w) ? u_xlat3.w : 0.0;
    u_xlat16_7.x = (u_xlatb1.z) ? u_xlat3.z : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb1.y) ? u_xlat3.y : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat16_7.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor);
#endif
    u_xlat16_7.xyz = (bool(u_xlatb5)) ? vs_TEXCOORD1.xyz : _ColorB.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? vs_COLOR0.xyz : _ColorA.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb0.w) ? u_xlat3.w : 0.0;
    u_xlat16_4.x = (u_xlatb0.z) ? u_xlat3.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.y) ? u_xlat3.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.x) ? u_xlat3.x : u_xlat16_4.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_4.x;
    u_xlat16_4.x = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4.x>=u_xlat16_2.x);
#else
    u_xlatb0.x = u_xlat16_4.x>=u_xlat16_2.x;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz;
    SV_TARGET0.w = 1.0;
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
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	float _ColorChannelMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _UseVertexColor;
uniform 	mediump vec4 _ColorA;
uniform 	float _UseCustomColor;
uniform 	mediump vec4 _ColorB;
uniform 	float _LerpBrightness;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveChannelMapping;
uniform 	float _DissolveUSpeed;
uniform 	float _DissolveVSpeed;
uniform 	float _DissolveRandomRange;
uniform 	float _DissolveUVRandom;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec2 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
mediump vec3 u_xlat16_7;
vec2 u_xlat10;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w + -0.5;
    u_xlat0.x = u_xlat0.x * abs(_DissolveRandomRange) + 1.0;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.xy = vec2(_Time.y * float(_DissolveUSpeed), _Time.y * float(_DissolveVSpeed));
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + u_xlat5.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom);
#endif
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_DissolveChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat0.x = u_xlat16_2.x * _LerpBrightness;
    u_xlatb1 = equal(vec4(_ColorChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_7.x = (u_xlatb1.w) ? u_xlat3.w : 0.0;
    u_xlat16_7.x = (u_xlatb1.z) ? u_xlat3.z : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb1.y) ? u_xlat3.y : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat16_7.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor);
#endif
    u_xlat16_7.xyz = (bool(u_xlatb5)) ? vs_TEXCOORD1.xyz : _ColorB.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? vs_COLOR0.xyz : _ColorA.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb0.w) ? u_xlat3.w : 0.0;
    u_xlat16_4.x = (u_xlatb0.z) ? u_xlat3.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.y) ? u_xlat3.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.x) ? u_xlat3.x : u_xlat16_4.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_4.x;
    u_xlat16_4.x = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4.x>=u_xlat16_2.x);
#else
    u_xlatb0.x = u_xlat16_4.x>=u_xlat16_2.x;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_NOISE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	float _ColorChannelMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _UseVertexColor;
uniform 	mediump vec4 _ColorA;
uniform 	float _UseCustomColor;
uniform 	mediump vec4 _ColorB;
uniform 	float _LerpBrightness;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveChannelMapping;
uniform 	float _DissolveUSpeed;
uniform 	float _DissolveVSpeed;
uniform 	float _DissolveRandomRange;
uniform 	float _DissolveUVRandom;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseChannelMapping;
uniform 	float _NoiseUSpeed;
uniform 	float _NoiseVSpeed;
uniform 	float _NoiseRandomRange;
uniform 	float _NoiseBrightness;
uniform 	float _NoiseUVRandom;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
bvec4 u_xlatb0;
float u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
float u_xlat6;
bool u_xlatb6;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat10.xy = vec2(_Time.y * float(_NoiseUSpeed), _Time.y * float(_NoiseVSpeed));
    u_xlat1 = vs_TEXCOORD1.w + -0.5;
    u_xlat6 = u_xlat1 * abs(_NoiseRandomRange) + 1.0;
    u_xlat1 = u_xlat1 * abs(_DissolveRandomRange) + 1.0;
    u_xlat0.xy = u_xlat10.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_NoiseUVRandom));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_NoiseUVRandom);
#endif
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlatb2 = equal(vec4(_NoiseChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat0.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + -0.5;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10.xy = vec2(_Time.y * float(_DissolveUSpeed), _Time.y * float(_DissolveVSpeed));
    u_xlat0.xy = u_xlat10.xy * vec2(u_xlat1) + u_xlat0.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom);
#endif
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0.xy = vec2(u_xlat16_3) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_DissolveChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3;
    u_xlat0.x = u_xlat16_3 * _LerpBrightness;
    u_xlatb1 = equal(vec4(_ColorChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor);
#endif
    u_xlat16_8.xyz = (bool(u_xlatb5)) ? vs_TEXCOORD1.xyz : _ColorB.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? vs_COLOR0.xyz : _ColorA.xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb0.w) ? u_xlat2.w : 0.0;
    u_xlat16_4.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat16_4.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_4.x;
    u_xlat16_4.x = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4.x>=u_xlat16_3);
#else
    u_xlatb0.x = u_xlat16_4.x>=u_xlat16_3;
#endif
    u_xlat16_3 = (u_xlatb0.x) ? 0.0 : 1.0;
    SV_TARGET0.xyz = vec3(u_xlat16_3) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_NOISE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	float _ColorChannelMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _UseVertexColor;
uniform 	mediump vec4 _ColorA;
uniform 	float _UseCustomColor;
uniform 	mediump vec4 _ColorB;
uniform 	float _LerpBrightness;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveChannelMapping;
uniform 	float _DissolveUSpeed;
uniform 	float _DissolveVSpeed;
uniform 	float _DissolveRandomRange;
uniform 	float _DissolveUVRandom;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseChannelMapping;
uniform 	float _NoiseUSpeed;
uniform 	float _NoiseVSpeed;
uniform 	float _NoiseRandomRange;
uniform 	float _NoiseBrightness;
uniform 	float _NoiseUVRandom;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
bvec4 u_xlatb0;
float u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
float u_xlat6;
bool u_xlatb6;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat10.xy = vec2(_Time.y * float(_NoiseUSpeed), _Time.y * float(_NoiseVSpeed));
    u_xlat1 = vs_TEXCOORD1.w + -0.5;
    u_xlat6 = u_xlat1 * abs(_NoiseRandomRange) + 1.0;
    u_xlat1 = u_xlat1 * abs(_DissolveRandomRange) + 1.0;
    u_xlat0.xy = u_xlat10.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_NoiseUVRandom));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_NoiseUVRandom);
#endif
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlatb2 = equal(vec4(_NoiseChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat0.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + -0.5;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10.xy = vec2(_Time.y * float(_DissolveUSpeed), _Time.y * float(_DissolveVSpeed));
    u_xlat0.xy = u_xlat10.xy * vec2(u_xlat1) + u_xlat0.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom);
#endif
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0.xy = vec2(u_xlat16_3) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_DissolveChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3;
    u_xlat0.x = u_xlat16_3 * _LerpBrightness;
    u_xlatb1 = equal(vec4(_ColorChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor);
#endif
    u_xlat16_8.xyz = (bool(u_xlatb5)) ? vs_TEXCOORD1.xyz : _ColorB.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? vs_COLOR0.xyz : _ColorA.xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb0.w) ? u_xlat2.w : 0.0;
    u_xlat16_4.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat16_4.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_4.x;
    u_xlat16_4.x = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4.x>=u_xlat16_3);
#else
    u_xlatb0.x = u_xlat16_4.x>=u_xlat16_3;
#endif
    u_xlat16_3 = (u_xlatb0.x) ? 0.0 : 1.0;
    SV_TARGET0.xyz = vec3(u_xlat16_3) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_NOISE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	float _ColorChannelMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _UseVertexColor;
uniform 	mediump vec4 _ColorA;
uniform 	float _UseCustomColor;
uniform 	mediump vec4 _ColorB;
uniform 	float _LerpBrightness;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveChannelMapping;
uniform 	float _DissolveUSpeed;
uniform 	float _DissolveVSpeed;
uniform 	float _DissolveRandomRange;
uniform 	float _DissolveUVRandom;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseChannelMapping;
uniform 	float _NoiseUSpeed;
uniform 	float _NoiseVSpeed;
uniform 	float _NoiseRandomRange;
uniform 	float _NoiseBrightness;
uniform 	float _NoiseUVRandom;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
bvec4 u_xlatb0;
float u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
float u_xlat6;
bool u_xlatb6;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat10.xy = vec2(_Time.y * float(_NoiseUSpeed), _Time.y * float(_NoiseVSpeed));
    u_xlat1 = vs_TEXCOORD1.w + -0.5;
    u_xlat6 = u_xlat1 * abs(_NoiseRandomRange) + 1.0;
    u_xlat1 = u_xlat1 * abs(_DissolveRandomRange) + 1.0;
    u_xlat0.xy = u_xlat10.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_NoiseUVRandom));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_NoiseUVRandom);
#endif
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlatb2 = equal(vec4(_NoiseChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat0.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + -0.5;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10.xy = vec2(_Time.y * float(_DissolveUSpeed), _Time.y * float(_DissolveVSpeed));
    u_xlat0.xy = u_xlat10.xy * vec2(u_xlat1) + u_xlat0.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom);
#endif
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0.xy = vec2(u_xlat16_3) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_DissolveChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3;
    u_xlat0.x = u_xlat16_3 * _LerpBrightness;
    u_xlatb1 = equal(vec4(_ColorChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor);
#endif
    u_xlat16_8.xyz = (bool(u_xlatb5)) ? vs_TEXCOORD1.xyz : _ColorB.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? vs_COLOR0.xyz : _ColorA.xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb0.w) ? u_xlat2.w : 0.0;
    u_xlat16_4.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat16_4.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_4.x;
    u_xlat16_4.x = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4.x>=u_xlat16_3);
#else
    u_xlatb0.x = u_xlat16_4.x>=u_xlat16_3;
#endif
    u_xlat16_3 = (u_xlatb0.x) ? 0.0 : 1.0;
    SV_TARGET0.xyz = vec3(u_xlat16_3) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_NOISE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	float _ColorChannelMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _UseVertexColor;
uniform 	mediump vec4 _ColorA;
uniform 	float _UseCustomColor;
uniform 	mediump vec4 _ColorB;
uniform 	float _LerpBrightness;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveChannelMapping;
uniform 	float _DissolveUSpeed;
uniform 	float _DissolveVSpeed;
uniform 	float _DissolveRandomRange;
uniform 	float _DissolveUVRandom;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseChannelMapping;
uniform 	float _NoiseUSpeed;
uniform 	float _NoiseVSpeed;
uniform 	float _NoiseRandomRange;
uniform 	float _NoiseBrightness;
uniform 	float _NoiseUVRandom;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
float u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
float u_xlat6;
bool u_xlatb6;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat10.xy = vec2(_Time.y * float(_NoiseUSpeed), _Time.y * float(_NoiseVSpeed));
    u_xlat1 = vs_TEXCOORD1.w + -0.5;
    u_xlat6 = u_xlat1 * abs(_NoiseRandomRange) + 1.0;
    u_xlat1 = u_xlat1 * abs(_DissolveRandomRange) + 1.0;
    u_xlat0.xy = u_xlat10.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_NoiseUVRandom));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_NoiseUVRandom);
#endif
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlatb2 = equal(vec4(_NoiseChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + -0.5;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10.xy = vec2(_Time.y * float(_DissolveUSpeed), _Time.y * float(_DissolveVSpeed));
    u_xlat0.xy = u_xlat10.xy * vec2(u_xlat1) + u_xlat0.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom);
#endif
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat16_3.xx * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_DissolveChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat0.x = u_xlat16_3.x * _LerpBrightness;
    u_xlatb1 = equal(vec4(_ColorChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor);
#endif
    u_xlat16_8.xyz = (bool(u_xlatb5)) ? vs_TEXCOORD1.xyz : _ColorB.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? vs_COLOR0.xyz : _ColorA.xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb0.w) ? u_xlat2.w : 0.0;
    u_xlat16_4.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat16_4.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_4.x;
    u_xlat16_4.x = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4.x>=u_xlat16_3.x);
#else
    u_xlatb0.x = u_xlat16_4.x>=u_xlat16_3.x;
#endif
    u_xlat16_3.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_NOISE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	float _ColorChannelMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _UseVertexColor;
uniform 	mediump vec4 _ColorA;
uniform 	float _UseCustomColor;
uniform 	mediump vec4 _ColorB;
uniform 	float _LerpBrightness;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveChannelMapping;
uniform 	float _DissolveUSpeed;
uniform 	float _DissolveVSpeed;
uniform 	float _DissolveRandomRange;
uniform 	float _DissolveUVRandom;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseChannelMapping;
uniform 	float _NoiseUSpeed;
uniform 	float _NoiseVSpeed;
uniform 	float _NoiseRandomRange;
uniform 	float _NoiseBrightness;
uniform 	float _NoiseUVRandom;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
float u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
float u_xlat6;
bool u_xlatb6;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat10.xy = vec2(_Time.y * float(_NoiseUSpeed), _Time.y * float(_NoiseVSpeed));
    u_xlat1 = vs_TEXCOORD1.w + -0.5;
    u_xlat6 = u_xlat1 * abs(_NoiseRandomRange) + 1.0;
    u_xlat1 = u_xlat1 * abs(_DissolveRandomRange) + 1.0;
    u_xlat0.xy = u_xlat10.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_NoiseUVRandom));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_NoiseUVRandom);
#endif
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlatb2 = equal(vec4(_NoiseChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + -0.5;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10.xy = vec2(_Time.y * float(_DissolveUSpeed), _Time.y * float(_DissolveVSpeed));
    u_xlat0.xy = u_xlat10.xy * vec2(u_xlat1) + u_xlat0.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom);
#endif
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat16_3.xx * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_DissolveChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat0.x = u_xlat16_3.x * _LerpBrightness;
    u_xlatb1 = equal(vec4(_ColorChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor);
#endif
    u_xlat16_8.xyz = (bool(u_xlatb5)) ? vs_TEXCOORD1.xyz : _ColorB.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? vs_COLOR0.xyz : _ColorA.xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb0.w) ? u_xlat2.w : 0.0;
    u_xlat16_4.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat16_4.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_4.x;
    u_xlat16_4.x = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4.x>=u_xlat16_3.x);
#else
    u_xlatb0.x = u_xlat16_4.x>=u_xlat16_3.x;
#endif
    u_xlat16_3.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_NOISE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	float _ColorChannelMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _UseVertexColor;
uniform 	mediump vec4 _ColorA;
uniform 	float _UseCustomColor;
uniform 	mediump vec4 _ColorB;
uniform 	float _LerpBrightness;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveChannelMapping;
uniform 	float _DissolveUSpeed;
uniform 	float _DissolveVSpeed;
uniform 	float _DissolveRandomRange;
uniform 	float _DissolveUVRandom;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseChannelMapping;
uniform 	float _NoiseUSpeed;
uniform 	float _NoiseVSpeed;
uniform 	float _NoiseRandomRange;
uniform 	float _NoiseBrightness;
uniform 	float _NoiseUVRandom;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
float u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
float u_xlat6;
bool u_xlatb6;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat10.xy = vec2(_Time.y * float(_NoiseUSpeed), _Time.y * float(_NoiseVSpeed));
    u_xlat1 = vs_TEXCOORD1.w + -0.5;
    u_xlat6 = u_xlat1 * abs(_NoiseRandomRange) + 1.0;
    u_xlat1 = u_xlat1 * abs(_DissolveRandomRange) + 1.0;
    u_xlat0.xy = u_xlat10.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_NoiseUVRandom));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_NoiseUVRandom);
#endif
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlatb2 = equal(vec4(_NoiseChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + -0.5;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10.xy = vec2(_Time.y * float(_DissolveUSpeed), _Time.y * float(_DissolveVSpeed));
    u_xlat0.xy = u_xlat10.xy * vec2(u_xlat1) + u_xlat0.xy;
    u_xlat10.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_DissolveUVRandom);
#endif
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat16_3.xx * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_DissolveChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat0.x = u_xlat16_3.x * _LerpBrightness;
    u_xlatb1 = equal(vec4(_ColorChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCustomColor);
#endif
    u_xlat16_8.xyz = (bool(u_xlatb5)) ? vs_TEXCOORD1.xyz : _ColorB.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseVertexColor);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? vs_COLOR0.xyz : _ColorA.xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb0.w) ? u_xlat2.w : 0.0;
    u_xlat16_4.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat16_4.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_4.x;
    u_xlat16_4.x = (-vs_COLOR0.w) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4.x>=u_xlat16_3.x);
#else
    u_xlatb0.x = u_xlat16_4.x>=u_xlat16_3.x;
#endif
    u_xlat16_3.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz;
    SV_TARGET0.w = 1.0;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "_NOISE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_NOISE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_NOISE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_NOISE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_NOISE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_NOISE_ON" }
""
}
}
}
}
}