//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/Sphere Shield Horn" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_Intensity ("Intensity", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_CellShrink ("Cell Shrink", Float) = 0
_CellRimIntensity ("Cell Rim Intensity", Float) = 0.4
_RidgeRimIntensity ("Ridge Rim Intensity", Float) = 0.4
_BandPosition ("Band Position (rotate dir and angle)", Vector) = (1,1,0,1.57)
_BandWidth ("Band Width", Float) = 0
_BandIntensity ("Band Intensity", Float) = 0
[Toggle] _AlwaysFaceToCamera ("Always Face to Camera", Float) = 0
}
SubShader {
 LOD 200
 Tags { "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 12202
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump float _AlwaysFaceToCamera;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat0;
    u_xlat1.x = dot(u_xlat0, u_xlat0);
    u_xlat1.x = sqrt(u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x==0.0);
#else
    u_xlatb1 = u_xlat1.x==0.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(0.0, 1.0, 0.0) : u_xlat0.yzx;
    u_xlat19 = dot(hlslcc_mtx4x4unity_MatrixV[1].xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat4.xyz = in_POSITION0.xyz * vec3(100.0, 100.0, 100.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat4.zzz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat4.xxx + u_xlat1.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlwaysFaceToCamera));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlwaysFaceToCamera);
#endif
    gl_Position = (bool(u_xlatb2)) ? u_xlat0 : u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_5.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat0.xyz * u_xlat16_5.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_5.x = dot(u_xlat0.xyz, u_xlat16_5.xyz);
    u_xlat0.x = abs(u_xlat16_5.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_5.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_5.x) + 1.57072878;
    u_xlat6 = -abs(u_xlat16_5.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_5.x<(-u_xlat16_5.x));
#else
    u_xlatb12 = u_xlat16_5.x<(-u_xlat16_5.x);
#endif
    u_xlat6 = sqrt(u_xlat6);
    u_xlat18 = u_xlat6 * u_xlat0.x;
    u_xlat18 = u_xlat18 * -2.0 + 3.14159274;
    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat12;
    u_xlat16_5.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_5.x = cos(u_xlat16_5.x);
    u_xlat16_11 = float(1.0) / _BandWidth;
    u_xlat16_5.x = u_xlat16_11 * abs(u_xlat16_5.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = (-u_xlat16_11) * u_xlat16_5.x + 1.0;
    u_xlat16_0 = u_xlat16_5.xxxx * _Color;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_BandIntensity, _BandIntensity, _BandIntensity, _BandIntensity));
    vs_COLOR0 = in_COLOR0 * _Color + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Intensity;
uniform 	mediump float _RidgeRimIntensity;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _RidgeRimIntensity + vs_COLOR0.w;
    u_xlat16_1 = u_xlat16_0 * _Intensity;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump float _AlwaysFaceToCamera;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat0;
    u_xlat1.x = dot(u_xlat0, u_xlat0);
    u_xlat1.x = sqrt(u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x==0.0);
#else
    u_xlatb1 = u_xlat1.x==0.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(0.0, 1.0, 0.0) : u_xlat0.yzx;
    u_xlat19 = dot(hlslcc_mtx4x4unity_MatrixV[1].xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat4.xyz = in_POSITION0.xyz * vec3(100.0, 100.0, 100.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat4.zzz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat4.xxx + u_xlat1.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlwaysFaceToCamera));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlwaysFaceToCamera);
#endif
    gl_Position = (bool(u_xlatb2)) ? u_xlat0 : u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_5.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat0.xyz * u_xlat16_5.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_5.x = dot(u_xlat0.xyz, u_xlat16_5.xyz);
    u_xlat0.x = abs(u_xlat16_5.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_5.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_5.x) + 1.57072878;
    u_xlat6 = -abs(u_xlat16_5.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_5.x<(-u_xlat16_5.x));
#else
    u_xlatb12 = u_xlat16_5.x<(-u_xlat16_5.x);
#endif
    u_xlat6 = sqrt(u_xlat6);
    u_xlat18 = u_xlat6 * u_xlat0.x;
    u_xlat18 = u_xlat18 * -2.0 + 3.14159274;
    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat12;
    u_xlat16_5.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_5.x = cos(u_xlat16_5.x);
    u_xlat16_11 = float(1.0) / _BandWidth;
    u_xlat16_5.x = u_xlat16_11 * abs(u_xlat16_5.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = (-u_xlat16_11) * u_xlat16_5.x + 1.0;
    u_xlat16_0 = u_xlat16_5.xxxx * _Color;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_BandIntensity, _BandIntensity, _BandIntensity, _BandIntensity));
    vs_COLOR0 = in_COLOR0 * _Color + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Intensity;
uniform 	mediump float _RidgeRimIntensity;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _RidgeRimIntensity + vs_COLOR0.w;
    u_xlat16_1 = u_xlat16_0 * _Intensity;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump float _AlwaysFaceToCamera;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat0;
    u_xlat1.x = dot(u_xlat0, u_xlat0);
    u_xlat1.x = sqrt(u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x==0.0);
#else
    u_xlatb1 = u_xlat1.x==0.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(0.0, 1.0, 0.0) : u_xlat0.yzx;
    u_xlat19 = dot(hlslcc_mtx4x4unity_MatrixV[1].xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat4.xyz = in_POSITION0.xyz * vec3(100.0, 100.0, 100.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat4.zzz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat4.xxx + u_xlat1.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlwaysFaceToCamera));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlwaysFaceToCamera);
#endif
    gl_Position = (bool(u_xlatb2)) ? u_xlat0 : u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_5.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat0.xyz * u_xlat16_5.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_5.x = dot(u_xlat0.xyz, u_xlat16_5.xyz);
    u_xlat0.x = abs(u_xlat16_5.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_5.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_5.x) + 1.57072878;
    u_xlat6 = -abs(u_xlat16_5.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_5.x<(-u_xlat16_5.x));
#else
    u_xlatb12 = u_xlat16_5.x<(-u_xlat16_5.x);
#endif
    u_xlat6 = sqrt(u_xlat6);
    u_xlat18 = u_xlat6 * u_xlat0.x;
    u_xlat18 = u_xlat18 * -2.0 + 3.14159274;
    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat12;
    u_xlat16_5.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_5.x = cos(u_xlat16_5.x);
    u_xlat16_11 = float(1.0) / _BandWidth;
    u_xlat16_5.x = u_xlat16_11 * abs(u_xlat16_5.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = (-u_xlat16_11) * u_xlat16_5.x + 1.0;
    u_xlat16_0 = u_xlat16_5.xxxx * _Color;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_BandIntensity, _BandIntensity, _BandIntensity, _BandIntensity));
    vs_COLOR0 = in_COLOR0 * _Color + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Intensity;
uniform 	mediump float _RidgeRimIntensity;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _RidgeRimIntensity + vs_COLOR0.w;
    u_xlat16_1 = u_xlat16_0 * _Intensity;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
    SV_Target0.w = 0.0;
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
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 81614
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump float _AlwaysFaceToCamera;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat0;
    u_xlat1.x = dot(u_xlat0, u_xlat0);
    u_xlat1.x = sqrt(u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x==0.0);
#else
    u_xlatb1 = u_xlat1.x==0.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(0.0, 1.0, 0.0) : u_xlat0.yzx;
    u_xlat19 = dot(hlslcc_mtx4x4unity_MatrixV[1].xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat4.xyz = in_POSITION0.xyz * vec3(100.0, 100.0, 100.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat4.zzz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat4.xxx + u_xlat1.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlwaysFaceToCamera));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlwaysFaceToCamera);
#endif
    gl_Position = (bool(u_xlatb2)) ? u_xlat0 : u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_5.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat0.xyz * u_xlat16_5.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_5.x = dot(u_xlat0.xyz, u_xlat16_5.xyz);
    u_xlat0.x = abs(u_xlat16_5.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_5.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_5.x) + 1.57072878;
    u_xlat6 = -abs(u_xlat16_5.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_5.x<(-u_xlat16_5.x));
#else
    u_xlatb12 = u_xlat16_5.x<(-u_xlat16_5.x);
#endif
    u_xlat6 = sqrt(u_xlat6);
    u_xlat18 = u_xlat6 * u_xlat0.x;
    u_xlat18 = u_xlat18 * -2.0 + 3.14159274;
    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat12;
    u_xlat16_5.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_5.x = cos(u_xlat16_5.x);
    u_xlat16_11 = float(1.0) / _BandWidth;
    u_xlat16_5.x = u_xlat16_11 * abs(u_xlat16_5.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = (-u_xlat16_11) * u_xlat16_5.x + 1.0;
    u_xlat16_0 = u_xlat16_5.xxxx * _Color;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_BandIntensity, _BandIntensity, _BandIntensity, _BandIntensity));
    vs_COLOR0 = in_COLOR0 * _Color + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Intensity;
uniform 	mediump float _RidgeRimIntensity;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _RidgeRimIntensity + vs_COLOR0.w;
    u_xlat16_1 = u_xlat16_0 * _Intensity;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump float _AlwaysFaceToCamera;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat0;
    u_xlat1.x = dot(u_xlat0, u_xlat0);
    u_xlat1.x = sqrt(u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x==0.0);
#else
    u_xlatb1 = u_xlat1.x==0.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(0.0, 1.0, 0.0) : u_xlat0.yzx;
    u_xlat19 = dot(hlslcc_mtx4x4unity_MatrixV[1].xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat4.xyz = in_POSITION0.xyz * vec3(100.0, 100.0, 100.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat4.zzz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat4.xxx + u_xlat1.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlwaysFaceToCamera));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlwaysFaceToCamera);
#endif
    gl_Position = (bool(u_xlatb2)) ? u_xlat0 : u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_5.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat0.xyz * u_xlat16_5.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_5.x = dot(u_xlat0.xyz, u_xlat16_5.xyz);
    u_xlat0.x = abs(u_xlat16_5.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_5.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_5.x) + 1.57072878;
    u_xlat6 = -abs(u_xlat16_5.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_5.x<(-u_xlat16_5.x));
#else
    u_xlatb12 = u_xlat16_5.x<(-u_xlat16_5.x);
#endif
    u_xlat6 = sqrt(u_xlat6);
    u_xlat18 = u_xlat6 * u_xlat0.x;
    u_xlat18 = u_xlat18 * -2.0 + 3.14159274;
    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat12;
    u_xlat16_5.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_5.x = cos(u_xlat16_5.x);
    u_xlat16_11 = float(1.0) / _BandWidth;
    u_xlat16_5.x = u_xlat16_11 * abs(u_xlat16_5.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = (-u_xlat16_11) * u_xlat16_5.x + 1.0;
    u_xlat16_0 = u_xlat16_5.xxxx * _Color;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_BandIntensity, _BandIntensity, _BandIntensity, _BandIntensity));
    vs_COLOR0 = in_COLOR0 * _Color + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Intensity;
uniform 	mediump float _RidgeRimIntensity;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _RidgeRimIntensity + vs_COLOR0.w;
    u_xlat16_1 = u_xlat16_0 * _Intensity;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump float _AlwaysFaceToCamera;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat0;
    u_xlat1.x = dot(u_xlat0, u_xlat0);
    u_xlat1.x = sqrt(u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x==0.0);
#else
    u_xlatb1 = u_xlat1.x==0.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(0.0, 1.0, 0.0) : u_xlat0.yzx;
    u_xlat19 = dot(hlslcc_mtx4x4unity_MatrixV[1].xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat4.xyz = in_POSITION0.xyz * vec3(100.0, 100.0, 100.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat4.zzz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat4.xxx + u_xlat1.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlwaysFaceToCamera));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlwaysFaceToCamera);
#endif
    gl_Position = (bool(u_xlatb2)) ? u_xlat0 : u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_5.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat0.xyz * u_xlat16_5.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_5.x = dot(u_xlat0.xyz, u_xlat16_5.xyz);
    u_xlat0.x = abs(u_xlat16_5.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_5.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_5.x) + 1.57072878;
    u_xlat6 = -abs(u_xlat16_5.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_5.x<(-u_xlat16_5.x));
#else
    u_xlatb12 = u_xlat16_5.x<(-u_xlat16_5.x);
#endif
    u_xlat6 = sqrt(u_xlat6);
    u_xlat18 = u_xlat6 * u_xlat0.x;
    u_xlat18 = u_xlat18 * -2.0 + 3.14159274;
    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat12;
    u_xlat16_5.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_5.x = cos(u_xlat16_5.x);
    u_xlat16_11 = float(1.0) / _BandWidth;
    u_xlat16_5.x = u_xlat16_11 * abs(u_xlat16_5.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = (-u_xlat16_11) * u_xlat16_5.x + 1.0;
    u_xlat16_0 = u_xlat16_5.xxxx * _Color;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_BandIntensity, _BandIntensity, _BandIntensity, _BandIntensity));
    vs_COLOR0 = in_COLOR0 * _Color + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Intensity;
uniform 	mediump float _RidgeRimIntensity;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _RidgeRimIntensity + vs_COLOR0.w;
    u_xlat16_1 = u_xlat16_0 * _Intensity;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
    SV_Target0.w = 0.0;
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
CustomEditor "MoleMole.PropShaderEditorBase"
}