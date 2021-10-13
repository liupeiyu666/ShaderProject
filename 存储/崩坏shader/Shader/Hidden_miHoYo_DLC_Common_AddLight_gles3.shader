//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/miHoYo/DLC/Common/AddLight" {
Properties {
_MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
_MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
}
SubShader {
 Tags { "PerformanceChecks" = "False" "RenderType" = "Opaque" }
 Pass {
  Name "ADDLIGHT"
  Tags { "LIGHTMODE" = "FORWARDADD" "PerformanceChecks" = "False" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 51985
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform highp sampler2D _LightTexture0;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AdditiveLightPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = texture(_LightTexture0, u_xlat2.xx).w;
    u_xlat2.xyz = u_xlat2.xxx * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform highp sampler2D _LightTexture0;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AdditiveLightPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = texture(_LightTexture0, u_xlat2.xx).w;
    u_xlat2.xyz = u_xlat2.xxx * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform highp sampler2D _LightTexture0;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AdditiveLightPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = texture(_LightTexture0, u_xlat2.xx).w;
    u_xlat2.xyz = u_xlat2.xxx * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AdditiveLightPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AdditiveLightPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AdditiveLightPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).w;
    u_xlat16_2 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2 = u_xlat9 * u_xlat16_2;
    u_xlat16_2 = u_xlat0.x * u_xlat16_2;
    u_xlat0.xyz = vec3(u_xlat16_2) * _LightColor0.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat9 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = log2(u_xlat9);
    u_xlat9 = u_xlat9 * _AdditiveLightPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).w;
    u_xlat16_2 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2 = u_xlat9 * u_xlat16_2;
    u_xlat16_2 = u_xlat0.x * u_xlat16_2;
    u_xlat0.xyz = vec3(u_xlat16_2) * _LightColor0.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat9 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = log2(u_xlat9);
    u_xlat9 = u_xlat9 * _AdditiveLightPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).w;
    u_xlat16_2 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2 = u_xlat9 * u_xlat16_2;
    u_xlat16_2 = u_xlat0.x * u_xlat16_2;
    u_xlat0.xyz = vec3(u_xlat16_2) * _LightColor0.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat9 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = log2(u_xlat9);
    u_xlat9 = u_xlat9 * _AdditiveLightPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
    u_xlat2 = texture(_LightTextureB0, vec2(u_xlat6)).w;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat6 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat6 = log2(u_xlat6);
    u_xlat6 = u_xlat6 * _AdditiveLightPower;
    u_xlat6 = exp2(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
    u_xlat2 = texture(_LightTextureB0, vec2(u_xlat6)).w;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat6 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat6 = log2(u_xlat6);
    u_xlat6 = u_xlat6 * _AdditiveLightPower;
    u_xlat6 = exp2(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
    u_xlat2 = texture(_LightTextureB0, vec2(u_xlat6)).w;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat6 = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat6 = log2(u_xlat6);
    u_xlat6 = u_xlat6 * _AdditiveLightPower;
    u_xlat6 = exp2(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform highp sampler2D _LightTexture0;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_1;
float u_xlat6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat6 = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat6 = log2(u_xlat6);
    u_xlat6 = u_xlat6 * _AdditiveLightPower;
    u_xlat6 = exp2(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform highp sampler2D _LightTexture0;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_1;
float u_xlat6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat6 = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat6 = log2(u_xlat6);
    u_xlat6 = u_xlat6 * _AdditiveLightPower;
    u_xlat6 = exp2(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	float _AdditiveLightPower;
uniform 	float _AdditiveLightIntensity;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform highp sampler2D _LightTexture0;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_1;
float u_xlat6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat6 = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat6 = log2(u_xlat6);
    u_xlat6 = u_xlat6 * _AdditiveLightPower;
    u_xlat6 = exp2(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_AdditiveLightIntensity, _AdditiveLightIntensity, _AdditiveLightIntensity));
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.www;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
""
}
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
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
}
}
}
}