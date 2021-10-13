//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Face/Face Part Expression Test" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionFactor ("Emission Factor", Range(0, 10)) = 1
_Blend ("Switch to closed eye textures", Range(0, 1)) = 0
_MainTex ("Base (RGB)", 2D) = "white" { }
_ClosedEyeTex ("Closed Eye Tex (RGB)", 2D) = "white" { }
_ColorToOffset ("Color To Tune", Color) = (0,0,0,0)
_ColorTolerance ("Color Tolerance", Range(0.01, 1)) = 0
_HueOffset ("Hue Offset", Range(0, 1)) = 0
_SaturateOffset ("Satureate Offset", Range(-1, 1)) = 0
_ValueOffset ("Value Offset", Range(-1, 1)) = 0
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Offset -2, -2
  GpuProgramID 34170
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ClosedEyeTex_ST;
uniform 	mediump vec3 _ColorToOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
ivec3 u_xlati1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
int u_xlati8;
bool u_xlatb8;
mediump vec2 u_xlat16_10;
mediump float u_xlat16_14;
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
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _ClosedEyeTex_ST.xy + _ClosedEyeTex_ST.zw;
    u_xlat16_2.x = (-_ColorToOffset.x) + _ColorToOffset.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati8 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati8) != 0) ? _ColorToOffset.xy : _ColorToOffset.yx;
    u_xlat16_10.x = (-u_xlat16_2.x) + _ColorToOffset.z;
    u_xlat16_10.x = u_xlat16_10.x + 1.0;
    u_xlat16_10.x = floor(u_xlat16_10.x);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlati8 = int(u_xlat16_10.x);
    u_xlat16_2.x = (u_xlati8 != 0) ? u_xlat16_2.x : _ColorToOffset.z;
    u_xlat16_10.x = u_xlat16_2.y + (-_ColorToOffset.z);
    u_xlat16_10.x = u_xlat16_10.x + 1.0;
    u_xlat16_10.x = floor(u_xlat16_10.x);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlati8 = int(u_xlat16_10.x);
    u_xlat16_6 = (u_xlati8 != 0) ? u_xlat16_2.y : _ColorToOffset.z;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_6;
    u_xlat16_3.xyz = vec3(u_xlat16_6) + (-_ColorToOffset.yzx);
    u_xlat16_3.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_3.xyz;
    u_xlat16_10.x = u_xlat16_2.x * 6.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz / u_xlat16_10.xxx;
    u_xlat16_10.xy = u_xlat16_3.zx + vec2(0.333333343, 0.666666687);
    u_xlat16_10.xy = vec2((-u_xlat16_3.y) + u_xlat16_10.x, (-u_xlat16_3.z) + u_xlat16_10.y);
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = (-vec3(u_xlat16_6)) + _ColorToOffset.xyz;
    u_xlat16_7.xyz = abs(u_xlat16_7.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_7.xyz = floor(u_xlat16_7.xyz);
    u_xlati1.xyz = ivec3(u_xlat16_7.xyz);
    u_xlat16_14 = (u_xlati1.z != 0) ? 0.0 : u_xlat16_10.y;
    u_xlat16_10.x = (u_xlati1.y != 0) ? u_xlat16_14 : u_xlat16_10.x;
    u_xlat16_3.x = (u_xlati1.x != 0) ? u_xlat16_10.x : u_xlat16_3.x;
    u_xlat16_3.y = u_xlat16_2.x / u_xlat16_6;
    vs_TEXCOORD2.z = u_xlat16_6;
    u_xlat16_2.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlati8 = int(u_xlat16_2.x);
    vs_TEXCOORD2.xy = (int(u_xlati8) != 0) ? u_xlat16_3.xy : vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Blend;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ClosedEyeTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Blend>=0.5);
#else
    u_xlatb0 = _Blend>=0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_ClosedEyeTex, vs_TEXCOORD1.xy);
        u_xlat16_1 = u_xlat10_0;
    } else {
        u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat16_1 = u_xlat10_0;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ClosedEyeTex_ST;
uniform 	mediump vec3 _ColorToOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
ivec3 u_xlati1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
int u_xlati8;
bool u_xlatb8;
mediump vec2 u_xlat16_10;
mediump float u_xlat16_14;
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
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _ClosedEyeTex_ST.xy + _ClosedEyeTex_ST.zw;
    u_xlat16_2.x = (-_ColorToOffset.x) + _ColorToOffset.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati8 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati8) != 0) ? _ColorToOffset.xy : _ColorToOffset.yx;
    u_xlat16_10.x = (-u_xlat16_2.x) + _ColorToOffset.z;
    u_xlat16_10.x = u_xlat16_10.x + 1.0;
    u_xlat16_10.x = floor(u_xlat16_10.x);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlati8 = int(u_xlat16_10.x);
    u_xlat16_2.x = (u_xlati8 != 0) ? u_xlat16_2.x : _ColorToOffset.z;
    u_xlat16_10.x = u_xlat16_2.y + (-_ColorToOffset.z);
    u_xlat16_10.x = u_xlat16_10.x + 1.0;
    u_xlat16_10.x = floor(u_xlat16_10.x);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlati8 = int(u_xlat16_10.x);
    u_xlat16_6 = (u_xlati8 != 0) ? u_xlat16_2.y : _ColorToOffset.z;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_6;
    u_xlat16_3.xyz = vec3(u_xlat16_6) + (-_ColorToOffset.yzx);
    u_xlat16_3.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_3.xyz;
    u_xlat16_10.x = u_xlat16_2.x * 6.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz / u_xlat16_10.xxx;
    u_xlat16_10.xy = u_xlat16_3.zx + vec2(0.333333343, 0.666666687);
    u_xlat16_10.xy = vec2((-u_xlat16_3.y) + u_xlat16_10.x, (-u_xlat16_3.z) + u_xlat16_10.y);
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = (-vec3(u_xlat16_6)) + _ColorToOffset.xyz;
    u_xlat16_7.xyz = abs(u_xlat16_7.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_7.xyz = floor(u_xlat16_7.xyz);
    u_xlati1.xyz = ivec3(u_xlat16_7.xyz);
    u_xlat16_14 = (u_xlati1.z != 0) ? 0.0 : u_xlat16_10.y;
    u_xlat16_10.x = (u_xlati1.y != 0) ? u_xlat16_14 : u_xlat16_10.x;
    u_xlat16_3.x = (u_xlati1.x != 0) ? u_xlat16_10.x : u_xlat16_3.x;
    u_xlat16_3.y = u_xlat16_2.x / u_xlat16_6;
    vs_TEXCOORD2.z = u_xlat16_6;
    u_xlat16_2.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlati8 = int(u_xlat16_2.x);
    vs_TEXCOORD2.xy = (int(u_xlati8) != 0) ? u_xlat16_3.xy : vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Blend;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ClosedEyeTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Blend>=0.5);
#else
    u_xlatb0 = _Blend>=0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_ClosedEyeTex, vs_TEXCOORD1.xy);
        u_xlat16_1 = u_xlat10_0;
    } else {
        u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat16_1 = u_xlat10_0;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ClosedEyeTex_ST;
uniform 	mediump vec3 _ColorToOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
ivec3 u_xlati1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
int u_xlati8;
bool u_xlatb8;
mediump vec2 u_xlat16_10;
mediump float u_xlat16_14;
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
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _ClosedEyeTex_ST.xy + _ClosedEyeTex_ST.zw;
    u_xlat16_2.x = (-_ColorToOffset.x) + _ColorToOffset.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati8 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati8) != 0) ? _ColorToOffset.xy : _ColorToOffset.yx;
    u_xlat16_10.x = (-u_xlat16_2.x) + _ColorToOffset.z;
    u_xlat16_10.x = u_xlat16_10.x + 1.0;
    u_xlat16_10.x = floor(u_xlat16_10.x);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlati8 = int(u_xlat16_10.x);
    u_xlat16_2.x = (u_xlati8 != 0) ? u_xlat16_2.x : _ColorToOffset.z;
    u_xlat16_10.x = u_xlat16_2.y + (-_ColorToOffset.z);
    u_xlat16_10.x = u_xlat16_10.x + 1.0;
    u_xlat16_10.x = floor(u_xlat16_10.x);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlati8 = int(u_xlat16_10.x);
    u_xlat16_6 = (u_xlati8 != 0) ? u_xlat16_2.y : _ColorToOffset.z;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_6;
    u_xlat16_3.xyz = vec3(u_xlat16_6) + (-_ColorToOffset.yzx);
    u_xlat16_3.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_3.xyz;
    u_xlat16_10.x = u_xlat16_2.x * 6.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz / u_xlat16_10.xxx;
    u_xlat16_10.xy = u_xlat16_3.zx + vec2(0.333333343, 0.666666687);
    u_xlat16_10.xy = vec2((-u_xlat16_3.y) + u_xlat16_10.x, (-u_xlat16_3.z) + u_xlat16_10.y);
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = (-vec3(u_xlat16_6)) + _ColorToOffset.xyz;
    u_xlat16_7.xyz = abs(u_xlat16_7.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_7.xyz = floor(u_xlat16_7.xyz);
    u_xlati1.xyz = ivec3(u_xlat16_7.xyz);
    u_xlat16_14 = (u_xlati1.z != 0) ? 0.0 : u_xlat16_10.y;
    u_xlat16_10.x = (u_xlati1.y != 0) ? u_xlat16_14 : u_xlat16_10.x;
    u_xlat16_3.x = (u_xlati1.x != 0) ? u_xlat16_10.x : u_xlat16_3.x;
    u_xlat16_3.y = u_xlat16_2.x / u_xlat16_6;
    vs_TEXCOORD2.z = u_xlat16_6;
    u_xlat16_2.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlati8 = int(u_xlat16_2.x);
    vs_TEXCOORD2.xy = (int(u_xlati8) != 0) ? u_xlat16_3.xy : vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Blend;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ClosedEyeTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Blend>=0.5);
#else
    u_xlatb0 = _Blend>=0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_ClosedEyeTex, vs_TEXCOORD1.xy);
        u_xlat16_1 = u_xlat10_0;
    } else {
        u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat16_1 = u_xlat10_0;
    //ENDIF
    }
    u_xlat16_1.w = u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
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
}
}
 Pass {
  Name "CONSTANT_REPLACE"
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 76345
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
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
}
}
}
Fallback "Diffuse"
}