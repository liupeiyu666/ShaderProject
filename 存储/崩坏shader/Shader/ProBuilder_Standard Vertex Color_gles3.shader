//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "ProBuilder/Standard Vertex Color" {
Properties {
_MainTex ("Base Color", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_Caustics ("Caustics Texture (RGBA)", 2D) = "white" { }
_CausticsCoord ("Tiling(XY) Offset(ZW) - Overrides texture coords", Vector) = (0.5,0.5,0,0)
_CausticsSpeed ("Speed", Float) = 1
_CausticsBoost ("Boost", Range(0, 1)) = 0
_CausticsIntensity0 ("Intensity A", Range(0, 1)) = 1
_CausticsIntensity1 ("Intensity B", Range(0, 1)) = 0
_CausticsPosition0 ("Position A (World Y)", Float) = 2
_CausticsPosition1 ("Position B (World Y)", Float) = 4
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 59486
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD2.xy;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
}
}
}
Fallback "Standard"
}