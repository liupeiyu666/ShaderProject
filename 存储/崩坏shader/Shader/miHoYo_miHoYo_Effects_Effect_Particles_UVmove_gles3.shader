//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/UVmove" {
Properties {
[Toggle] _NoiseTexToggle ("NoiseTexToggle", Float) = 0
_NoiseTex01 ("NoiseTex01", 2D) = "white" { }
_NoiseTex01_Uspeed ("NoiseTex01_Uspeed", Float) = 1
_NoiseTex01_Vspeed ("NoiseTex01_Vspeed", Float) = 1
[Toggle] _2NoiseTexToggle ("2NoiseTexToggle", Float) = 0
_NoiseTex02 ("NoiseTex02", 2D) = "white" { }
_NoiseTex02_Uspeed ("NoiseTex02_Uspeed", Float) = 1
_NoiseTex02_Vspeed ("NoiseTex02_Vspeed", Float) = 1
_Noise_Brightness ("Noise_Brightness", Float) = 1
_Noise_Offset ("Noise_Offset", Float) = 0
[Toggle] _MaskTexToggle ("MaskTexToggle", Float) = 0
_MaskTexture ("MaskTexture", 2D) = "white" { }
_BaseTex ("BaseTex", 2D) = "white" { }
_BaseTex_Uspeed ("BaseTex_Uspeed", Float) = 1
_BaseTex_Vspeed ("BaseTex_Vspeed", Float) = 1
[Toggle] _MainColorToggle ("MainColorToggle", Float) = 0
_MainColor ("MainColor", Color) = (1,1,1,0)
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
_DayColor ("DayColor", Color) = (1,1,1,1)
_texcoord ("", 2D) = "white" { }
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
  GpuProgramID 17591
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _NoiseTexToggle;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Uspeed;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	float _2NoiseTexToggle;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _NoiseTex01_Uspeed;
uniform 	float _NoiseTex01_Vspeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_Uspeed;
uniform 	float _NoiseTex02_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _MaskTexToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat4;
lowp float u_xlat10_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_BaseTex_Uspeed, _BaseTex_Vspeed) + u_xlat0.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_NoiseTex01_Uspeed, _NoiseTex01_Vspeed) + u_xlat4.xy;
    u_xlat4.x = texture(_NoiseTex01, u_xlat4.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_2NoiseTexToggle==1.0);
#else
    u_xlatb6 = _2NoiseTexToggle==1.0;
#endif
    if(u_xlatb6){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
        u_xlat1.xy = _Time.yy * vec2(_NoiseTex02_Uspeed, _NoiseTex02_Vspeed) + u_xlat1.xy;
        u_xlat10_6 = texture(_NoiseTex02, u_xlat1.xy).x;
        u_xlat4.x = u_xlat10_6 * u_xlat4.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexToggle==1.0);
#else
    u_xlatb6 = _NoiseTexToggle==1.0;
#endif
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat4.xx + u_xlat0.xy;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_MainColorToggle==1.0);
#else
    u_xlatb1 = _MainColorToggle==1.0;
#endif
    u_xlat1 = (bool(u_xlatb1)) ? _MainColor : vs_COLOR0;
    u_xlat0 = u_xlat10_0.wxyz * u_xlat1.wxyz;
    u_xlat2.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb2 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
        u_xlat10_2 = texture(_MaskTexture, u_xlat2.xy).x;
        u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    //ENDIF
    }
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _NoiseTexToggle;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Uspeed;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	float _2NoiseTexToggle;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _NoiseTex01_Uspeed;
uniform 	float _NoiseTex01_Vspeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_Uspeed;
uniform 	float _NoiseTex02_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _MaskTexToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat4;
lowp float u_xlat10_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_BaseTex_Uspeed, _BaseTex_Vspeed) + u_xlat0.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_NoiseTex01_Uspeed, _NoiseTex01_Vspeed) + u_xlat4.xy;
    u_xlat4.x = texture(_NoiseTex01, u_xlat4.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_2NoiseTexToggle==1.0);
#else
    u_xlatb6 = _2NoiseTexToggle==1.0;
#endif
    if(u_xlatb6){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
        u_xlat1.xy = _Time.yy * vec2(_NoiseTex02_Uspeed, _NoiseTex02_Vspeed) + u_xlat1.xy;
        u_xlat10_6 = texture(_NoiseTex02, u_xlat1.xy).x;
        u_xlat4.x = u_xlat10_6 * u_xlat4.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexToggle==1.0);
#else
    u_xlatb6 = _NoiseTexToggle==1.0;
#endif
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat4.xx + u_xlat0.xy;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_MainColorToggle==1.0);
#else
    u_xlatb1 = _MainColorToggle==1.0;
#endif
    u_xlat1 = (bool(u_xlatb1)) ? _MainColor : vs_COLOR0;
    u_xlat0 = u_xlat10_0.wxyz * u_xlat1.wxyz;
    u_xlat2.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb2 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
        u_xlat10_2 = texture(_MaskTexture, u_xlat2.xy).x;
        u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    //ENDIF
    }
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _NoiseTexToggle;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Uspeed;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	float _2NoiseTexToggle;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _NoiseTex01_Uspeed;
uniform 	float _NoiseTex01_Vspeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_Uspeed;
uniform 	float _NoiseTex02_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _MaskTexToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat4;
lowp float u_xlat10_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_BaseTex_Uspeed, _BaseTex_Vspeed) + u_xlat0.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_NoiseTex01_Uspeed, _NoiseTex01_Vspeed) + u_xlat4.xy;
    u_xlat4.x = texture(_NoiseTex01, u_xlat4.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_2NoiseTexToggle==1.0);
#else
    u_xlatb6 = _2NoiseTexToggle==1.0;
#endif
    if(u_xlatb6){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
        u_xlat1.xy = _Time.yy * vec2(_NoiseTex02_Uspeed, _NoiseTex02_Vspeed) + u_xlat1.xy;
        u_xlat10_6 = texture(_NoiseTex02, u_xlat1.xy).x;
        u_xlat4.x = u_xlat10_6 * u_xlat4.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexToggle==1.0);
#else
    u_xlatb6 = _NoiseTexToggle==1.0;
#endif
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat4.xx + u_xlat0.xy;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_MainColorToggle==1.0);
#else
    u_xlatb1 = _MainColorToggle==1.0;
#endif
    u_xlat1 = (bool(u_xlatb1)) ? _MainColor : vs_COLOR0;
    u_xlat0 = u_xlat10_0.wxyz * u_xlat1.wxyz;
    u_xlat2.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb2 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
        u_xlat10_2 = texture(_MaskTexture, u_xlat2.xy).x;
        u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    //ENDIF
    }
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _NoiseTexToggle;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Uspeed;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	float _2NoiseTexToggle;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _NoiseTex01_Uspeed;
uniform 	float _NoiseTex01_Vspeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_Uspeed;
uniform 	float _NoiseTex02_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _MaskTexToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat4;
lowp float u_xlat10_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_BaseTex_Uspeed, _BaseTex_Vspeed) + u_xlat0.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_NoiseTex01_Uspeed, _NoiseTex01_Vspeed) + u_xlat4.xy;
    u_xlat4.x = texture(_NoiseTex01, u_xlat4.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_2NoiseTexToggle==1.0);
#else
    u_xlatb6 = _2NoiseTexToggle==1.0;
#endif
    if(u_xlatb6){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
        u_xlat1.xy = _Time.yy * vec2(_NoiseTex02_Uspeed, _NoiseTex02_Vspeed) + u_xlat1.xy;
        u_xlat10_6 = texture(_NoiseTex02, u_xlat1.xy).x;
        u_xlat4.x = u_xlat10_6 * u_xlat4.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexToggle==1.0);
#else
    u_xlatb6 = _NoiseTexToggle==1.0;
#endif
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat4.xx + u_xlat0.xy;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_MainColorToggle==1.0);
#else
    u_xlatb1 = _MainColorToggle==1.0;
#endif
    u_xlat1 = (bool(u_xlatb1)) ? _MainColor : vs_COLOR0;
    u_xlat0 = u_xlat10_0.wxyz * u_xlat1.wxyz;
    u_xlat2.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb2 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
        u_xlat10_2 = texture(_MaskTexture, u_xlat2.xy).x;
        u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    //ENDIF
    }
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _NoiseTexToggle;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Uspeed;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	float _2NoiseTexToggle;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _NoiseTex01_Uspeed;
uniform 	float _NoiseTex01_Vspeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_Uspeed;
uniform 	float _NoiseTex02_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _MaskTexToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat4;
lowp float u_xlat10_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_BaseTex_Uspeed, _BaseTex_Vspeed) + u_xlat0.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_NoiseTex01_Uspeed, _NoiseTex01_Vspeed) + u_xlat4.xy;
    u_xlat4.x = texture(_NoiseTex01, u_xlat4.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_2NoiseTexToggle==1.0);
#else
    u_xlatb6 = _2NoiseTexToggle==1.0;
#endif
    if(u_xlatb6){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
        u_xlat1.xy = _Time.yy * vec2(_NoiseTex02_Uspeed, _NoiseTex02_Vspeed) + u_xlat1.xy;
        u_xlat10_6 = texture(_NoiseTex02, u_xlat1.xy).x;
        u_xlat4.x = u_xlat10_6 * u_xlat4.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexToggle==1.0);
#else
    u_xlatb6 = _NoiseTexToggle==1.0;
#endif
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat4.xx + u_xlat0.xy;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_MainColorToggle==1.0);
#else
    u_xlatb1 = _MainColorToggle==1.0;
#endif
    u_xlat1 = (bool(u_xlatb1)) ? _MainColor : vs_COLOR0;
    u_xlat0 = u_xlat10_0.wxyz * u_xlat1.wxyz;
    u_xlat2.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb2 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
        u_xlat10_2 = texture(_MaskTexture, u_xlat2.xy).x;
        u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    //ENDIF
    }
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _NoiseTexToggle;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Uspeed;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	float _2NoiseTexToggle;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _NoiseTex01_Uspeed;
uniform 	float _NoiseTex01_Vspeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_Uspeed;
uniform 	float _NoiseTex02_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _MaskTexToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat4;
lowp float u_xlat10_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_BaseTex_Uspeed, _BaseTex_Vspeed) + u_xlat0.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_NoiseTex01_Uspeed, _NoiseTex01_Vspeed) + u_xlat4.xy;
    u_xlat4.x = texture(_NoiseTex01, u_xlat4.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_2NoiseTexToggle==1.0);
#else
    u_xlatb6 = _2NoiseTexToggle==1.0;
#endif
    if(u_xlatb6){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
        u_xlat1.xy = _Time.yy * vec2(_NoiseTex02_Uspeed, _NoiseTex02_Vspeed) + u_xlat1.xy;
        u_xlat10_6 = texture(_NoiseTex02, u_xlat1.xy).x;
        u_xlat4.x = u_xlat10_6 * u_xlat4.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexToggle==1.0);
#else
    u_xlatb6 = _NoiseTexToggle==1.0;
#endif
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat4.xx + u_xlat0.xy;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_MainColorToggle==1.0);
#else
    u_xlatb1 = _MainColorToggle==1.0;
#endif
    u_xlat1 = (bool(u_xlatb1)) ? _MainColor : vs_COLOR0;
    u_xlat0 = u_xlat10_0.wxyz * u_xlat1.wxyz;
    u_xlat2.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb2 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
        u_xlat10_2 = texture(_MaskTexture, u_xlat2.xy).x;
        u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    //ENDIF
    }
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
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
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _NoiseTexToggle;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Uspeed;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	float _2NoiseTexToggle;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _NoiseTex01_Uspeed;
uniform 	float _NoiseTex01_Vspeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_Uspeed;
uniform 	float _NoiseTex02_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _MaskTexToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat4;
lowp float u_xlat10_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_BaseTex_Uspeed, _BaseTex_Vspeed) + u_xlat0.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_NoiseTex01_Uspeed, _NoiseTex01_Vspeed) + u_xlat4.xy;
    u_xlat4.x = texture(_NoiseTex01, u_xlat4.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_2NoiseTexToggle==1.0);
#else
    u_xlatb6 = _2NoiseTexToggle==1.0;
#endif
    if(u_xlatb6){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
        u_xlat1.xy = _Time.yy * vec2(_NoiseTex02_Uspeed, _NoiseTex02_Vspeed) + u_xlat1.xy;
        u_xlat10_6 = texture(_NoiseTex02, u_xlat1.xy).x;
        u_xlat4.x = u_xlat10_6 * u_xlat4.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexToggle==1.0);
#else
    u_xlatb6 = _NoiseTexToggle==1.0;
#endif
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat4.xx + u_xlat0.xy;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_MainColorToggle==1.0);
#else
    u_xlatb1 = _MainColorToggle==1.0;
#endif
    u_xlat1 = (bool(u_xlatb1)) ? _MainColor : vs_COLOR0;
    u_xlat0 = u_xlat10_0.wxyz * u_xlat1.wxyz;
    u_xlat2.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb2 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
        u_xlat10_2 = texture(_MaskTexture, u_xlat2.xy).x;
        u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    //ENDIF
    }
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
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
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _NoiseTexToggle;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Uspeed;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	float _2NoiseTexToggle;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _NoiseTex01_Uspeed;
uniform 	float _NoiseTex01_Vspeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_Uspeed;
uniform 	float _NoiseTex02_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _MaskTexToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat4;
lowp float u_xlat10_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_BaseTex_Uspeed, _BaseTex_Vspeed) + u_xlat0.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_NoiseTex01_Uspeed, _NoiseTex01_Vspeed) + u_xlat4.xy;
    u_xlat4.x = texture(_NoiseTex01, u_xlat4.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_2NoiseTexToggle==1.0);
#else
    u_xlatb6 = _2NoiseTexToggle==1.0;
#endif
    if(u_xlatb6){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
        u_xlat1.xy = _Time.yy * vec2(_NoiseTex02_Uspeed, _NoiseTex02_Vspeed) + u_xlat1.xy;
        u_xlat10_6 = texture(_NoiseTex02, u_xlat1.xy).x;
        u_xlat4.x = u_xlat10_6 * u_xlat4.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexToggle==1.0);
#else
    u_xlatb6 = _NoiseTexToggle==1.0;
#endif
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat4.xx + u_xlat0.xy;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_MainColorToggle==1.0);
#else
    u_xlatb1 = _MainColorToggle==1.0;
#endif
    u_xlat1 = (bool(u_xlatb1)) ? _MainColor : vs_COLOR0;
    u_xlat0 = u_xlat10_0.wxyz * u_xlat1.wxyz;
    u_xlat2.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb2 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
        u_xlat10_2 = texture(_MaskTexture, u_xlat2.xy).x;
        u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    //ENDIF
    }
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
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
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _NoiseTexToggle;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Uspeed;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	float _2NoiseTexToggle;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _NoiseTex01_Uspeed;
uniform 	float _NoiseTex01_Vspeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_Uspeed;
uniform 	float _NoiseTex02_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _MaskTexToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat4;
lowp float u_xlat10_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_BaseTex_Uspeed, _BaseTex_Vspeed) + u_xlat0.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_NoiseTex01_Uspeed, _NoiseTex01_Vspeed) + u_xlat4.xy;
    u_xlat4.x = texture(_NoiseTex01, u_xlat4.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_2NoiseTexToggle==1.0);
#else
    u_xlatb6 = _2NoiseTexToggle==1.0;
#endif
    if(u_xlatb6){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
        u_xlat1.xy = _Time.yy * vec2(_NoiseTex02_Uspeed, _NoiseTex02_Vspeed) + u_xlat1.xy;
        u_xlat10_6 = texture(_NoiseTex02, u_xlat1.xy).x;
        u_xlat4.x = u_xlat10_6 * u_xlat4.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexToggle==1.0);
#else
    u_xlatb6 = _NoiseTexToggle==1.0;
#endif
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat4.xx + u_xlat0.xy;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_MainColorToggle==1.0);
#else
    u_xlatb1 = _MainColorToggle==1.0;
#endif
    u_xlat1 = (bool(u_xlatb1)) ? _MainColor : vs_COLOR0;
    u_xlat0 = u_xlat10_0.wxyz * u_xlat1.wxyz;
    u_xlat2.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb2 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
        u_xlat10_2 = texture(_MaskTexture, u_xlat2.xy).x;
        u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    //ENDIF
    }
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
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
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _NoiseTexToggle;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Uspeed;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	float _2NoiseTexToggle;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _NoiseTex01_Uspeed;
uniform 	float _NoiseTex01_Vspeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_Uspeed;
uniform 	float _NoiseTex02_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _MaskTexToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat4;
lowp float u_xlat10_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_BaseTex_Uspeed, _BaseTex_Vspeed) + u_xlat0.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_NoiseTex01_Uspeed, _NoiseTex01_Vspeed) + u_xlat4.xy;
    u_xlat4.x = texture(_NoiseTex01, u_xlat4.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_2NoiseTexToggle==1.0);
#else
    u_xlatb6 = _2NoiseTexToggle==1.0;
#endif
    if(u_xlatb6){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
        u_xlat1.xy = _Time.yy * vec2(_NoiseTex02_Uspeed, _NoiseTex02_Vspeed) + u_xlat1.xy;
        u_xlat10_6 = texture(_NoiseTex02, u_xlat1.xy).x;
        u_xlat4.x = u_xlat10_6 * u_xlat4.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexToggle==1.0);
#else
    u_xlatb6 = _NoiseTexToggle==1.0;
#endif
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat4.xx + u_xlat0.xy;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_MainColorToggle==1.0);
#else
    u_xlatb1 = _MainColorToggle==1.0;
#endif
    u_xlat1 = (bool(u_xlatb1)) ? _MainColor : vs_COLOR0;
    u_xlat0 = u_xlat10_0.wxyz * u_xlat1.wxyz;
    u_xlat2.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb2 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
        u_xlat10_2 = texture(_MaskTexture, u_xlat2.xy).x;
        u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    //ENDIF
    }
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
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
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _NoiseTexToggle;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Uspeed;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	float _2NoiseTexToggle;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _NoiseTex01_Uspeed;
uniform 	float _NoiseTex01_Vspeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_Uspeed;
uniform 	float _NoiseTex02_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _MaskTexToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat4;
lowp float u_xlat10_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_BaseTex_Uspeed, _BaseTex_Vspeed) + u_xlat0.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_NoiseTex01_Uspeed, _NoiseTex01_Vspeed) + u_xlat4.xy;
    u_xlat4.x = texture(_NoiseTex01, u_xlat4.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_2NoiseTexToggle==1.0);
#else
    u_xlatb6 = _2NoiseTexToggle==1.0;
#endif
    if(u_xlatb6){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
        u_xlat1.xy = _Time.yy * vec2(_NoiseTex02_Uspeed, _NoiseTex02_Vspeed) + u_xlat1.xy;
        u_xlat10_6 = texture(_NoiseTex02, u_xlat1.xy).x;
        u_xlat4.x = u_xlat10_6 * u_xlat4.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexToggle==1.0);
#else
    u_xlatb6 = _NoiseTexToggle==1.0;
#endif
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat4.xx + u_xlat0.xy;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_MainColorToggle==1.0);
#else
    u_xlatb1 = _MainColorToggle==1.0;
#endif
    u_xlat1 = (bool(u_xlatb1)) ? _MainColor : vs_COLOR0;
    u_xlat0 = u_xlat10_0.wxyz * u_xlat1.wxyz;
    u_xlat2.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb2 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
        u_xlat10_2 = texture(_MaskTexture, u_xlat2.xy).x;
        u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    //ENDIF
    }
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
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
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _NoiseTexToggle;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Uspeed;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	float _2NoiseTexToggle;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _NoiseTex01_Uspeed;
uniform 	float _NoiseTex01_Vspeed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_Uspeed;
uniform 	float _NoiseTex02_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _MaskTexToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat4;
lowp float u_xlat10_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_BaseTex_Uspeed, _BaseTex_Vspeed) + u_xlat0.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_NoiseTex01_Uspeed, _NoiseTex01_Vspeed) + u_xlat4.xy;
    u_xlat4.x = texture(_NoiseTex01, u_xlat4.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_2NoiseTexToggle==1.0);
#else
    u_xlatb6 = _2NoiseTexToggle==1.0;
#endif
    if(u_xlatb6){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
        u_xlat1.xy = _Time.yy * vec2(_NoiseTex02_Uspeed, _NoiseTex02_Vspeed) + u_xlat1.xy;
        u_xlat10_6 = texture(_NoiseTex02, u_xlat1.xy).x;
        u_xlat4.x = u_xlat10_6 * u_xlat4.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexToggle==1.0);
#else
    u_xlatb6 = _NoiseTexToggle==1.0;
#endif
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat4.xx + u_xlat0.xy;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_MainColorToggle==1.0);
#else
    u_xlatb1 = _MainColorToggle==1.0;
#endif
    u_xlat1 = (bool(u_xlatb1)) ? _MainColor : vs_COLOR0;
    u_xlat0 = u_xlat10_0.wxyz * u_xlat1.wxyz;
    u_xlat2.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_MaskTexToggle==1.0);
#else
    u_xlatb2 = _MaskTexToggle==1.0;
#endif
    if(u_xlatb2){
        u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
        u_xlat10_2 = texture(_MaskTexture, u_xlat2.xy).x;
        u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    //ENDIF
    }
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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