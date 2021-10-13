//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Simple/Simple_Star_Clamp_Elite" {
Properties {
_Colortop ("Color Top", Color) = (0.02,0.04,0.09,1)
_Colorbottom ("Color Bottom", Color) = (0.27,0.16,0.37,1)
_BottomPos ("Gradient Offset", Range(-2, 2)) = 0
_BottonWidth ("Gradient Width", Range(0, 2)) = 1
_RimColor ("Rim Color", Color) = (0.42,0.46,1,1)
_RimPow ("Rim Width", Float) = 1
[Toggle] _RimTransparent ("Rim Range Change Transparent", Float) = 1
_RimPow2 ("Rim Transparent", Float) = 1
_Opaqueness ("Total Opaquness", Range(0, 1)) = 1
_RimSterngth ("Rim Strength", Float) = 1
_TwinkleTex ("Twinkle Tex (RGBA)", 2D) = "black" { }
_StarColor ("Star Color", Color) = (1,1,1,1)
_StarCenter ("Star Center", Vector) = (0,0,0,0)
_StarEmission ("Star Emission", Range(1, 100)) = 1
_SpeedX ("Speed X of Star Move", Range(-0.1, 0)) = -0.03
_SpeedY ("Speed Y of Star Move", Range(-0.1, 0)) = -0.03
_DispearDistance ("Dispear Distance", Range(0, 1)) = 0.7
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Outline ("Outline Width", Float) = 0.02
[Toggle] _OutlineUseTangent ("Use Tangent For Outline", Float) = 0
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_EliteColor1 ("Elite Color 1", Color) = (1,0.8,0,0.7)
_EliteEmissionScaler1 ("Elite Emission Scaler 1", Range(1, 10)) = 1
_EliteNormalDisplacement1 ("Elite Normal Displacment 1", Range(0, 0.1)) = 0.02
_EliteColor2 ("Elite Color 2", Color) = (1,0.85,0.27,0.27)
_EliteEmissionScaler2 ("Elite Emission Scaler 2", Range(1, 10)) = 1
_EliteNormalDisplacement2 ("Elite Normal Displacment 2", Range(0, 0.1)) = 0.04
_EliteColor3 ("Elite Color 3", Color) = (1,0.89,0.45,0.15)
_EliteEmissionScaler3 ("Elite Emission Scaler 3", Range(1, 10)) = 1
_EliteNormalDisplacement3 ("Elite Normal Displacment 3", Range(0, 0.1)) = 0
_EliteBloomFactor ("Elite Bloom Factor (only for layer 3)", Float) = 1
_SPCubeMap ("SP CubeMap", Cube) = "white" { }
_SPCubeMapColor ("SP CubeMap Color", Color) = (1,1,1,0)
_SPCubeMapOffset ("SP CubeMap Offset", Vector) = (0,0,0,0)
_SPCubeMapIntensity ("SP CubeMap Intensity", Range(0, 1)) = 0
_SPCubeMapNoiseIntensity ("SP CubeMap Noise Intensity", Range(0, 5)) = 0
_SPCubeMapBrightness ("SP CubeMap Brightness", Float) = 1.26
_SPOldColor ("SP Old Color", Color) = (1,1,1,0)
[Toggle] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
[Toggle] _SideRim ("SideRim", Float) = 0
_RimLightDir ("Rim Light Dir", Vector) = (1,1,1,1)
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 25522
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _StarCenter;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2 = u_xlat0.xyzy / u_xlat0.wwww;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = u_xlat0.zw;
    u_xlat1.x = float(0.5);
    u_xlat1.z = float(0.5);
    u_xlat1.y = _ProjectionParams.x;
    u_xlat0.xyz = vec3(u_xlat0.x * u_xlat1.z, u_xlat0.y * u_xlat1.y, u_xlat0.w * u_xlat1.z);
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1] * _StarCenter.yyyy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * _StarCenter.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * _StarCenter.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat0.xyw;
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] / hlslcc_mtx4x4unity_ObjectToWorld[3].wwww;
    vs_TEXCOORD4 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _StarEmission;
uniform 	vec4 _Colortop;
uniform 	vec4 _Colorbottom;
uniform 	vec4 _RimColor;
uniform 	float _RimPow;
uniform 	float _RimPow2;
uniform 	float _RimSterngth;
uniform 	float _BottomPos;
uniform 	float _BottonWidth;
uniform 	float _SpeedX;
uniform 	float _SpeedY;
uniform 	mediump vec4 _StarColor;
uniform 	vec4 _TwinkleTex_ST;
uniform 	float _DispearDistance;
uniform 	vec4 _RimLightDir;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _RimTransparent;
uniform 	mediump float _SideRim;
uniform lowp sampler2D _TwinkleTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
vec2 u_xlat10;
mediump float u_xlat16_10;
mediump vec2 u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w * 0.5;
    u_xlat5.x = (-vs_TEXCOORD1.w) * 0.5 + vs_TEXCOORD1.y;
    u_xlat0.y = u_xlat5.x * _ProjectionParams.x + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat16_1.xy = u_xlat0.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = vs_TEXCOORD0.w * 0.5;
    u_xlat5.x = (-vs_TEXCOORD0.w) * 0.5 + vs_TEXCOORD0.y;
    u_xlat0.y = u_xlat5.x * _ProjectionParams.x + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat16_11.xy = u_xlat0.xy / vs_TEXCOORD0.ww;
    u_xlat16_0.xy = (-u_xlat16_1.xy) + u_xlat16_11.xy;
    u_xlat16_10 = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_10 = sqrt(u_xlat16_10);
    u_xlat15 = (-u_xlat16_10) + _DispearDistance;
    u_xlat16_10 = float(1.0) / (-u_xlat16_10);
    u_xlat10.x = u_xlat16_10 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat10.x * -2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat2.xy = (-vs_TEXCOORD3.xz) + _WorldSpaceCameraPos.xz;
    u_xlat15 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat0.xy = vec2(u_xlat15) * u_xlat16_0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001);
    u_xlat0.xy = _Time.yy * vec2(_SpeedX, _SpeedY) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _TwinkleTex_ST.xy;
    u_xlat10_1 = texture(_TwinkleTex, u_xlat0.xy);
    u_xlat16_0.x = u_xlat10_1.w * _StarEmission;
    u_xlat0.x = u_xlat16_0.x * u_xlat10.x;
    u_xlat5.x = dot(_RimLightDir.xyz, _RimLightDir.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * _RimLightDir.xyz;
    u_xlat2.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_NORMAL0.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat3.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_10 = log2(u_xlat16_4.x);
    u_xlat10.xy = vec2(u_xlat16_10) * vec2(_RimPow, _RimPow2);
    u_xlat10.xy = exp2(u_xlat10.xy);
    u_xlat2.x = min(_RimSterngth, 1.0);
    u_xlat10.xy = u_xlat10.yx * u_xlat2.xx;
    u_xlat5.x = (u_xlatb5) ? 0.0 : u_xlat10.y;
    u_xlatb2.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_SideRim, _RimTransparent, _SideRim, _SideRim)).xy;
    u_xlat5.x = (u_xlatb2.x) ? u_xlat5.x : u_xlat10.y;
    u_xlat10.x = u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    SV_Target0.w = (u_xlatb2.y) ? _Opaqueness : u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.5<u_xlat5.x);
#else
    u_xlatb5 = 0.5<u_xlat5.x;
#endif
    u_xlat10.x = vs_TEXCOORD3.y + (-_BottomPos);
    u_xlat10.x = (-u_xlat10.x) + vs_TEXCOORD2.w;
    u_xlat10.x = u_xlat10.x / _BottonWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = _Colortop.xyz + (-_Colorbottom.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz + _Colorbottom.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? _RimColor.xyz : u_xlat2.xyz;
    u_xlat16_5.xyz = u_xlat10_1.xyz * _StarColor.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _StarCenter;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2 = u_xlat0.xyzy / u_xlat0.wwww;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = u_xlat0.zw;
    u_xlat1.x = float(0.5);
    u_xlat1.z = float(0.5);
    u_xlat1.y = _ProjectionParams.x;
    u_xlat0.xyz = vec3(u_xlat0.x * u_xlat1.z, u_xlat0.y * u_xlat1.y, u_xlat0.w * u_xlat1.z);
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1] * _StarCenter.yyyy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * _StarCenter.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * _StarCenter.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat0.xyw;
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] / hlslcc_mtx4x4unity_ObjectToWorld[3].wwww;
    vs_TEXCOORD4 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _StarEmission;
uniform 	vec4 _Colortop;
uniform 	vec4 _Colorbottom;
uniform 	vec4 _RimColor;
uniform 	float _RimPow;
uniform 	float _RimPow2;
uniform 	float _RimSterngth;
uniform 	float _BottomPos;
uniform 	float _BottonWidth;
uniform 	float _SpeedX;
uniform 	float _SpeedY;
uniform 	mediump vec4 _StarColor;
uniform 	vec4 _TwinkleTex_ST;
uniform 	float _DispearDistance;
uniform 	vec4 _RimLightDir;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _RimTransparent;
uniform 	mediump float _SideRim;
uniform lowp sampler2D _TwinkleTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
vec2 u_xlat10;
mediump float u_xlat16_10;
mediump vec2 u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w * 0.5;
    u_xlat5.x = (-vs_TEXCOORD1.w) * 0.5 + vs_TEXCOORD1.y;
    u_xlat0.y = u_xlat5.x * _ProjectionParams.x + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat16_1.xy = u_xlat0.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = vs_TEXCOORD0.w * 0.5;
    u_xlat5.x = (-vs_TEXCOORD0.w) * 0.5 + vs_TEXCOORD0.y;
    u_xlat0.y = u_xlat5.x * _ProjectionParams.x + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat16_11.xy = u_xlat0.xy / vs_TEXCOORD0.ww;
    u_xlat16_0.xy = (-u_xlat16_1.xy) + u_xlat16_11.xy;
    u_xlat16_10 = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_10 = sqrt(u_xlat16_10);
    u_xlat15 = (-u_xlat16_10) + _DispearDistance;
    u_xlat16_10 = float(1.0) / (-u_xlat16_10);
    u_xlat10.x = u_xlat16_10 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat10.x * -2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat2.xy = (-vs_TEXCOORD3.xz) + _WorldSpaceCameraPos.xz;
    u_xlat15 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat0.xy = vec2(u_xlat15) * u_xlat16_0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001);
    u_xlat0.xy = _Time.yy * vec2(_SpeedX, _SpeedY) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _TwinkleTex_ST.xy;
    u_xlat10_1 = texture(_TwinkleTex, u_xlat0.xy);
    u_xlat16_0.x = u_xlat10_1.w * _StarEmission;
    u_xlat0.x = u_xlat16_0.x * u_xlat10.x;
    u_xlat5.x = dot(_RimLightDir.xyz, _RimLightDir.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * _RimLightDir.xyz;
    u_xlat2.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_NORMAL0.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat3.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_10 = log2(u_xlat16_4.x);
    u_xlat10.xy = vec2(u_xlat16_10) * vec2(_RimPow, _RimPow2);
    u_xlat10.xy = exp2(u_xlat10.xy);
    u_xlat2.x = min(_RimSterngth, 1.0);
    u_xlat10.xy = u_xlat10.yx * u_xlat2.xx;
    u_xlat5.x = (u_xlatb5) ? 0.0 : u_xlat10.y;
    u_xlatb2.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_SideRim, _RimTransparent, _SideRim, _SideRim)).xy;
    u_xlat5.x = (u_xlatb2.x) ? u_xlat5.x : u_xlat10.y;
    u_xlat10.x = u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    SV_Target0.w = (u_xlatb2.y) ? _Opaqueness : u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.5<u_xlat5.x);
#else
    u_xlatb5 = 0.5<u_xlat5.x;
#endif
    u_xlat10.x = vs_TEXCOORD3.y + (-_BottomPos);
    u_xlat10.x = (-u_xlat10.x) + vs_TEXCOORD2.w;
    u_xlat10.x = u_xlat10.x / _BottonWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = _Colortop.xyz + (-_Colorbottom.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz + _Colorbottom.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? _RimColor.xyz : u_xlat2.xyz;
    u_xlat16_5.xyz = u_xlat10_1.xyz * _StarColor.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _StarCenter;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2 = u_xlat0.xyzy / u_xlat0.wwww;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = u_xlat0.zw;
    u_xlat1.x = float(0.5);
    u_xlat1.z = float(0.5);
    u_xlat1.y = _ProjectionParams.x;
    u_xlat0.xyz = vec3(u_xlat0.x * u_xlat1.z, u_xlat0.y * u_xlat1.y, u_xlat0.w * u_xlat1.z);
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1] * _StarCenter.yyyy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * _StarCenter.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * _StarCenter.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat0.xyw;
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] / hlslcc_mtx4x4unity_ObjectToWorld[3].wwww;
    vs_TEXCOORD4 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _StarEmission;
uniform 	vec4 _Colortop;
uniform 	vec4 _Colorbottom;
uniform 	vec4 _RimColor;
uniform 	float _RimPow;
uniform 	float _RimPow2;
uniform 	float _RimSterngth;
uniform 	float _BottomPos;
uniform 	float _BottonWidth;
uniform 	float _SpeedX;
uniform 	float _SpeedY;
uniform 	mediump vec4 _StarColor;
uniform 	vec4 _TwinkleTex_ST;
uniform 	float _DispearDistance;
uniform 	vec4 _RimLightDir;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _RimTransparent;
uniform 	mediump float _SideRim;
uniform lowp sampler2D _TwinkleTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
vec2 u_xlat10;
mediump float u_xlat16_10;
mediump vec2 u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w * 0.5;
    u_xlat5.x = (-vs_TEXCOORD1.w) * 0.5 + vs_TEXCOORD1.y;
    u_xlat0.y = u_xlat5.x * _ProjectionParams.x + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat16_1.xy = u_xlat0.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = vs_TEXCOORD0.w * 0.5;
    u_xlat5.x = (-vs_TEXCOORD0.w) * 0.5 + vs_TEXCOORD0.y;
    u_xlat0.y = u_xlat5.x * _ProjectionParams.x + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat16_11.xy = u_xlat0.xy / vs_TEXCOORD0.ww;
    u_xlat16_0.xy = (-u_xlat16_1.xy) + u_xlat16_11.xy;
    u_xlat16_10 = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_10 = sqrt(u_xlat16_10);
    u_xlat15 = (-u_xlat16_10) + _DispearDistance;
    u_xlat16_10 = float(1.0) / (-u_xlat16_10);
    u_xlat10.x = u_xlat16_10 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat10.x * -2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat2.xy = (-vs_TEXCOORD3.xz) + _WorldSpaceCameraPos.xz;
    u_xlat15 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat0.xy = vec2(u_xlat15) * u_xlat16_0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001);
    u_xlat0.xy = _Time.yy * vec2(_SpeedX, _SpeedY) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _TwinkleTex_ST.xy;
    u_xlat10_1 = texture(_TwinkleTex, u_xlat0.xy);
    u_xlat16_0.x = u_xlat10_1.w * _StarEmission;
    u_xlat0.x = u_xlat16_0.x * u_xlat10.x;
    u_xlat5.x = dot(_RimLightDir.xyz, _RimLightDir.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * _RimLightDir.xyz;
    u_xlat2.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_NORMAL0.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat3.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_10 = log2(u_xlat16_4.x);
    u_xlat10.xy = vec2(u_xlat16_10) * vec2(_RimPow, _RimPow2);
    u_xlat10.xy = exp2(u_xlat10.xy);
    u_xlat2.x = min(_RimSterngth, 1.0);
    u_xlat10.xy = u_xlat10.yx * u_xlat2.xx;
    u_xlat5.x = (u_xlatb5) ? 0.0 : u_xlat10.y;
    u_xlatb2.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_SideRim, _RimTransparent, _SideRim, _SideRim)).xy;
    u_xlat5.x = (u_xlatb2.x) ? u_xlat5.x : u_xlat10.y;
    u_xlat10.x = u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    SV_Target0.w = (u_xlatb2.y) ? _Opaqueness : u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.5<u_xlat5.x);
#else
    u_xlatb5 = 0.5<u_xlat5.x;
#endif
    u_xlat10.x = vs_TEXCOORD3.y + (-_BottomPos);
    u_xlat10.x = (-u_xlat10.x) + vs_TEXCOORD2.w;
    u_xlat10.x = u_xlat10.x / _BottonWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = _Colortop.xyz + (-_Colorbottom.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz + _Colorbottom.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb5)) ? _RimColor.xyz : u_xlat2.xyz;
    u_xlat16_5.xyz = u_xlat10_1.xyz * _StarColor.xyz + (-u_xlat16_4.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
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
}
}
 Pass {
  Name "OUTLINE"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 83854
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	mediump float _OutlineUseTangent;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent);
#endif
    u_xlat1.xyz = (bool(u_xlatb9)) ? in_TANGENT0.xyz : in_NORMAL0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position = u_xlat1;
    vs_COLOR0 = _OutlineColor;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
    vs_TEXCOORD0.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _Opaqueness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD0.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.yx / vs_TEXCOORD0.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD0.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	mediump float _OutlineUseTangent;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent);
#endif
    u_xlat1.xyz = (bool(u_xlatb9)) ? in_TANGENT0.xyz : in_NORMAL0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position = u_xlat1;
    vs_COLOR0 = _OutlineColor;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
    vs_TEXCOORD0.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _Opaqueness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD0.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.yx / vs_TEXCOORD0.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD0.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	mediump float _OutlineUseTangent;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent);
#endif
    u_xlat1.xyz = (bool(u_xlatb9)) ? in_TANGENT0.xyz : in_NORMAL0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position = u_xlat1;
    vs_COLOR0 = _OutlineColor;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
    vs_TEXCOORD0.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _Opaqueness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD0.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.yx / vs_TEXCOORD0.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD0.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz;
    SV_Target0.w = _Opaqueness;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	mediump float _OutlineUseTangent;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent);
#endif
    u_xlat1.xyz = (bool(u_xlatb9)) ? in_TANGENT0.xyz : in_NORMAL0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position = u_xlat1;
    vs_COLOR0 = _OutlineColor;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
    vs_TEXCOORD0.z = _DitherAlpha;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat3.x = u_xlat0.w + u_xlat0.y;
    u_xlat9 = u_xlat0.x * in_POSITION0.x;
    u_xlat1.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat1.y = u_xlat9 * 0.25 + u_xlat3.x;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _SPNoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD0.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.yx / vs_TEXCOORD0.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD0.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0.xyz = (int(u_xlati0) != 0) ? _SPOutlineColor.xyz : vs_COLOR0.xyz;
    u_xlat16_0.w = _Opaqueness;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	mediump float _OutlineUseTangent;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent);
#endif
    u_xlat1.xyz = (bool(u_xlatb9)) ? in_TANGENT0.xyz : in_NORMAL0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position = u_xlat1;
    vs_COLOR0 = _OutlineColor;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
    vs_TEXCOORD0.z = _DitherAlpha;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat3.x = u_xlat0.w + u_xlat0.y;
    u_xlat9 = u_xlat0.x * in_POSITION0.x;
    u_xlat1.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat1.y = u_xlat9 * 0.25 + u_xlat3.x;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _SPNoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD0.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.yx / vs_TEXCOORD0.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD0.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0.xyz = (int(u_xlati0) != 0) ? _SPOutlineColor.xyz : vs_COLOR0.xyz;
    u_xlat16_0.w = _Opaqueness;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	mediump float _OutlineUseTangent;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent);
#endif
    u_xlat1.xyz = (bool(u_xlatb9)) ? in_TANGENT0.xyz : in_NORMAL0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position = u_xlat1;
    vs_COLOR0 = _OutlineColor;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
    vs_TEXCOORD0.z = _DitherAlpha;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat3.x = u_xlat0.w + u_xlat0.y;
    u_xlat9 = u_xlat0.x * in_POSITION0.x;
    u_xlat1.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat1.y = u_xlat9 * 0.25 + u_xlat3.x;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _SPNoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD0.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.yx / vs_TEXCOORD0.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD0.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0.xyz = (int(u_xlati0) != 0) ? _SPOutlineColor.xyz : vs_COLOR0.xyz;
    u_xlat16_0.w = _Opaqueness;
    SV_Target0 = u_xlat16_0;
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
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
}
}
}
Fallback "Diffuse"
}