//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Avatar/Avatar UI Hair" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_LightMapTex ("Light Map Tex (RGB)", 2D) = "gray" { }
_LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
_LightArea ("Light Area Threshold", Range(0, 1)) = 0.51
_SecondShadow ("Second Shadow Threshold", Range(0, 1)) = 0.51
_FirstShadowMultColor ("First Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
_SecondShadowMultColor ("Second Shadow Multiply Color", Color) = (0.75,0.6,0.65,1)
_Shininess ("Specular Shininess", Range(0.1, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_OutlineCamStart ("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
_DirectionalFadeDirection ("Directional Fade Direction (world space)", Vector) = (0,-1,0,0)
_DirectionalFadeOffset ("Directional Fade Offset (object space)", Float) = 0
_DirectionalFadeRange ("Directional Fade Range", Range(0.01, 2)) = 0.1
_DirectionalFadeValue ("Directional Fade Value", Range(0, 1)) = 1
[Toggle(LOOKUP_COLOR)] _LookupColor ("Lookup Color", Float) = 0
[Toggle(LOOKUP_COLOR_BILINEAR)] _LookupColorBilinear ("Lookup Color Bilinear", Float) = 0
_factorTex ("Factor Tex", 2D) = "white" { }
_indexTex ("Index Tex", 2D) = "white" { }
_tableTex ("Lookup Tex", 2D) = "white" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "Reflected" = "Reflected" "RenderType" = "Transparent" }
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "Reflected" = "Reflected" "RenderType" = "Transparent" }
  GpuProgramID 53189
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump float vs_TEXCOORD3;
out mediump float vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = _DirectionalFadeValue + -1.0;
    u_xlat0.z = u_xlat0.x * u_xlat3 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_2.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.w = u_xlat16_2.x * 0.497500002 + 0.5;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.z;
vs_COLOR1 = phase0_Output0_2.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump float vs_COLOR1;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
int u_xlati6;
bool u_xlatb6;
float u_xlat18;
int u_xlati18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat18 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_1.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat2.xy = u_xlat16_1.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_1.x = (u_xlati18 != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_1.x = u_xlat16_1.x + vs_COLOR1;
    u_xlat16_1.x = u_xlat16_1.x * 0.5 + (-_LightArea);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati18 = int(u_xlat16_1.x);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (int(u_xlati18) != 0) ? u_xlat2.xyz : u_xlat16_1.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_19 = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_19 = u_xlat16_19 * 0.5 + (-_SecondShadow);
    u_xlat16_19 = u_xlat16_19 + 1.0;
    u_xlat16_19 = floor(u_xlat16_19);
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlati18 = int(u_xlat16_19);
    u_xlat16_1.xyz = (int(u_xlati18) != 0) ? u_xlat16_1.xyz : u_xlat16_4.xyz;
    u_xlat6 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_1.xyz = (int(u_xlati6) != 0) ? u_xlat16_3.xyz : u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat6) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat6) + (-_WorldSpaceLightPos0.xyz);
    u_xlat2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
    u_xlat6 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat6) + _CustomLightDir.xyz;
    u_xlat16_19 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_3.xyz = vec3(u_xlat16_19) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb6 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb6)) ? u_xlat16_3.xyz : u_xlat2.xyz;
    u_xlat16_19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_4.xyz = vec3(u_xlat16_19) * vs_TEXCOORD1.xyz;
    u_xlat16_19 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlat16_19 = log2(u_xlat16_19);
    u_xlat16_19 = u_xlat16_19 * _Shininess;
    u_xlat16_19 = exp2(u_xlat16_19);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_19) + u_xlat16_6;
    u_xlat6 = u_xlat16_6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati6) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump float vs_TEXCOORD3;
out mediump float vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = _DirectionalFadeValue + -1.0;
    u_xlat0.z = u_xlat0.x * u_xlat3 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_2.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.w = u_xlat16_2.x * 0.497500002 + 0.5;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.z;
vs_COLOR1 = phase0_Output0_2.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump float vs_COLOR1;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
int u_xlati6;
bool u_xlatb6;
float u_xlat18;
int u_xlati18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat18 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_1.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat2.xy = u_xlat16_1.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_1.x = (u_xlati18 != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_1.x = u_xlat16_1.x + vs_COLOR1;
    u_xlat16_1.x = u_xlat16_1.x * 0.5 + (-_LightArea);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati18 = int(u_xlat16_1.x);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (int(u_xlati18) != 0) ? u_xlat2.xyz : u_xlat16_1.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_19 = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_19 = u_xlat16_19 * 0.5 + (-_SecondShadow);
    u_xlat16_19 = u_xlat16_19 + 1.0;
    u_xlat16_19 = floor(u_xlat16_19);
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlati18 = int(u_xlat16_19);
    u_xlat16_1.xyz = (int(u_xlati18) != 0) ? u_xlat16_1.xyz : u_xlat16_4.xyz;
    u_xlat6 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_1.xyz = (int(u_xlati6) != 0) ? u_xlat16_3.xyz : u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat6) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat6) + (-_WorldSpaceLightPos0.xyz);
    u_xlat2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
    u_xlat6 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat6) + _CustomLightDir.xyz;
    u_xlat16_19 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_3.xyz = vec3(u_xlat16_19) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb6 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb6)) ? u_xlat16_3.xyz : u_xlat2.xyz;
    u_xlat16_19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_4.xyz = vec3(u_xlat16_19) * vs_TEXCOORD1.xyz;
    u_xlat16_19 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlat16_19 = log2(u_xlat16_19);
    u_xlat16_19 = u_xlat16_19 * _Shininess;
    u_xlat16_19 = exp2(u_xlat16_19);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_19) + u_xlat16_6;
    u_xlat6 = u_xlat16_6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati6) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump float vs_TEXCOORD3;
out mediump float vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = _DirectionalFadeValue + -1.0;
    u_xlat0.z = u_xlat0.x * u_xlat3 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_2.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.w = u_xlat16_2.x * 0.497500002 + 0.5;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.z;
vs_COLOR1 = phase0_Output0_2.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump float vs_COLOR1;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
int u_xlati6;
bool u_xlatb6;
float u_xlat18;
int u_xlati18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat18 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_1.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat2.xy = u_xlat16_1.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_1.x = (u_xlati18 != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_1.x = u_xlat16_1.x + vs_COLOR1;
    u_xlat16_1.x = u_xlat16_1.x * 0.5 + (-_LightArea);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati18 = int(u_xlat16_1.x);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (int(u_xlati18) != 0) ? u_xlat2.xyz : u_xlat16_1.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_19 = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_19 = u_xlat16_19 * 0.5 + (-_SecondShadow);
    u_xlat16_19 = u_xlat16_19 + 1.0;
    u_xlat16_19 = floor(u_xlat16_19);
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlati18 = int(u_xlat16_19);
    u_xlat16_1.xyz = (int(u_xlati18) != 0) ? u_xlat16_1.xyz : u_xlat16_4.xyz;
    u_xlat6 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_1.xyz = (int(u_xlati6) != 0) ? u_xlat16_3.xyz : u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat6) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat6) + (-_WorldSpaceLightPos0.xyz);
    u_xlat2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
    u_xlat6 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat6) + _CustomLightDir.xyz;
    u_xlat16_19 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_3.xyz = vec3(u_xlat16_19) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb6 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb6)) ? u_xlat16_3.xyz : u_xlat2.xyz;
    u_xlat16_19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_4.xyz = vec3(u_xlat16_19) * vs_TEXCOORD1.xyz;
    u_xlat16_19 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlat16_19 = log2(u_xlat16_19);
    u_xlat16_19 = u_xlat16_19 * _Shininess;
    u_xlat16_19 = exp2(u_xlat16_19);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_19) + u_xlat16_6;
    u_xlat6 = u_xlat16_6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati6) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump float vs_TEXCOORD3;
out mediump float vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = _DirectionalFadeValue + -1.0;
    u_xlat0.z = u_xlat0.x * u_xlat3 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_2.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.w = u_xlat16_2.x * 0.497500002 + 0.5;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.z;
vs_COLOR1 = phase0_Output0_2.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump float vs_COLOR1;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
int u_xlati6;
bool u_xlatb6;
float u_xlat18;
int u_xlati18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat18 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_1.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat2.xy = u_xlat16_1.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_1.x = (u_xlati18 != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_1.x = u_xlat16_1.x + vs_COLOR1;
    u_xlat16_1.x = u_xlat16_1.x * 0.5 + (-_LightArea);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati18 = int(u_xlat16_1.x);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (int(u_xlati18) != 0) ? u_xlat2.xyz : u_xlat16_1.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_19 = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_19 = u_xlat16_19 * 0.5 + (-_SecondShadow);
    u_xlat16_19 = u_xlat16_19 + 1.0;
    u_xlat16_19 = floor(u_xlat16_19);
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlati18 = int(u_xlat16_19);
    u_xlat16_1.xyz = (int(u_xlati18) != 0) ? u_xlat16_1.xyz : u_xlat16_4.xyz;
    u_xlat6 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_1.xyz = (int(u_xlati6) != 0) ? u_xlat16_3.xyz : u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat6) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat6) + (-_WorldSpaceLightPos0.xyz);
    u_xlat2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
    u_xlat6 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat6) + _CustomLightDir.xyz;
    u_xlat16_19 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_3.xyz = vec3(u_xlat16_19) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb6 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb6)) ? u_xlat16_3.xyz : u_xlat2.xyz;
    u_xlat16_19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_4.xyz = vec3(u_xlat16_19) * vs_TEXCOORD1.xyz;
    u_xlat16_19 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlat16_19 = log2(u_xlat16_19);
    u_xlat16_19 = u_xlat16_19 * _Shininess;
    u_xlat16_19 = exp2(u_xlat16_19);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_19) + u_xlat16_6;
    u_xlat6 = u_xlat16_6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati6) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump float vs_TEXCOORD3;
out mediump float vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = _DirectionalFadeValue + -1.0;
    u_xlat0.z = u_xlat0.x * u_xlat3 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_2.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.w = u_xlat16_2.x * 0.497500002 + 0.5;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.z;
vs_COLOR1 = phase0_Output0_2.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump float vs_COLOR1;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
int u_xlati6;
bool u_xlatb6;
float u_xlat18;
int u_xlati18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat18 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_1.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat2.xy = u_xlat16_1.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_1.x = (u_xlati18 != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_1.x = u_xlat16_1.x + vs_COLOR1;
    u_xlat16_1.x = u_xlat16_1.x * 0.5 + (-_LightArea);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati18 = int(u_xlat16_1.x);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (int(u_xlati18) != 0) ? u_xlat2.xyz : u_xlat16_1.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_19 = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_19 = u_xlat16_19 * 0.5 + (-_SecondShadow);
    u_xlat16_19 = u_xlat16_19 + 1.0;
    u_xlat16_19 = floor(u_xlat16_19);
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlati18 = int(u_xlat16_19);
    u_xlat16_1.xyz = (int(u_xlati18) != 0) ? u_xlat16_1.xyz : u_xlat16_4.xyz;
    u_xlat6 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_1.xyz = (int(u_xlati6) != 0) ? u_xlat16_3.xyz : u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat6) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat6) + (-_WorldSpaceLightPos0.xyz);
    u_xlat2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
    u_xlat6 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat6) + _CustomLightDir.xyz;
    u_xlat16_19 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_3.xyz = vec3(u_xlat16_19) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb6 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb6)) ? u_xlat16_3.xyz : u_xlat2.xyz;
    u_xlat16_19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_4.xyz = vec3(u_xlat16_19) * vs_TEXCOORD1.xyz;
    u_xlat16_19 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlat16_19 = log2(u_xlat16_19);
    u_xlat16_19 = u_xlat16_19 * _Shininess;
    u_xlat16_19 = exp2(u_xlat16_19);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_19) + u_xlat16_6;
    u_xlat6 = u_xlat16_6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati6) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump float vs_TEXCOORD3;
out mediump float vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = _DirectionalFadeValue + -1.0;
    u_xlat0.z = u_xlat0.x * u_xlat3 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_2.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.w = u_xlat16_2.x * 0.497500002 + 0.5;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.z;
vs_COLOR1 = phase0_Output0_2.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump float vs_COLOR1;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
int u_xlati6;
bool u_xlatb6;
float u_xlat18;
int u_xlati18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat18 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_1.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat2.xy = u_xlat16_1.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_1.x = (u_xlati18 != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_1.x = u_xlat16_1.x + vs_COLOR1;
    u_xlat16_1.x = u_xlat16_1.x * 0.5 + (-_LightArea);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati18 = int(u_xlat16_1.x);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (int(u_xlati18) != 0) ? u_xlat2.xyz : u_xlat16_1.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_19 = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_19 = u_xlat16_19 * 0.5 + (-_SecondShadow);
    u_xlat16_19 = u_xlat16_19 + 1.0;
    u_xlat16_19 = floor(u_xlat16_19);
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlati18 = int(u_xlat16_19);
    u_xlat16_1.xyz = (int(u_xlati18) != 0) ? u_xlat16_1.xyz : u_xlat16_4.xyz;
    u_xlat6 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_1.xyz = (int(u_xlati6) != 0) ? u_xlat16_3.xyz : u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat6) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat6) + (-_WorldSpaceLightPos0.xyz);
    u_xlat2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
    u_xlat6 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat6) + _CustomLightDir.xyz;
    u_xlat16_19 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_3.xyz = vec3(u_xlat16_19) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb6 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb6)) ? u_xlat16_3.xyz : u_xlat2.xyz;
    u_xlat16_19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_19 = inversesqrt(u_xlat16_19);
    u_xlat16_4.xyz = vec3(u_xlat16_19) * vs_TEXCOORD1.xyz;
    u_xlat16_19 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlat16_19 = log2(u_xlat16_19);
    u_xlat16_19 = u_xlat16_19 * _Shininess;
    u_xlat16_19 = exp2(u_xlat16_19);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_19) + u_xlat16_6;
    u_xlat6 = u_xlat16_6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati6) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump float vs_TEXCOORD3;
out mediump float vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = _DirectionalFadeValue + -1.0;
    u_xlat0.z = u_xlat0.x * u_xlat3 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_2.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.w = u_xlat16_2.x * 0.497500002 + 0.5;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.z;
vs_COLOR1 = phase0_Output0_2.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump float vs_COLOR1;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
int u_xlati6;
bool u_xlatb6;
float u_xlat18;
lowp float u_xlat10_18;
int u_xlati18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat0.y = float(0.0);
    u_xlat0.z = float(1.0);
    u_xlat10_1.xyz = texture(_tableTex, u_xlat0.xz).xyz;
    u_xlat10_0.xyz = texture(_tableTex, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat10_1.xyz;
    u_xlat10_18 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.xyz = vec3(u_xlat10_18) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat18 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_20 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat1.xy = vec2(u_xlat16_20) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_20 = (u_xlati18 != 0) ? u_xlat1.y : u_xlat1.x;
    u_xlat16_20 = u_xlat16_20 + vs_COLOR1;
    u_xlat16_20 = u_xlat16_20 * 0.5 + (-_LightArea);
    u_xlat16_20 = u_xlat16_20 + 1.0;
    u_xlat16_20 = floor(u_xlat16_20);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlati18 = int(u_xlat16_20);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati18) != 0) ? u_xlat16_2.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_20 = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_20 = u_xlat16_20 * 0.5 + (-_SecondShadow);
    u_xlat16_20 = u_xlat16_20 + 1.0;
    u_xlat16_20 = floor(u_xlat16_20);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlati18 = int(u_xlat16_20);
    u_xlat16_2.xyz = (int(u_xlati18) != 0) ? u_xlat16_3.xyz : u_xlat16_2.xyz;
    u_xlat6 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_2.xyz = (int(u_xlati6) != 0) ? u_xlat16_4.xyz : u_xlat16_2.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat6) + (-_WorldSpaceLightPos0.xyz);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat6 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat6) + _CustomLightDir.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb6 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb6)) ? u_xlat16_3.xyz : u_xlat1.xyz;
    u_xlat16_20 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_4.xyz = vec3(u_xlat16_20) * vs_TEXCOORD1.xyz;
    u_xlat16_20 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlat16_20 = log2(u_xlat16_20);
    u_xlat16_20 = u_xlat16_20 * _Shininess;
    u_xlat16_20 = exp2(u_xlat16_20);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_20) + u_xlat16_6;
    u_xlat6 = u_xlat16_6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati6) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump float vs_TEXCOORD3;
out mediump float vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = _DirectionalFadeValue + -1.0;
    u_xlat0.z = u_xlat0.x * u_xlat3 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_2.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.w = u_xlat16_2.x * 0.497500002 + 0.5;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.z;
vs_COLOR1 = phase0_Output0_2.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump float vs_COLOR1;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
int u_xlati6;
bool u_xlatb6;
float u_xlat18;
lowp float u_xlat10_18;
int u_xlati18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat0.y = float(0.0);
    u_xlat0.z = float(1.0);
    u_xlat10_1.xyz = texture(_tableTex, u_xlat0.xz).xyz;
    u_xlat10_0.xyz = texture(_tableTex, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat10_1.xyz;
    u_xlat10_18 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.xyz = vec3(u_xlat10_18) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat18 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_20 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat1.xy = vec2(u_xlat16_20) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_20 = (u_xlati18 != 0) ? u_xlat1.y : u_xlat1.x;
    u_xlat16_20 = u_xlat16_20 + vs_COLOR1;
    u_xlat16_20 = u_xlat16_20 * 0.5 + (-_LightArea);
    u_xlat16_20 = u_xlat16_20 + 1.0;
    u_xlat16_20 = floor(u_xlat16_20);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlati18 = int(u_xlat16_20);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati18) != 0) ? u_xlat16_2.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_20 = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_20 = u_xlat16_20 * 0.5 + (-_SecondShadow);
    u_xlat16_20 = u_xlat16_20 + 1.0;
    u_xlat16_20 = floor(u_xlat16_20);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlati18 = int(u_xlat16_20);
    u_xlat16_2.xyz = (int(u_xlati18) != 0) ? u_xlat16_3.xyz : u_xlat16_2.xyz;
    u_xlat6 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_2.xyz = (int(u_xlati6) != 0) ? u_xlat16_4.xyz : u_xlat16_2.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat6) + (-_WorldSpaceLightPos0.xyz);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat6 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat6) + _CustomLightDir.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb6 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb6)) ? u_xlat16_3.xyz : u_xlat1.xyz;
    u_xlat16_20 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_4.xyz = vec3(u_xlat16_20) * vs_TEXCOORD1.xyz;
    u_xlat16_20 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlat16_20 = log2(u_xlat16_20);
    u_xlat16_20 = u_xlat16_20 * _Shininess;
    u_xlat16_20 = exp2(u_xlat16_20);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_20) + u_xlat16_6;
    u_xlat6 = u_xlat16_6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati6) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump float vs_TEXCOORD3;
out mediump float vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = _DirectionalFadeValue + -1.0;
    u_xlat0.z = u_xlat0.x * u_xlat3 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_2.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.w = u_xlat16_2.x * 0.497500002 + 0.5;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.z;
vs_COLOR1 = phase0_Output0_2.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump float vs_COLOR1;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
int u_xlati6;
bool u_xlatb6;
float u_xlat18;
lowp float u_xlat10_18;
int u_xlati18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat0.y = float(0.0);
    u_xlat0.z = float(1.0);
    u_xlat10_1.xyz = texture(_tableTex, u_xlat0.xz).xyz;
    u_xlat10_0.xyz = texture(_tableTex, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat10_1.xyz;
    u_xlat10_18 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.xyz = vec3(u_xlat10_18) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat18 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_20 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat1.xy = vec2(u_xlat16_20) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_20 = (u_xlati18 != 0) ? u_xlat1.y : u_xlat1.x;
    u_xlat16_20 = u_xlat16_20 + vs_COLOR1;
    u_xlat16_20 = u_xlat16_20 * 0.5 + (-_LightArea);
    u_xlat16_20 = u_xlat16_20 + 1.0;
    u_xlat16_20 = floor(u_xlat16_20);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlati18 = int(u_xlat16_20);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati18) != 0) ? u_xlat16_2.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_20 = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_20 = u_xlat16_20 * 0.5 + (-_SecondShadow);
    u_xlat16_20 = u_xlat16_20 + 1.0;
    u_xlat16_20 = floor(u_xlat16_20);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlati18 = int(u_xlat16_20);
    u_xlat16_2.xyz = (int(u_xlati18) != 0) ? u_xlat16_3.xyz : u_xlat16_2.xyz;
    u_xlat6 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_2.xyz = (int(u_xlati6) != 0) ? u_xlat16_4.xyz : u_xlat16_2.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat6) + (-_WorldSpaceLightPos0.xyz);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat6 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat6) + _CustomLightDir.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb6 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb6)) ? u_xlat16_3.xyz : u_xlat1.xyz;
    u_xlat16_20 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_4.xyz = vec3(u_xlat16_20) * vs_TEXCOORD1.xyz;
    u_xlat16_20 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlat16_20 = log2(u_xlat16_20);
    u_xlat16_20 = u_xlat16_20 * _Shininess;
    u_xlat16_20 = exp2(u_xlat16_20);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_20) + u_xlat16_6;
    u_xlat6 = u_xlat16_6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati6) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump float vs_TEXCOORD3;
out mediump float vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = _DirectionalFadeValue + -1.0;
    u_xlat0.z = u_xlat0.x * u_xlat3 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_2.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.w = u_xlat16_2.x * 0.497500002 + 0.5;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.z;
vs_COLOR1 = phase0_Output0_2.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump float vs_COLOR1;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_16;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat1 = floor(u_xlat0.xyxy);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat2 = u_xlat1 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = vec4(u_xlat1.z + float(0.5), u_xlat1.w + float(0.5), u_xlat1.z + float(1.5), u_xlat1.w + float(0.5));
    u_xlat3 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat3.x = texture(_indexTex, u_xlat2.zw).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = (-u_xlat10_3.xyz) + u_xlat10_4.xyz;
    u_xlat10_16 = texture(_factorTex, u_xlat2.zw).x;
    u_xlat16_5.xyz = vec3(u_xlat10_16) * u_xlat16_5.xyz + u_xlat10_3.xyz;
    u_xlat10_16 = texture(_factorTex, u_xlat2.xy).x;
    u_xlat2.x = texture(_indexTex, u_xlat2.xy).w;
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat2.xz).xyz;
    u_xlat10_2.xyz = texture(_tableTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = (-u_xlat10_2.xyz) + u_xlat10_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat10_16) * u_xlat16_6.xyz + u_xlat10_2.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_2.xyz + u_xlat16_6.xyz;
    u_xlat3.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = (-u_xlat10_3.xyz) + u_xlat10_4.xyz;
    u_xlat10_16 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat16_5.xyz = vec3(u_xlat10_16) * u_xlat16_5.xyz + u_xlat10_3.xyz;
    u_xlat10_16 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat16_6.xyz = (-u_xlat10_1.xyz) + u_xlat10_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat10_16) * u_xlat16_6.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat16_6.xyz;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.yyy * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat16_5.xyz = u_xlat0.xyz * _FirstShadowMultColor.xyz;
    u_xlat10_1.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat24 = (-vs_COLOR0.x) * u_xlat10_1.y + 1.5;
    u_xlat24 = floor(u_xlat24);
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlati24 = int(u_xlat24);
    u_xlat16_29 = u_xlat10_1.y * vs_COLOR0.x;
    u_xlat2.xy = vec2(u_xlat16_29) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_29 = (u_xlati24 != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_29 = u_xlat16_29 + vs_COLOR1;
    u_xlat16_29 = u_xlat16_29 * 0.5 + (-_LightArea);
    u_xlat16_29 = u_xlat16_29 + 1.0;
    u_xlat16_29 = floor(u_xlat16_29);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlati24 = int(u_xlat16_29);
    u_xlat16_6.xyz = (int(u_xlati24) != 0) ? u_xlat0.xyz : u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_29 = vs_COLOR0.x * u_xlat10_1.y + vs_COLOR1;
    u_xlat16_29 = u_xlat16_29 * 0.5 + (-_SecondShadow);
    u_xlat16_29 = u_xlat16_29 + 1.0;
    u_xlat16_29 = floor(u_xlat16_29);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlati0 = int(u_xlat16_29);
    u_xlat16_5.xyz = (int(u_xlati0) != 0) ? u_xlat16_5.xyz : u_xlat16_7.xyz;
    u_xlat0.x = vs_COLOR0.x * u_xlat10_1.y + 0.909999967;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_5.xyz = (int(u_xlati0) != 0) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat24) + (-_WorldSpaceLightPos0.xyz);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_6.xyz = u_xlat2.xyz * vec3(u_xlat24) + _CustomLightDir.xyz;
    u_xlat16_29 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb24 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_6.xyz = (bool(u_xlatb24)) ? u_xlat16_6.xyz : u_xlat0.xyz;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_7.xyz = vec3(u_xlat16_29) * vs_TEXCOORD1.xyz;
    u_xlat16_29 = dot(u_xlat16_7.xyz, u_xlat16_6.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_29 = log2(u_xlat16_29);
    u_xlat16_29 = u_xlat16_29 * _Shininess;
    u_xlat16_29 = exp2(u_xlat16_29);
    u_xlat16_0 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_29) + u_xlat16_0;
    u_xlat0.x = u_xlat16_0 + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = vs_TEXCOORD3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump float vs_TEXCOORD3;
out mediump float vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = _DirectionalFadeValue + -1.0;
    u_xlat0.z = u_xlat0.x * u_xlat3 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_2.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.w = u_xlat16_2.x * 0.497500002 + 0.5;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.z;
vs_COLOR1 = phase0_Output0_2.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump float vs_COLOR1;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_16;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat1 = floor(u_xlat0.xyxy);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat2 = u_xlat1 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = vec4(u_xlat1.z + float(0.5), u_xlat1.w + float(0.5), u_xlat1.z + float(1.5), u_xlat1.w + float(0.5));
    u_xlat3 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat3.x = texture(_indexTex, u_xlat2.zw).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = (-u_xlat10_3.xyz) + u_xlat10_4.xyz;
    u_xlat10_16 = texture(_factorTex, u_xlat2.zw).x;
    u_xlat16_5.xyz = vec3(u_xlat10_16) * u_xlat16_5.xyz + u_xlat10_3.xyz;
    u_xlat10_16 = texture(_factorTex, u_xlat2.xy).x;
    u_xlat2.x = texture(_indexTex, u_xlat2.xy).w;
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat2.xz).xyz;
    u_xlat10_2.xyz = texture(_tableTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = (-u_xlat10_2.xyz) + u_xlat10_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat10_16) * u_xlat16_6.xyz + u_xlat10_2.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_2.xyz + u_xlat16_6.xyz;
    u_xlat3.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = (-u_xlat10_3.xyz) + u_xlat10_4.xyz;
    u_xlat10_16 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat16_5.xyz = vec3(u_xlat10_16) * u_xlat16_5.xyz + u_xlat10_3.xyz;
    u_xlat10_16 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat16_6.xyz = (-u_xlat10_1.xyz) + u_xlat10_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat10_16) * u_xlat16_6.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat16_6.xyz;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.yyy * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat16_5.xyz = u_xlat0.xyz * _FirstShadowMultColor.xyz;
    u_xlat10_1.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat24 = (-vs_COLOR0.x) * u_xlat10_1.y + 1.5;
    u_xlat24 = floor(u_xlat24);
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlati24 = int(u_xlat24);
    u_xlat16_29 = u_xlat10_1.y * vs_COLOR0.x;
    u_xlat2.xy = vec2(u_xlat16_29) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_29 = (u_xlati24 != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_29 = u_xlat16_29 + vs_COLOR1;
    u_xlat16_29 = u_xlat16_29 * 0.5 + (-_LightArea);
    u_xlat16_29 = u_xlat16_29 + 1.0;
    u_xlat16_29 = floor(u_xlat16_29);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlati24 = int(u_xlat16_29);
    u_xlat16_6.xyz = (int(u_xlati24) != 0) ? u_xlat0.xyz : u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_29 = vs_COLOR0.x * u_xlat10_1.y + vs_COLOR1;
    u_xlat16_29 = u_xlat16_29 * 0.5 + (-_SecondShadow);
    u_xlat16_29 = u_xlat16_29 + 1.0;
    u_xlat16_29 = floor(u_xlat16_29);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlati0 = int(u_xlat16_29);
    u_xlat16_5.xyz = (int(u_xlati0) != 0) ? u_xlat16_5.xyz : u_xlat16_7.xyz;
    u_xlat0.x = vs_COLOR0.x * u_xlat10_1.y + 0.909999967;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_5.xyz = (int(u_xlati0) != 0) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat24) + (-_WorldSpaceLightPos0.xyz);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_6.xyz = u_xlat2.xyz * vec3(u_xlat24) + _CustomLightDir.xyz;
    u_xlat16_29 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb24 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_6.xyz = (bool(u_xlatb24)) ? u_xlat16_6.xyz : u_xlat0.xyz;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_7.xyz = vec3(u_xlat16_29) * vs_TEXCOORD1.xyz;
    u_xlat16_29 = dot(u_xlat16_7.xyz, u_xlat16_6.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_29 = log2(u_xlat16_29);
    u_xlat16_29 = u_xlat16_29 * _Shininess;
    u_xlat16_29 = exp2(u_xlat16_29);
    u_xlat16_0 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_29) + u_xlat16_0;
    u_xlat0.x = u_xlat16_0 + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = vs_TEXCOORD3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump float vs_TEXCOORD3;
out mediump float vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = _DirectionalFadeValue + -1.0;
    u_xlat0.z = u_xlat0.x * u_xlat3 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_2.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.w = u_xlat16_2.x * 0.497500002 + 0.5;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.z;
vs_COLOR1 = phase0_Output0_2.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump float vs_COLOR1;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_16;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat1 = floor(u_xlat0.xyxy);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat2 = u_xlat1 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = vec4(u_xlat1.z + float(0.5), u_xlat1.w + float(0.5), u_xlat1.z + float(1.5), u_xlat1.w + float(0.5));
    u_xlat3 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat3.x = texture(_indexTex, u_xlat2.zw).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = (-u_xlat10_3.xyz) + u_xlat10_4.xyz;
    u_xlat10_16 = texture(_factorTex, u_xlat2.zw).x;
    u_xlat16_5.xyz = vec3(u_xlat10_16) * u_xlat16_5.xyz + u_xlat10_3.xyz;
    u_xlat10_16 = texture(_factorTex, u_xlat2.xy).x;
    u_xlat2.x = texture(_indexTex, u_xlat2.xy).w;
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat2.xz).xyz;
    u_xlat10_2.xyz = texture(_tableTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = (-u_xlat10_2.xyz) + u_xlat10_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat10_16) * u_xlat16_6.xyz + u_xlat10_2.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_2.xyz + u_xlat16_6.xyz;
    u_xlat3.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = (-u_xlat10_3.xyz) + u_xlat10_4.xyz;
    u_xlat10_16 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat16_5.xyz = vec3(u_xlat10_16) * u_xlat16_5.xyz + u_xlat10_3.xyz;
    u_xlat10_16 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat16_6.xyz = (-u_xlat10_1.xyz) + u_xlat10_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat10_16) * u_xlat16_6.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat16_6.xyz;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.yyy * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat16_5.xyz = u_xlat0.xyz * _FirstShadowMultColor.xyz;
    u_xlat10_1.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat24 = (-vs_COLOR0.x) * u_xlat10_1.y + 1.5;
    u_xlat24 = floor(u_xlat24);
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlati24 = int(u_xlat24);
    u_xlat16_29 = u_xlat10_1.y * vs_COLOR0.x;
    u_xlat2.xy = vec2(u_xlat16_29) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_29 = (u_xlati24 != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_29 = u_xlat16_29 + vs_COLOR1;
    u_xlat16_29 = u_xlat16_29 * 0.5 + (-_LightArea);
    u_xlat16_29 = u_xlat16_29 + 1.0;
    u_xlat16_29 = floor(u_xlat16_29);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlati24 = int(u_xlat16_29);
    u_xlat16_6.xyz = (int(u_xlati24) != 0) ? u_xlat0.xyz : u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_29 = vs_COLOR0.x * u_xlat10_1.y + vs_COLOR1;
    u_xlat16_29 = u_xlat16_29 * 0.5 + (-_SecondShadow);
    u_xlat16_29 = u_xlat16_29 + 1.0;
    u_xlat16_29 = floor(u_xlat16_29);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlati0 = int(u_xlat16_29);
    u_xlat16_5.xyz = (int(u_xlati0) != 0) ? u_xlat16_5.xyz : u_xlat16_7.xyz;
    u_xlat0.x = vs_COLOR0.x * u_xlat10_1.y + 0.909999967;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_5.xyz = (int(u_xlati0) != 0) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat24) + (-_WorldSpaceLightPos0.xyz);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_6.xyz = u_xlat2.xyz * vec3(u_xlat24) + _CustomLightDir.xyz;
    u_xlat16_29 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb24 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_6.xyz = (bool(u_xlatb24)) ? u_xlat16_6.xyz : u_xlat0.xyz;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_7.xyz = vec3(u_xlat16_29) * vs_TEXCOORD1.xyz;
    u_xlat16_29 = dot(u_xlat16_7.xyz, u_xlat16_6.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_29 = log2(u_xlat16_29);
    u_xlat16_29 = u_xlat16_29 * _Shininess;
    u_xlat16_29 = exp2(u_xlat16_29);
    u_xlat16_0 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_0 = (-u_xlat16_29) + u_xlat16_0;
    u_xlat0.x = u_xlat16_0 + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = vs_TEXCOORD3;
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
Keywords { "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
}
}
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "Reflected" = "Reflected" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 117459
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _MaxOutlineZOffset;
uniform 	mediump float _Scale;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_11;
float u_xlat13;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_TANGENT0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_MaxOutlineZOffset);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat13 = in_COLOR0.z + -0.5;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat13) + u_xlat0.xyz;
    u_xlat0.x = (-u_xlat0.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat0.x / _Scale;
    u_xlat0.x = inversesqrt(u_xlat16_11);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _DirectionalFadeValue + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat4 + 1.0;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
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
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
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
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _MaxOutlineZOffset;
uniform 	mediump float _Scale;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_11;
float u_xlat13;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_TANGENT0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_MaxOutlineZOffset);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat13 = in_COLOR0.z + -0.5;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat13) + u_xlat0.xyz;
    u_xlat0.x = (-u_xlat0.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat0.x / _Scale;
    u_xlat0.x = inversesqrt(u_xlat16_11);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _DirectionalFadeValue + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat4 + 1.0;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
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
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
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
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _MaxOutlineZOffset;
uniform 	mediump float _Scale;
uniform 	vec4 _DirectionalFadeDirection;
uniform 	float _DirectionalFadeOffset;
uniform 	float _DirectionalFadeRange;
uniform 	float _DirectionalFadeValue;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_11;
float u_xlat13;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_TANGENT0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_MaxOutlineZOffset);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat13 = in_COLOR0.z + -0.5;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat13) + u_xlat0.xyz;
    u_xlat0.x = (-u_xlat0.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat0.x / _Scale;
    u_xlat0.x = inversesqrt(u_xlat16_11);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _DirectionalFadeDirection.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _DirectionalFadeDirection.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _DirectionalFadeDirection.zzz + u_xlat0.xyz;
    u_xlat0.w = _DirectionalFadeOffset;
    u_xlat0.x = dot(in_POSITION0, u_xlat0);
    u_xlat0.x = u_xlat0.x / _DirectionalFadeRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = _DirectionalFadeValue + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat4 + 1.0;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
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
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
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
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
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
}
}
 Pass {
  Name "CONSTANT_REPLACE_NOCUTOFF"
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "Reflected" = "Reflected" "RenderType" = "Transparent" }
  GpuProgramID 134194
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
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
in highp vec4 in_POSITION0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
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
in highp vec4 in_POSITION0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat1.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat1.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat16_2 = _SPOpaqueness * _BloomFactor;
    u_xlat16_2 = (u_xlati3.z != 0) ? _BloomFactor : u_xlat16_2;
    u_xlat6 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat0 = u_xlat0 * u_xlat6 + _BloomFactor;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat1.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat1.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat16_2 = _SPOpaqueness * _BloomFactor;
    u_xlat16_2 = (u_xlati3.z != 0) ? _BloomFactor : u_xlat16_2;
    u_xlat6 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat0 = u_xlat0 * u_xlat6 + _BloomFactor;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat1.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat1.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat16_2 = _SPOpaqueness * _BloomFactor;
    u_xlat16_2 = (u_xlati3.z != 0) ? _BloomFactor : u_xlat16_2;
    u_xlat6 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat0 = u_xlat0 * u_xlat6 + _BloomFactor;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
}