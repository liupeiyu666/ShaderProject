//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/UVMove_Add_New" {
Properties {
_TintColor ("Color Tint", Color) = (1,1,1,1)
[Header(Main Texture)] _MainTex ("Main Tex", 2D) = "white" { }
_USpeed ("Main Tex U Speed", Float) = 1
_VSpeed ("Main Tex V Speed", Float) = 1
[Toggle(_RANDOMU_ON)] _RandomU ("Random U Offset", Float) = 0
[Toggle(_RANDOMV_ON)] _RandomV ("Random V Offset", Float) = 0
[Header(Noise Turbulence 01)] [Toggle(_USENOISETEX01_ON)] _UseNoiseTex01 ("Use Noise Tex 01", Float) = 0
_NoiseTex01 ("Noise Tex 01", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _Noise01ChannelMapping ("Channel Mapping", Float) = 0
_Noise01USpeed ("U Speed", Float) = 1
_Noise01VSpeed ("V Speed", Float) = 1
[Toggle] _Noise01RandomU ("Random U Offset", Float) = 0
[Toggle] _Noise01RandomV ("Random V Offset", Float) = 0
[Header(Noise Turbulence 02)] [Toggle(_USENOISETEX02_ON)] _UseNoiseTex02 ("Use Noise Tex 02", Float) = 0
_NoiseTex02 ("Noise Tex 02", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _Noise02ChannelMapping ("Channel Mapping", Float) = 0
_Noise02USpeed ("U Speed", Float) = 1
_Noise02VSpeed ("V Speed", Float) = 1
[Toggle] _Noise02RandomU ("Random U Offset", Float) = 0
[Toggle] _Noise02RandomV ("Random V Offset", Float) = 0
[Header(Noise Options)] _NoiseOffset ("Noise Offset", Float) = 0
_NoiseBrightness ("Noise Brightness", Float) = 1
[Header(Mask)] [Toggle(_USEMASKTEX_ON)] _UseMaskTex ("Use Mask Tex", Float) = 0
_MaskTex ("Mask Tex", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _MaskChannelMapping ("Channel Mapping", Float) = 0
[Header(Bloom)] _BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Header(Render Options)] [Enum(Off, 4, On, 0)] _AlwaysOnTop ("Always On Top", Float) = 4
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "LightweightForward" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 30950
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.z = u_xlat0.y + vs_TEXCOORD0.w;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.z = u_xlat0.y + vs_TEXCOORD0.w;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.z = u_xlat0.y + vs_TEXCOORD0.w;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_RANDOMU_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat0.y + vs_TEXCOORD0.z;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_RANDOMU_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat0.y + vs_TEXCOORD0.z;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_RANDOMU_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat0.y + vs_TEXCOORD0.z;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.z = u_xlat0.y + vs_TEXCOORD0.w;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.z = u_xlat0.y + vs_TEXCOORD0.w;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.z = u_xlat0.y + vs_TEXCOORD0.w;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat0.y + vs_TEXCOORD0.z;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat0.y + vs_TEXCOORD0.z;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat0.y + vs_TEXCOORD0.z;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
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
Keywords { "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
}
}
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
  GpuProgramID 93013
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.z = u_xlat0.y + vs_TEXCOORD0.w;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.z = u_xlat0.y + vs_TEXCOORD0.w;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.z = u_xlat0.y + vs_TEXCOORD0.w;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_RANDOMU_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat0.y + vs_TEXCOORD0.z;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_RANDOMU_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat0.y + vs_TEXCOORD0.z;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_RANDOMU_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat0.y + vs_TEXCOORD0.z;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.z = u_xlat0.y + vs_TEXCOORD0.w;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.z = u_xlat0.y + vs_TEXCOORD0.w;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.z = u_xlat0.y + vs_TEXCOORD0.w;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat0.y + vs_TEXCOORD0.z;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat0.y + vs_TEXCOORD0.z;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat0.y + vs_TEXCOORD0.z;
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xz;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlat0.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = vec2(vec2(_NoiseOffset, _NoiseOffset)) * vec2(_NoiseBrightness) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_TARGET0.w = u_xlat16_2 * u_xlat16_0.w;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.x = u_xlat16_2 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_5 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_5 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_5;
    u_xlat16_5 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_5;
    u_xlat0.x = u_xlat16_2 * u_xlat16_5 + _NoiseOffset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat3.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat3.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat3.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.w = u_xlat16_0.w;
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = u_xlat1.y + vs_TEXCOORD0.w;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat1.yz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat1.y + vs_TEXCOORD0.z;
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat1.xz;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
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
uniform 	mediump float _Noise01RandomU;
uniform 	mediump float _Noise01RandomV;
uniform 	mediump float _Noise02RandomU;
uniform 	mediump float _Noise02RandomV;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01ChannelMapping;
uniform 	float _Noise01USpeed;
uniform 	float _Noise01VSpeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02ChannelMapping;
uniform 	float _Noise02USpeed;
uniform 	float _Noise02VSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskChannelMapping;
uniform 	float _EmissionScaler;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat0.xy = vec2(_Noise01RandomU, _Noise01RandomV) * vs_TEXCOORD1.xy + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise01USpeed, _Noise01VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise01ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat0.xy = vec2(_Noise02RandomU, _Noise02RandomV) * vs_TEXCOORD1.zw + u_xlat0.xy;
    u_xlat0.xy = vec2(_Noise02USpeed, _Noise02VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex02, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_Noise02ChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_6 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat0.x = u_xlat16_2 * u_xlat16_6 + _NoiseOffset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = vec2(u_xlat4.x + vs_TEXCOORD0.z, u_xlat4.y + vs_TEXCOORD0.w);
    u_xlat4.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat4.xy;
    u_xlat0.xy = u_xlat0.xx * vec2(_NoiseBrightness) + u_xlat4.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskChannelMapping), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_TARGET0.w = u_xlat16_0.w * u_xlat16_3;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_TARGET0.xyz = u_xlat1.xyz;
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
Keywords { "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}