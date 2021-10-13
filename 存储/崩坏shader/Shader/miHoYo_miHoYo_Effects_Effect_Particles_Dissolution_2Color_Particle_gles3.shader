//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Dissolution_2Color_Particle" {
Properties {
_DissolveTex ("DissolveTex", 2D) = "white" { }
_DissolveTex_Vspeed ("DissolveTex_Vspeed", Float) = 0
_DissolveTex_Uspeed ("DissolveTex_Uspeed", Float) = 0
[Toggle] _DissolveTexUVRandomToggle ("DissolveTexUVRandomToggle", Float) = 0
[Toggle(_NOISETEXTOGGLE_ON)] _NoiseTexToggle ("NoiseTexToggle", Float) = 0
_NoiseTex ("NoiseTex", 2D) = "white" { }
_NoiseTex_Vspeed ("NoiseTex_Vspeed", Float) = 0
_NoiseTex_Uspeed ("NoiseTex_Uspeed", Float) = 0
_Noise_Brightness ("Noise_Brightness", Float) = 0.2
_Noise_Offset ("Noise_Offset", Float) = 0.5
[Toggle] _NoiseTexUVRandomToggle ("NoiseTexUVRandomToggle", Float) = 0
_BaseTex ("BaseTex", 2D) = "white" { }
[Toggle] _RChannelAsOpacityToggle ("RChannelAsOpacityToggle", Float) = 0
[Toggle] _ParticlesColorToggle ("ParticlesColorToggle", Float) = 0
_LerpColorA ("LerpColorA", Color) = (1,0.9326572,0.3897059,0)
_LerpColorB ("LerpColorB", Color) = (1,0.2689655,0,0)
_LerpBrightness ("LerpBrightness", Range(0, 20)) = 1
[Toggle] _MainColorToggle ("MainColorToggle", Float) = 0
_MainColor ("MainColor", Color) = (0,0,0,0)
_ColorBrightness ("ColorBrightness", Float) = 1
_DayColor ("DayColor", Color) = (1,1,1,1)
_texcoord ("", 2D) = "white" { }
_texcoord2 ("", 2D) = "white" { }
__dirty ("", Float) = 1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 50526
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _ColorBrightness;
uniform 	float _ParticlesColorToggle;
uniform 	vec4 _LerpColorA;
uniform 	vec4 _LerpColorB;
uniform 	float _LerpBrightness;
uniform 	float _DissolveTexUVRandomToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _RChannelAsOpacityToggle;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexUVRandomToggle==1.0);
#else
    u_xlatb0 = _DissolveTexUVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat3.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat1.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_3.xyz = texture(_BaseTex, u_xlat3.xy).xyw;
    u_xlat16_6 = u_xlat10_3.y * u_xlat10_0;
    u_xlat6 = u_xlat16_6 * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorA.xyz) + _LerpColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _LerpColorA.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ParticlesColorToggle==1.0);
#else
    u_xlatb6 = _ParticlesColorToggle==1.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat6 = (-u_xlat2.w) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RChannelAsOpacityToggle==1.0);
#else
    u_xlatb2 = _RChannelAsOpacityToggle==1.0;
#endif
    u_xlat3.x = (u_xlatb2) ? u_xlat10_3.x : u_xlat10_3.z;
    u_xlat0.x = u_xlat3.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat6>=u_xlat0.x;
#endif
    u_xlat1.w = (u_xlatb0) ? 0.0 : 1.0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _ColorBrightness;
uniform 	float _ParticlesColorToggle;
uniform 	vec4 _LerpColorA;
uniform 	vec4 _LerpColorB;
uniform 	float _LerpBrightness;
uniform 	float _DissolveTexUVRandomToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _RChannelAsOpacityToggle;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexUVRandomToggle==1.0);
#else
    u_xlatb0 = _DissolveTexUVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat3.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat1.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_3.xyz = texture(_BaseTex, u_xlat3.xy).xyw;
    u_xlat16_6 = u_xlat10_3.y * u_xlat10_0;
    u_xlat6 = u_xlat16_6 * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorA.xyz) + _LerpColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _LerpColorA.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ParticlesColorToggle==1.0);
#else
    u_xlatb6 = _ParticlesColorToggle==1.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat6 = (-u_xlat2.w) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RChannelAsOpacityToggle==1.0);
#else
    u_xlatb2 = _RChannelAsOpacityToggle==1.0;
#endif
    u_xlat3.x = (u_xlatb2) ? u_xlat10_3.x : u_xlat10_3.z;
    u_xlat0.x = u_xlat3.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat6>=u_xlat0.x;
#endif
    u_xlat1.w = (u_xlatb0) ? 0.0 : 1.0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _ColorBrightness;
uniform 	float _ParticlesColorToggle;
uniform 	vec4 _LerpColorA;
uniform 	vec4 _LerpColorB;
uniform 	float _LerpBrightness;
uniform 	float _DissolveTexUVRandomToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _RChannelAsOpacityToggle;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexUVRandomToggle==1.0);
#else
    u_xlatb0 = _DissolveTexUVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat3.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat1.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_3.xyz = texture(_BaseTex, u_xlat3.xy).xyw;
    u_xlat16_6 = u_xlat10_3.y * u_xlat10_0;
    u_xlat6 = u_xlat16_6 * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorA.xyz) + _LerpColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _LerpColorA.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ParticlesColorToggle==1.0);
#else
    u_xlatb6 = _ParticlesColorToggle==1.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat6 = (-u_xlat2.w) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RChannelAsOpacityToggle==1.0);
#else
    u_xlatb2 = _RChannelAsOpacityToggle==1.0;
#endif
    u_xlat3.x = (u_xlatb2) ? u_xlat10_3.x : u_xlat10_3.z;
    u_xlat0.x = u_xlat3.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat6>=u_xlat0.x;
#endif
    u_xlat1.w = (u_xlatb0) ? 0.0 : 1.0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _ColorBrightness;
uniform 	float _ParticlesColorToggle;
uniform 	vec4 _LerpColorA;
uniform 	vec4 _LerpColorB;
uniform 	float _LerpBrightness;
uniform 	float _DissolveTexUVRandomToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _RChannelAsOpacityToggle;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexUVRandomToggle==1.0);
#else
    u_xlatb0 = _DissolveTexUVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat3.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat1.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_3.xyz = texture(_BaseTex, u_xlat3.xy).xyw;
    u_xlat16_6 = u_xlat10_3.y * u_xlat10_0;
    u_xlat6 = u_xlat16_6 * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorA.xyz) + _LerpColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _LerpColorA.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ParticlesColorToggle==1.0);
#else
    u_xlatb6 = _ParticlesColorToggle==1.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat6 = (-u_xlat2.w) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RChannelAsOpacityToggle==1.0);
#else
    u_xlatb2 = _RChannelAsOpacityToggle==1.0;
#endif
    u_xlat3.x = (u_xlatb2) ? u_xlat10_3.x : u_xlat10_3.z;
    u_xlat0.x = u_xlat3.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat6>=u_xlat0.x;
#endif
    u_xlat1.w = (u_xlatb0) ? 0.0 : 1.0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _ColorBrightness;
uniform 	float _ParticlesColorToggle;
uniform 	vec4 _LerpColorA;
uniform 	vec4 _LerpColorB;
uniform 	float _LerpBrightness;
uniform 	float _DissolveTexUVRandomToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _RChannelAsOpacityToggle;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexUVRandomToggle==1.0);
#else
    u_xlatb0 = _DissolveTexUVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat3.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat1.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_3.xyz = texture(_BaseTex, u_xlat3.xy).xyw;
    u_xlat16_6 = u_xlat10_3.y * u_xlat10_0;
    u_xlat6 = u_xlat16_6 * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorA.xyz) + _LerpColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _LerpColorA.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ParticlesColorToggle==1.0);
#else
    u_xlatb6 = _ParticlesColorToggle==1.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat6 = (-u_xlat2.w) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RChannelAsOpacityToggle==1.0);
#else
    u_xlatb2 = _RChannelAsOpacityToggle==1.0;
#endif
    u_xlat3.x = (u_xlatb2) ? u_xlat10_3.x : u_xlat10_3.z;
    u_xlat0.x = u_xlat3.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat6>=u_xlat0.x;
#endif
    u_xlat1.w = (u_xlatb0) ? 0.0 : 1.0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _ColorBrightness;
uniform 	float _ParticlesColorToggle;
uniform 	vec4 _LerpColorA;
uniform 	vec4 _LerpColorB;
uniform 	float _LerpBrightness;
uniform 	float _DissolveTexUVRandomToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _RChannelAsOpacityToggle;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexUVRandomToggle==1.0);
#else
    u_xlatb0 = _DissolveTexUVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat3.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat1.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_3.xyz = texture(_BaseTex, u_xlat3.xy).xyw;
    u_xlat16_6 = u_xlat10_3.y * u_xlat10_0;
    u_xlat6 = u_xlat16_6 * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorA.xyz) + _LerpColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _LerpColorA.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ParticlesColorToggle==1.0);
#else
    u_xlatb6 = _ParticlesColorToggle==1.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat6 = (-u_xlat2.w) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RChannelAsOpacityToggle==1.0);
#else
    u_xlatb2 = _RChannelAsOpacityToggle==1.0;
#endif
    u_xlat3.x = (u_xlatb2) ? u_xlat10_3.x : u_xlat10_3.z;
    u_xlat0.x = u_xlat3.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat6>=u_xlat0.x;
#endif
    u_xlat1.w = (u_xlatb0) ? 0.0 : 1.0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _ColorBrightness;
uniform 	float _ParticlesColorToggle;
uniform 	vec4 _LerpColorA;
uniform 	vec4 _LerpColorB;
uniform 	float _LerpBrightness;
uniform 	float _DissolveTexUVRandomToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _RChannelAsOpacityToggle;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexUVRandomToggle==1.0);
#else
    u_xlatb0 = _DissolveTexUVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat3.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat1.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_3.xyz = texture(_BaseTex, u_xlat3.xy).xyw;
    u_xlat16_6 = u_xlat10_3.y * u_xlat10_0;
    u_xlat6 = u_xlat16_6 * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorA.xyz) + _LerpColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _LerpColorA.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ParticlesColorToggle==1.0);
#else
    u_xlatb6 = _ParticlesColorToggle==1.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat6 = (-u_xlat2.w) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RChannelAsOpacityToggle==1.0);
#else
    u_xlatb2 = _RChannelAsOpacityToggle==1.0;
#endif
    u_xlat3.x = (u_xlatb2) ? u_xlat10_3.x : u_xlat10_3.z;
    u_xlat0.x = u_xlat3.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat6>=u_xlat0.x;
#endif
    u_xlat1.w = (u_xlatb0) ? 0.0 : 1.0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _ColorBrightness;
uniform 	float _ParticlesColorToggle;
uniform 	vec4 _LerpColorA;
uniform 	vec4 _LerpColorB;
uniform 	float _LerpBrightness;
uniform 	float _DissolveTexUVRandomToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _RChannelAsOpacityToggle;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexUVRandomToggle==1.0);
#else
    u_xlatb0 = _DissolveTexUVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat3.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat1.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_3.xyz = texture(_BaseTex, u_xlat3.xy).xyw;
    u_xlat16_6 = u_xlat10_3.y * u_xlat10_0;
    u_xlat6 = u_xlat16_6 * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorA.xyz) + _LerpColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _LerpColorA.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ParticlesColorToggle==1.0);
#else
    u_xlatb6 = _ParticlesColorToggle==1.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat6 = (-u_xlat2.w) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RChannelAsOpacityToggle==1.0);
#else
    u_xlatb2 = _RChannelAsOpacityToggle==1.0;
#endif
    u_xlat3.x = (u_xlatb2) ? u_xlat10_3.x : u_xlat10_3.z;
    u_xlat0.x = u_xlat3.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat6>=u_xlat0.x;
#endif
    u_xlat1.w = (u_xlatb0) ? 0.0 : 1.0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _ColorBrightness;
uniform 	float _ParticlesColorToggle;
uniform 	vec4 _LerpColorA;
uniform 	vec4 _LerpColorB;
uniform 	float _LerpBrightness;
uniform 	float _DissolveTexUVRandomToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _RChannelAsOpacityToggle;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexUVRandomToggle==1.0);
#else
    u_xlatb0 = _DissolveTexUVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat3.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat1.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_3.xyz = texture(_BaseTex, u_xlat3.xy).xyw;
    u_xlat16_6 = u_xlat10_3.y * u_xlat10_0;
    u_xlat6 = u_xlat16_6 * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorA.xyz) + _LerpColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _LerpColorA.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ParticlesColorToggle==1.0);
#else
    u_xlatb6 = _ParticlesColorToggle==1.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat6 = (-u_xlat2.w) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RChannelAsOpacityToggle==1.0);
#else
    u_xlatb2 = _RChannelAsOpacityToggle==1.0;
#endif
    u_xlat3.x = (u_xlatb2) ? u_xlat10_3.x : u_xlat10_3.z;
    u_xlat0.x = u_xlat3.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat6>=u_xlat0.x;
#endif
    u_xlat1.w = (u_xlatb0) ? 0.0 : 1.0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _ColorBrightness;
uniform 	float _ParticlesColorToggle;
uniform 	vec4 _LerpColorA;
uniform 	vec4 _LerpColorB;
uniform 	float _LerpBrightness;
uniform 	float _DissolveTexUVRandomToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _RChannelAsOpacityToggle;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexUVRandomToggle==1.0);
#else
    u_xlatb0 = _DissolveTexUVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat3.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat1.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_3.xyz = texture(_BaseTex, u_xlat3.xy).xyw;
    u_xlat16_6 = u_xlat10_3.y * u_xlat10_0;
    u_xlat6 = u_xlat16_6 * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorA.xyz) + _LerpColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _LerpColorA.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ParticlesColorToggle==1.0);
#else
    u_xlatb6 = _ParticlesColorToggle==1.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat6 = (-u_xlat2.w) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RChannelAsOpacityToggle==1.0);
#else
    u_xlatb2 = _RChannelAsOpacityToggle==1.0;
#endif
    u_xlat3.x = (u_xlatb2) ? u_xlat10_3.x : u_xlat10_3.z;
    u_xlat0.x = u_xlat3.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat6>=u_xlat0.x;
#endif
    u_xlat1.w = (u_xlatb0) ? 0.0 : 1.0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _ColorBrightness;
uniform 	float _ParticlesColorToggle;
uniform 	vec4 _LerpColorA;
uniform 	vec4 _LerpColorB;
uniform 	float _LerpBrightness;
uniform 	float _DissolveTexUVRandomToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _RChannelAsOpacityToggle;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexUVRandomToggle==1.0);
#else
    u_xlatb0 = _DissolveTexUVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat3.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat1.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_3.xyz = texture(_BaseTex, u_xlat3.xy).xyw;
    u_xlat16_6 = u_xlat10_3.y * u_xlat10_0;
    u_xlat6 = u_xlat16_6 * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorA.xyz) + _LerpColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _LerpColorA.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ParticlesColorToggle==1.0);
#else
    u_xlatb6 = _ParticlesColorToggle==1.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat6 = (-u_xlat2.w) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RChannelAsOpacityToggle==1.0);
#else
    u_xlatb2 = _RChannelAsOpacityToggle==1.0;
#endif
    u_xlat3.x = (u_xlatb2) ? u_xlat10_3.x : u_xlat10_3.z;
    u_xlat0.x = u_xlat3.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat6>=u_xlat0.x;
#endif
    u_xlat1.w = (u_xlatb0) ? 0.0 : 1.0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _ColorBrightness;
uniform 	float _ParticlesColorToggle;
uniform 	vec4 _LerpColorA;
uniform 	vec4 _LerpColorB;
uniform 	float _LerpBrightness;
uniform 	float _DissolveTexUVRandomToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _RChannelAsOpacityToggle;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexUVRandomToggle==1.0);
#else
    u_xlatb0 = _DissolveTexUVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat3.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat1.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_3.xyz = texture(_BaseTex, u_xlat3.xy).xyw;
    u_xlat16_6 = u_xlat10_3.y * u_xlat10_0;
    u_xlat6 = u_xlat16_6 * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorA.xyz) + _LerpColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _LerpColorA.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ParticlesColorToggle==1.0);
#else
    u_xlatb6 = _ParticlesColorToggle==1.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat6 = (-u_xlat2.w) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RChannelAsOpacityToggle==1.0);
#else
    u_xlatb2 = _RChannelAsOpacityToggle==1.0;
#endif
    u_xlat3.x = (u_xlatb2) ? u_xlat10_3.x : u_xlat10_3.z;
    u_xlat0.x = u_xlat3.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat6>=u_xlat0.x;
#endif
    u_xlat1.w = (u_xlatb0) ? 0.0 : 1.0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}