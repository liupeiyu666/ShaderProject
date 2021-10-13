//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Liquid_00" {
Properties {
_LiquidTex ("LiquidTex", 2D) = "white" { }
_Normalmap ("Normalmap", 2D) = "bump" { }
_NormalBrightness ("NormalBrightness", Range(-1, 4)) = 1
_MatcapSize ("MatcapSize", Range(0, 2)) = 1
_Matcap ("Matcap", 2D) = "white" { }
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 2
_Color ("Color", Color) = (1.5,1.5,1.5,0)
[Toggle] _UspeedToggle ("UspeedToggle", Float) = 0
_Uspeed ("Uspeed", Float) = 0
[Toggle] _MaskTexToggle ("MaskTexToggle", Float) = 0
_TextureMask ("TextureMask", 2D) = "white" { }
[Toggle] _NoiseToggle ("NoiseToggle", Float) = 0
[Toggle] _NoiseRandomToggle ("NoiseRandomToggle", Float) = 0
_Noise_Tex ("Noise_Tex", 2D) = "white" { }
_Noise_Uspeed ("Noise_Uspeed", Float) = 0
_Noise_Vspeed ("Noise_Vspeed", Float) = 0
_Noise_Offset ("Noise_Offset", Float) = 0.5
_Noise_Brightness ("Noise_Brightness", Float) = 0.1
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
  GpuProgramID 19871
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	vec4 _Color;
uniform 	float _NoiseToggle;
uniform 	float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	vec4 _DayColor;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _MaskTexToggle;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseToggle==1.0);
#else
    u_xlatb0 = _NoiseToggle==1.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
        u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
        u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
        u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
        u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
        u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
        u_xlat10_0 = texture(_Noise_Tex, u_xlat0.xy).x;
        u_xlat0.x = u_xlat10_0 + (-_Noise_Offset);
        u_xlat0.x = u_xlat0.x * _Noise_Brightness;
    } else {
        u_xlat0.x = 0.0;
    //ENDIF
    }
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8 = _Time.y * _Uspeed + vs_TEXCOORD0.z;
    u_xlat4.x = u_xlatb4 ? u_xlat8 : float(0.0);
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = u_xlat0.xx + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = _NormalBrightness * u_xlat8 + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
    u_xlat13 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat5.xy = vec2(u_xlat13) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat12) + u_xlat5.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat5.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(1.04999995, 1.04999995, 1.04999995));
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx + u_xlat3.xz;
    u_xlat0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb12 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb12){
        u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
        u_xlat10_12 = texture(_TextureMask, u_xlat3.xy).x;
        u_xlat0.x = u_xlat10_12 * u_xlat0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	vec4 _Color;
uniform 	float _NoiseToggle;
uniform 	float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	vec4 _DayColor;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _MaskTexToggle;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseToggle==1.0);
#else
    u_xlatb0 = _NoiseToggle==1.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
        u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
        u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
        u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
        u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
        u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
        u_xlat10_0 = texture(_Noise_Tex, u_xlat0.xy).x;
        u_xlat0.x = u_xlat10_0 + (-_Noise_Offset);
        u_xlat0.x = u_xlat0.x * _Noise_Brightness;
    } else {
        u_xlat0.x = 0.0;
    //ENDIF
    }
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8 = _Time.y * _Uspeed + vs_TEXCOORD0.z;
    u_xlat4.x = u_xlatb4 ? u_xlat8 : float(0.0);
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = u_xlat0.xx + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = _NormalBrightness * u_xlat8 + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
    u_xlat13 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat5.xy = vec2(u_xlat13) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat12) + u_xlat5.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat5.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(1.04999995, 1.04999995, 1.04999995));
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx + u_xlat3.xz;
    u_xlat0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb12 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb12){
        u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
        u_xlat10_12 = texture(_TextureMask, u_xlat3.xy).x;
        u_xlat0.x = u_xlat10_12 * u_xlat0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	vec4 _Color;
uniform 	float _NoiseToggle;
uniform 	float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	vec4 _DayColor;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _MaskTexToggle;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseToggle==1.0);
#else
    u_xlatb0 = _NoiseToggle==1.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
        u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
        u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
        u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
        u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
        u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
        u_xlat10_0 = texture(_Noise_Tex, u_xlat0.xy).x;
        u_xlat0.x = u_xlat10_0 + (-_Noise_Offset);
        u_xlat0.x = u_xlat0.x * _Noise_Brightness;
    } else {
        u_xlat0.x = 0.0;
    //ENDIF
    }
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8 = _Time.y * _Uspeed + vs_TEXCOORD0.z;
    u_xlat4.x = u_xlatb4 ? u_xlat8 : float(0.0);
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = u_xlat0.xx + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = _NormalBrightness * u_xlat8 + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
    u_xlat13 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat5.xy = vec2(u_xlat13) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat12) + u_xlat5.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat5.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(1.04999995, 1.04999995, 1.04999995));
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx + u_xlat3.xz;
    u_xlat0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb12 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb12){
        u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
        u_xlat10_12 = texture(_TextureMask, u_xlat3.xy).x;
        u_xlat0.x = u_xlat10_12 * u_xlat0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	vec4 _Color;
uniform 	float _NoiseToggle;
uniform 	float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	vec4 _DayColor;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _MaskTexToggle;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseToggle==1.0);
#else
    u_xlatb0 = _NoiseToggle==1.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
        u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
        u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
        u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
        u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
        u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
        u_xlat10_0 = texture(_Noise_Tex, u_xlat0.xy).x;
        u_xlat0.x = u_xlat10_0 + (-_Noise_Offset);
        u_xlat0.x = u_xlat0.x * _Noise_Brightness;
    } else {
        u_xlat0.x = 0.0;
    //ENDIF
    }
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8 = _Time.y * _Uspeed + vs_TEXCOORD0.z;
    u_xlat4.x = u_xlatb4 ? u_xlat8 : float(0.0);
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = u_xlat0.xx + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = _NormalBrightness * u_xlat8 + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
    u_xlat13 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat5.xy = vec2(u_xlat13) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat12) + u_xlat5.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat5.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(1.04999995, 1.04999995, 1.04999995));
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx + u_xlat3.xz;
    u_xlat0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb12 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb12){
        u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
        u_xlat10_12 = texture(_TextureMask, u_xlat3.xy).x;
        u_xlat0.x = u_xlat10_12 * u_xlat0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	vec4 _Color;
uniform 	float _NoiseToggle;
uniform 	float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	vec4 _DayColor;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _MaskTexToggle;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseToggle==1.0);
#else
    u_xlatb0 = _NoiseToggle==1.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
        u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
        u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
        u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
        u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
        u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
        u_xlat10_0 = texture(_Noise_Tex, u_xlat0.xy).x;
        u_xlat0.x = u_xlat10_0 + (-_Noise_Offset);
        u_xlat0.x = u_xlat0.x * _Noise_Brightness;
    } else {
        u_xlat0.x = 0.0;
    //ENDIF
    }
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8 = _Time.y * _Uspeed + vs_TEXCOORD0.z;
    u_xlat4.x = u_xlatb4 ? u_xlat8 : float(0.0);
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = u_xlat0.xx + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = _NormalBrightness * u_xlat8 + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
    u_xlat13 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat5.xy = vec2(u_xlat13) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat12) + u_xlat5.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat5.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(1.04999995, 1.04999995, 1.04999995));
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx + u_xlat3.xz;
    u_xlat0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb12 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb12){
        u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
        u_xlat10_12 = texture(_TextureMask, u_xlat3.xy).x;
        u_xlat0.x = u_xlat10_12 * u_xlat0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _texcoord2_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	vec4 _Color;
uniform 	float _NoiseToggle;
uniform 	float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	vec4 _DayColor;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _MaskTexToggle;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseToggle==1.0);
#else
    u_xlatb0 = _NoiseToggle==1.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
        u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
        u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
        u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
        u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
        u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
        u_xlat10_0 = texture(_Noise_Tex, u_xlat0.xy).x;
        u_xlat0.x = u_xlat10_0 + (-_Noise_Offset);
        u_xlat0.x = u_xlat0.x * _Noise_Brightness;
    } else {
        u_xlat0.x = 0.0;
    //ENDIF
    }
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8 = _Time.y * _Uspeed + vs_TEXCOORD0.z;
    u_xlat4.x = u_xlatb4 ? u_xlat8 : float(0.0);
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = u_xlat0.xx + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = _NormalBrightness * u_xlat8 + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
    u_xlat13 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat5.xy = vec2(u_xlat13) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat12) + u_xlat5.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat5.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(1.04999995, 1.04999995, 1.04999995));
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx + u_xlat3.xz;
    u_xlat0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb12 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb12){
        u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
        u_xlat10_12 = texture(_TextureMask, u_xlat3.xy).x;
        u_xlat0.x = u_xlat10_12 * u_xlat0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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

uniform 	vec4 unity_WorldTransformParams;
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
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD1.w = u_xlat4.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat4.y;
    vs_TEXCOORD3.w = u_xlat4.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	vec4 _Color;
uniform 	float _NoiseToggle;
uniform 	float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	vec4 _DayColor;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _MaskTexToggle;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseToggle==1.0);
#else
    u_xlatb0 = _NoiseToggle==1.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
        u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
        u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
        u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
        u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
        u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
        u_xlat10_0 = texture(_Noise_Tex, u_xlat0.xy).x;
        u_xlat0.x = u_xlat10_0 + (-_Noise_Offset);
        u_xlat0.x = u_xlat0.x * _Noise_Brightness;
    } else {
        u_xlat0.x = 0.0;
    //ENDIF
    }
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8 = _Time.y * _Uspeed + vs_TEXCOORD0.z;
    u_xlat4.x = u_xlatb4 ? u_xlat8 : float(0.0);
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = u_xlat0.xx + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = _NormalBrightness * u_xlat8 + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
    u_xlat13 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat5.xy = vec2(u_xlat13) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat12) + u_xlat5.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat5.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(1.04999995, 1.04999995, 1.04999995));
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx + u_xlat3.xz;
    u_xlat0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb12 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb12){
        u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
        u_xlat10_12 = texture(_TextureMask, u_xlat3.xy).x;
        u_xlat0.x = u_xlat10_12 * u_xlat0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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

uniform 	vec4 unity_WorldTransformParams;
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
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD1.w = u_xlat4.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat4.y;
    vs_TEXCOORD3.w = u_xlat4.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	vec4 _Color;
uniform 	float _NoiseToggle;
uniform 	float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	vec4 _DayColor;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _MaskTexToggle;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseToggle==1.0);
#else
    u_xlatb0 = _NoiseToggle==1.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
        u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
        u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
        u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
        u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
        u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
        u_xlat10_0 = texture(_Noise_Tex, u_xlat0.xy).x;
        u_xlat0.x = u_xlat10_0 + (-_Noise_Offset);
        u_xlat0.x = u_xlat0.x * _Noise_Brightness;
    } else {
        u_xlat0.x = 0.0;
    //ENDIF
    }
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8 = _Time.y * _Uspeed + vs_TEXCOORD0.z;
    u_xlat4.x = u_xlatb4 ? u_xlat8 : float(0.0);
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = u_xlat0.xx + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = _NormalBrightness * u_xlat8 + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
    u_xlat13 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat5.xy = vec2(u_xlat13) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat12) + u_xlat5.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat5.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(1.04999995, 1.04999995, 1.04999995));
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx + u_xlat3.xz;
    u_xlat0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb12 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb12){
        u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
        u_xlat10_12 = texture(_TextureMask, u_xlat3.xy).x;
        u_xlat0.x = u_xlat10_12 * u_xlat0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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

uniform 	vec4 unity_WorldTransformParams;
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
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD1.w = u_xlat4.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat4.y;
    vs_TEXCOORD3.w = u_xlat4.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	vec4 _Color;
uniform 	float _NoiseToggle;
uniform 	float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	vec4 _DayColor;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _MaskTexToggle;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseToggle==1.0);
#else
    u_xlatb0 = _NoiseToggle==1.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
        u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
        u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
        u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
        u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
        u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
        u_xlat10_0 = texture(_Noise_Tex, u_xlat0.xy).x;
        u_xlat0.x = u_xlat10_0 + (-_Noise_Offset);
        u_xlat0.x = u_xlat0.x * _Noise_Brightness;
    } else {
        u_xlat0.x = 0.0;
    //ENDIF
    }
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8 = _Time.y * _Uspeed + vs_TEXCOORD0.z;
    u_xlat4.x = u_xlatb4 ? u_xlat8 : float(0.0);
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = u_xlat0.xx + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = _NormalBrightness * u_xlat8 + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
    u_xlat13 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat5.xy = vec2(u_xlat13) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat12) + u_xlat5.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat5.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(1.04999995, 1.04999995, 1.04999995));
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx + u_xlat3.xz;
    u_xlat0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb12 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb12){
        u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
        u_xlat10_12 = texture(_TextureMask, u_xlat3.xy).x;
        u_xlat0.x = u_xlat10_12 * u_xlat0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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

uniform 	vec4 unity_WorldTransformParams;
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
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD1.w = u_xlat4.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat4.y;
    vs_TEXCOORD3.w = u_xlat4.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	vec4 _Color;
uniform 	float _NoiseToggle;
uniform 	float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	vec4 _DayColor;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _MaskTexToggle;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseToggle==1.0);
#else
    u_xlatb0 = _NoiseToggle==1.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
        u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
        u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
        u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
        u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
        u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
        u_xlat10_0 = texture(_Noise_Tex, u_xlat0.xy).x;
        u_xlat0.x = u_xlat10_0 + (-_Noise_Offset);
        u_xlat0.x = u_xlat0.x * _Noise_Brightness;
    } else {
        u_xlat0.x = 0.0;
    //ENDIF
    }
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8 = _Time.y * _Uspeed + vs_TEXCOORD0.z;
    u_xlat4.x = u_xlatb4 ? u_xlat8 : float(0.0);
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = u_xlat0.xx + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = _NormalBrightness * u_xlat8 + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
    u_xlat13 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat5.xy = vec2(u_xlat13) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat12) + u_xlat5.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat5.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(1.04999995, 1.04999995, 1.04999995));
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx + u_xlat3.xz;
    u_xlat0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb12 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb12){
        u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
        u_xlat10_12 = texture(_TextureMask, u_xlat3.xy).x;
        u_xlat0.x = u_xlat10_12 * u_xlat0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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

uniform 	vec4 unity_WorldTransformParams;
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
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD1.w = u_xlat4.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat4.y;
    vs_TEXCOORD3.w = u_xlat4.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	vec4 _Color;
uniform 	float _NoiseToggle;
uniform 	float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	vec4 _DayColor;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _MaskTexToggle;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseToggle==1.0);
#else
    u_xlatb0 = _NoiseToggle==1.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
        u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
        u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
        u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
        u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
        u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
        u_xlat10_0 = texture(_Noise_Tex, u_xlat0.xy).x;
        u_xlat0.x = u_xlat10_0 + (-_Noise_Offset);
        u_xlat0.x = u_xlat0.x * _Noise_Brightness;
    } else {
        u_xlat0.x = 0.0;
    //ENDIF
    }
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8 = _Time.y * _Uspeed + vs_TEXCOORD0.z;
    u_xlat4.x = u_xlatb4 ? u_xlat8 : float(0.0);
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = u_xlat0.xx + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = _NormalBrightness * u_xlat8 + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
    u_xlat13 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat5.xy = vec2(u_xlat13) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat12) + u_xlat5.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat5.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(1.04999995, 1.04999995, 1.04999995));
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx + u_xlat3.xz;
    u_xlat0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb12 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb12){
        u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
        u_xlat10_12 = texture(_TextureMask, u_xlat3.xy).x;
        u_xlat0.x = u_xlat10_12 * u_xlat0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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

uniform 	vec4 unity_WorldTransformParams;
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
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD1.w = u_xlat4.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat4.y;
    vs_TEXCOORD3.w = u_xlat4.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	vec4 _Color;
uniform 	float _NoiseToggle;
uniform 	float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalBrightness;
uniform 	float _MatcapSize;
uniform 	vec4 _DayColor;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _MaskTexToggle;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseToggle==1.0);
#else
    u_xlatb0 = _NoiseToggle==1.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
        u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
        u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
        u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
        u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
        u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
        u_xlat10_0 = texture(_Noise_Tex, u_xlat0.xy).x;
        u_xlat0.x = u_xlat10_0 + (-_Noise_Offset);
        u_xlat0.x = u_xlat0.x * _Noise_Brightness;
    } else {
        u_xlat0.x = 0.0;
    //ENDIF
    }
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8 = _Time.y * _Uspeed + vs_TEXCOORD0.z;
    u_xlat4.x = u_xlatb4 ? u_xlat8 : float(0.0);
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = u_xlat0.xx + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = _NormalBrightness * u_xlat8 + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
    u_xlat13 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat5.xy = vec2(u_xlat13) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat12) + u_xlat5.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat5.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(1.04999995, 1.04999995, 1.04999995));
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx + u_xlat3.xz;
    u_xlat0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb12 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb12){
        u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
        u_xlat10_12 = texture(_TextureMask, u_xlat3.xy).x;
        u_xlat0.x = u_xlat10_12 * u_xlat0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat8>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat8>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
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
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}