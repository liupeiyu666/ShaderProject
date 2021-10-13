//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/ChannelMix/Alpha_Blended" {
Properties {
_MainTex ("Main Tex", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _LerpChannelAMapping ("Lerp Channel A Mapping", Float) = 0
[Enum(R, 0, G, 1, B, 2, A, 3)] _LerpChannelBMapping ("Lerp Channel B Mapping", Float) = 1
[Enum(R, 0, G, 1, B, 2, A, 3)] _AlphaChannelMapping ("Alpha Channel Mapping", Float) = 2
_ColorA ("Color A", Color) = (1,0,0,0)
_ColorB ("Color B", Color) = (0,1,0,0)
_ColorC ("Color C", Color) = (0,0,1,0)
[Toggle(_COLORCTOGGLE_ON)] _ColorCToggle ("Color C Toggle", Float) = 0
[Toggle(_PARTICLECOLORTOGGLE_ON)] _ParticleColorAsColorA ("Particle Color As Color A", Float) = 0
[Toggle(_CUSTOMCOLOR1TOGGLE_ON)] _CustomColor1AsColorB ("Custom Color 1 As Color B", Float) = 0
[Toggle(_CUSTOMCOLOR2TOGGLE_ON)] _CustomColor2AsColorC ("Custom Color 2 As Color C", Float) = 0
[Header(Bloom)] _BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Header(Render Options)] [Enum(Off, 4, On, 0)] _AlwaysOnTop ("Always On Top", Float) = 4
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 682
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_5.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ColorB.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_5.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ColorB.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_5.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ColorB.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_6.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + _ColorB.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_6.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + _ColorB.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_6.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + _ColorB.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_5.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ColorB.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_5.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ColorB.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_5.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ColorB.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_6.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + _ColorB.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_6.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + _ColorB.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_6.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + _ColorB.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat1.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat1.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat1.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat1.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat1.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat1.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat1.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat1.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat1.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat1.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat1.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat1.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_5.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ColorB.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_5.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ColorB.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_5.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ColorB.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_6.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + _ColorB.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_6.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + _ColorB.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_6.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + _ColorB.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_5.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ColorB.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_5.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ColorB.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_5.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ColorB.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_6.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + _ColorB.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_6.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + _ColorB.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat16_6.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + _ColorB.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat1.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat1.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat1.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat1.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat1.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat1.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat1.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat1.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat1.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat1.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat1.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_0 = u_xlat0 * vs_COLOR0.wwww;
    u_xlat1.xy = vs_TEXCOORD0.zw;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat1.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * u_xlat16_0.xyz + (-_ColorC.xyz);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorC.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_3 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_3;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * u_xlat16_0.xyz + (-_ColorC.xyz);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorC.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_3 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_3;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * u_xlat16_0.xyz + (-_ColorC.xyz);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorC.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_3 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_3;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat17;
void main()
{
    u_xlat16_0.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * u_xlat16_0.xyz + (-_ColorC.xyz);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorC.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat17 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat17);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat2.xyz;
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_4 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_4;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_4;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat17;
void main()
{
    u_xlat16_0.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * u_xlat16_0.xyz + (-_ColorC.xyz);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorC.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat17 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat17);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat2.xyz;
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_4 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_4;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_4;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat17;
void main()
{
    u_xlat16_0.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * u_xlat16_0.xyz + (-_ColorC.xyz);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorC.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat17 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat17);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat2.xyz;
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_4 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_4;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_4;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * u_xlat16_0.xyz + (-vs_TEXCOORD1.yzw);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + vs_TEXCOORD1.yzw;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_3 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_3;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * u_xlat16_0.xyz + (-vs_TEXCOORD1.yzw);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + vs_TEXCOORD1.yzw;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_3 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_3;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * u_xlat16_0.xyz + (-vs_TEXCOORD1.yzw);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + vs_TEXCOORD1.yzw;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_3 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_3;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat17;
void main()
{
    u_xlat16_0.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * u_xlat16_0.xyz + (-vs_TEXCOORD1.yzw);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + vs_TEXCOORD1.yzw;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat17 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat17);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat2.xyz;
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_4 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_4;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_4;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat17;
void main()
{
    u_xlat16_0.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * u_xlat16_0.xyz + (-vs_TEXCOORD1.yzw);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + vs_TEXCOORD1.yzw;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat17 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat17);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat2.xyz;
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_4 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_4;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_4;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat17;
void main()
{
    u_xlat16_0.xyz = _ColorA.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * u_xlat16_0.xyz + (-vs_TEXCOORD1.yzw);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + vs_TEXCOORD1.yzw;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat17 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat17);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat2.xyz;
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_4 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_4;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_4;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_11;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat0.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * u_xlat16_2.xyz + (-_ColorC.xyz);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_11 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_11 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_11;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + _ColorC.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_11;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat0.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * u_xlat16_2.xyz + (-_ColorC.xyz);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_11 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_11 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_11;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + _ColorC.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_11;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat0.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * u_xlat16_2.xyz + (-_ColorC.xyz);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_11 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_11 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_11;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + _ColorC.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat0.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * u_xlat16_2.xyz + (-_ColorC.xyz);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_14 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_14;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + _ColorC.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat0.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * u_xlat16_2.xyz + (-_ColorC.xyz);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_14 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_14;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + _ColorC.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat0.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * u_xlat16_2.xyz + (-_ColorC.xyz);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_14 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_14;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + _ColorC.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_11;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat0.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * u_xlat16_2.xyz + (-vs_TEXCOORD1.yzw);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_11 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_11 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_11;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + vs_TEXCOORD1.yzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_11;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat0.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * u_xlat16_2.xyz + (-vs_TEXCOORD1.yzw);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_11 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_11 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_11;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + vs_TEXCOORD1.yzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_11;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat0.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * u_xlat16_2.xyz + (-vs_TEXCOORD1.yzw);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_11 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_11 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_11;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + vs_TEXCOORD1.yzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat0.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * u_xlat16_2.xyz + (-vs_TEXCOORD1.yzw);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_14 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_14;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + vs_TEXCOORD1.yzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat0.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * u_xlat16_2.xyz + (-vs_TEXCOORD1.yzw);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_14 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_14;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + vs_TEXCOORD1.yzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorA;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat0.xyz) + _ColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * u_xlat16_2.xyz + (-vs_TEXCOORD1.yzw);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_14 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_14;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + vs_TEXCOORD1.yzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-_ColorC.xyz);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorC.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_3 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_3;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-_ColorC.xyz);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorC.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_3 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_3;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-_ColorC.xyz);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorC.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_3 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_3;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat17;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-_ColorC.xyz);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorC.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat17 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat17);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat2.xyz;
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_4 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_4;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_4;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat17;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-_ColorC.xyz);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorC.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat17 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat17);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat2.xyz;
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_4 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_4;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_4;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat17;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-_ColorC.xyz);
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorC.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat17 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat17);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat2.xyz;
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_4 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_4;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_4;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_0.x + (-vs_TEXCOORD1.y), u_xlat16_0.y + (-vs_TEXCOORD1.z), u_xlat16_0.z + (-vs_TEXCOORD1.w));
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + vs_TEXCOORD1.yzw;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_3 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_3;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_0.x + (-vs_TEXCOORD1.y), u_xlat16_0.y + (-vs_TEXCOORD1.z), u_xlat16_0.z + (-vs_TEXCOORD1.w));
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + vs_TEXCOORD1.yzw;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_3 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_3;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_0.x + (-vs_TEXCOORD1.y), u_xlat16_0.y + (-vs_TEXCOORD1.z), u_xlat16_0.z + (-vs_TEXCOORD1.w));
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_12 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_12;
    u_xlat16_12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_12;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + vs_TEXCOORD1.yzw;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_3 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_3;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat17;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_0.x + (-vs_TEXCOORD1.y), u_xlat16_0.y + (-vs_TEXCOORD1.z), u_xlat16_0.z + (-vs_TEXCOORD1.w));
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + vs_TEXCOORD1.yzw;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat17 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat17);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat2.xyz;
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_4 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_4;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_4;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat17;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_0.x + (-vs_TEXCOORD1.y), u_xlat16_0.y + (-vs_TEXCOORD1.z), u_xlat16_0.z + (-vs_TEXCOORD1.w));
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + vs_TEXCOORD1.yzw;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat17 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat17);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat2.xyz;
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_4 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_4;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_4;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorB;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat17;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-_ColorB.xyz);
    u_xlatb1 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + _ColorB.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_0.x + (-vs_TEXCOORD1.y), u_xlat16_0.y + (-vs_TEXCOORD1.z), u_xlat16_0.z + (-vs_TEXCOORD1.w));
    u_xlatb1 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_15 = (u_xlatb1.w) ? u_xlat2.w : 0.0;
    u_xlat16_15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat16_15;
    u_xlat16_15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat16_15;
    u_xlat16_1 = u_xlat2 * vs_COLOR0.wwww;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + vs_TEXCOORD1.yzw;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    u_xlat17 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat17);
    u_xlat2.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat2.xyz;
    SV_TARGET0.xyz = u_xlat2.xyz;
    u_xlatb0 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4 = (u_xlatb0.w) ? u_xlat16_1.w : vs_COLOR0.w;
    u_xlat16_4 = (u_xlatb0.z) ? u_xlat16_1.z : u_xlat16_4;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat16_1.y : u_xlat16_4;
    SV_TARGET0.w = (u_xlatb0.x) ? u_xlat16_1.x : u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_11;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat0.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_ColorC.xyz);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_11 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_11 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_11;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + _ColorC.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_11;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat0.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_ColorC.xyz);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_11 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_11 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_11;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + _ColorC.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_11;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat0.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_ColorC.xyz);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_11 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_11 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_11;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + _ColorC.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat0.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_ColorC.xyz);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_14 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_14;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + _ColorC.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat0.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_ColorC.xyz);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_14 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_14;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + _ColorC.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	mediump vec4 _ColorC;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat0.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_ColorC.xyz);
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_14 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_14;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + _ColorC.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_11;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat0.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_2.x + (-vs_TEXCOORD1.y), u_xlat16_2.y + (-vs_TEXCOORD1.z), u_xlat16_2.z + (-vs_TEXCOORD1.w));
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_11 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_11 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_11;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + vs_TEXCOORD1.yzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_11;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat0.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_2.x + (-vs_TEXCOORD1.y), u_xlat16_2.y + (-vs_TEXCOORD1.z), u_xlat16_2.z + (-vs_TEXCOORD1.w));
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_11 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_11 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_11;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + vs_TEXCOORD1.yzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_11;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_5.xyz = (-u_xlat0.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_2.x + (-vs_TEXCOORD1.y), u_xlat16_2.y + (-vs_TEXCOORD1.z), u_xlat16_2.z + (-vs_TEXCOORD1.w));
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_11 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_11 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_11;
    u_xlat16_11 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_11;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + vs_TEXCOORD1.yzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat0.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_2.x + (-vs_TEXCOORD1.y), u_xlat16_2.y + (-vs_TEXCOORD1.z), u_xlat16_2.z + (-vs_TEXCOORD1.w));
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_14 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_14;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + vs_TEXCOORD1.yzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat0.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_2.x + (-vs_TEXCOORD1.y), u_xlat16_2.y + (-vs_TEXCOORD1.z), u_xlat16_2.z + (-vs_TEXCOORD1.w));
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_14 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_14;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + vs_TEXCOORD1.yzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform 	vec4 _MainTex_ST;
uniform 	float _LerpChannelAMapping;
uniform 	float _LerpChannelBMapping;
uniform 	float _AlphaChannelMapping;
uniform 	float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0 = equal(vec4(_LerpChannelAMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_2.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_2.x;
    u_xlat0.xy = vs_TEXCOORD0.zw;
    u_xlat0.z = vs_TEXCOORD1.x;
    u_xlat16_6.xyz = (-u_xlat0.xyz) + vs_COLOR0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_2.x + (-vs_TEXCOORD1.y), u_xlat16_2.y + (-vs_TEXCOORD1.z), u_xlat16_2.z + (-vs_TEXCOORD1.w));
    u_xlatb0 = equal(vec4(vec4(_LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping, _LerpChannelBMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_14 = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_14;
    u_xlat16_0 = u_xlat1 * vs_COLOR0.wwww;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + vs_TEXCOORD1.yzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    u_xlat13 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(_EmissionScaler) + vec3(u_xlat13);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat3.xyz + u_xlat1.xyz;
    SV_TARGET0.xyz = u_xlat1.xyz;
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat16_0.w : vs_COLOR0.w;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat16_0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat16_0.y : u_xlat16_2.x;
    SV_TARGET0.w = (u_xlatb1.x) ? u_xlat16_0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_TARGET0.w = min(max(SV_TARGET0.w, 0.0), 1.0);
#else
    SV_TARGET0.w = clamp(SV_TARGET0.w, 0.0, 1.0);
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
SubProgram "gles3 hw_tier00 " {
Keywords { "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
}
}
 Pass {
  Name "CONSTANT_MAX"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 107176
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	float _AlphaChannelMapping;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = vs_TEXCOORD1 * _BloomFactor;
    u_xlat0.x = u_xlat0.x * u_xlat16_2;
    SV_TARGET0.w = u_xlat0.x;
    SV_TARGET0.xyz = vec3(0.0, 0.0, 0.0);
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	float _AlphaChannelMapping;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = vs_TEXCOORD1 * _BloomFactor;
    u_xlat0.x = u_xlat0.x * u_xlat16_2;
    SV_TARGET0.w = u_xlat0.x;
    SV_TARGET0.xyz = vec3(0.0, 0.0, 0.0);
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	float _AlphaChannelMapping;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = vs_TEXCOORD1 * _BloomFactor;
    u_xlat0.x = u_xlat0.x * u_xlat16_2;
    SV_TARGET0.w = u_xlat0.x;
    SV_TARGET0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	float _AlphaChannelMapping;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = vs_TEXCOORD1 * _BloomFactor;
    u_xlat0.x = u_xlat0.x * u_xlat16_2;
    SV_TARGET0.w = u_xlat0.x;
    SV_TARGET0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	float _AlphaChannelMapping;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = vs_TEXCOORD1 * _BloomFactor;
    u_xlat0.x = u_xlat0.x * u_xlat16_2;
    SV_TARGET0.w = u_xlat0.x;
    SV_TARGET0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	float _AlphaChannelMapping;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping, _AlphaChannelMapping)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = vs_TEXCOORD1 * _BloomFactor;
    u_xlat0.x = u_xlat0.x * u_xlat16_2;
    SV_TARGET0.w = u_xlat0.x;
    SV_TARGET0.xyz = vec3(0.0, 0.0, 0.0);
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
Keywords { "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" }
""
}
}
}
}
}