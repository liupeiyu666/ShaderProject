//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/InstancedShader" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_BaseColor ("Base Color", Color) = (1,1,1,1)
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
_BlinSpeed ("BlinSpeed", Float) = 7
_Extent ("Extent", Float) = 0.8
_Frequency ("Frequency", Float) = 1.5
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  GpuProgramID 55594
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Extent;
uniform 	mediump float _Frequency;
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Color.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Extent, _Extent)) + u_xlat1.xz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat1.xyz / u_xlat1.www;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _BlinSpeed;
uniform 	vec4 _Color;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = log2(u_xlat16_1.x);
    u_xlat0.x = u_xlat16_0 * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_1.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xxx * _RGColor.xyz + (-_BaseColor.xyz);
    u_xlat6 = u_xlat16_1.x * _RGRatio;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + _BaseColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _BaseColor.xyz;
    u_xlat6 = _Time.y * _BlinSpeed;
    u_xlat6 = sin(u_xlat6);
    u_xlat6 = abs(u_xlat6) * 0.300000012 + 0.200000003;
    u_xlat16_1.x = u_xlat6 * _Color.y + 1.0;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = _RGBloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Extent;
uniform 	mediump float _Frequency;
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Color.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Extent, _Extent)) + u_xlat1.xz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat1.xyz / u_xlat1.www;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _BlinSpeed;
uniform 	vec4 _Color;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = log2(u_xlat16_1.x);
    u_xlat0.x = u_xlat16_0 * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_1.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xxx * _RGColor.xyz + (-_BaseColor.xyz);
    u_xlat6 = u_xlat16_1.x * _RGRatio;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + _BaseColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _BaseColor.xyz;
    u_xlat6 = _Time.y * _BlinSpeed;
    u_xlat6 = sin(u_xlat6);
    u_xlat6 = abs(u_xlat6) * 0.300000012 + 0.200000003;
    u_xlat16_1.x = u_xlat6 * _Color.y + 1.0;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = _RGBloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Extent;
uniform 	mediump float _Frequency;
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Color.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Extent, _Extent)) + u_xlat1.xz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat1.xyz / u_xlat1.www;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _BlinSpeed;
uniform 	vec4 _Color;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = log2(u_xlat16_1.x);
    u_xlat0.x = u_xlat16_0 * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_1.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xxx * _RGColor.xyz + (-_BaseColor.xyz);
    u_xlat6 = u_xlat16_1.x * _RGRatio;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + _BaseColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _BaseColor.xyz;
    u_xlat6 = _Time.y * _BlinSpeed;
    u_xlat6 = sin(u_xlat6);
    u_xlat6 = abs(u_xlat6) * 0.300000012 + 0.200000003;
    u_xlat16_1.x = u_xlat6 * _Color.y + 1.0;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = _RGBloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _Extent;
uniform 	mediump float _Frequency;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct PropsArray_Type {
	vec4 _Color;
};
layout(std140) uniform UnityInstancing_Props {
	PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = u_xlat0.x * PropsArray[u_xlati3]._Color.x;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.xz = u_xlat0.xx * vec2(vec2(_Extent, _Extent)) + u_xlat1.xz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD2.xyz = u_xlat1.xyz / u_xlat1.www;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _BlinSpeed;
struct PropsArray_Type {
	vec4 _Color;
};
layout(std140) uniform UnityInstancing_Props {
	PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = log2(u_xlat16_1.x);
    u_xlat0.x = u_xlat16_0 * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_1.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xxx * _RGColor.xyz + (-_BaseColor.xyz);
    u_xlat6 = u_xlat16_1.x * _RGRatio;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + _BaseColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _BaseColor.xyz;
    u_xlat6 = _Time.y * _BlinSpeed;
    u_xlat6 = sin(u_xlat6);
    u_xlat6 = abs(u_xlat6) * 0.300000012 + 0.200000003;
    u_xlat16_1.x = u_xlat6 * PropsArray[0]._Color.y + 1.0;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = _RGBloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _Extent;
uniform 	mediump float _Frequency;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct PropsArray_Type {
	vec4 _Color;
};
layout(std140) uniform UnityInstancing_Props {
	PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = u_xlat0.x * PropsArray[u_xlati3]._Color.x;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.xz = u_xlat0.xx * vec2(vec2(_Extent, _Extent)) + u_xlat1.xz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD2.xyz = u_xlat1.xyz / u_xlat1.www;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _BlinSpeed;
struct PropsArray_Type {
	vec4 _Color;
};
layout(std140) uniform UnityInstancing_Props {
	PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = log2(u_xlat16_1.x);
    u_xlat0.x = u_xlat16_0 * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_1.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xxx * _RGColor.xyz + (-_BaseColor.xyz);
    u_xlat6 = u_xlat16_1.x * _RGRatio;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + _BaseColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _BaseColor.xyz;
    u_xlat6 = _Time.y * _BlinSpeed;
    u_xlat6 = sin(u_xlat6);
    u_xlat6 = abs(u_xlat6) * 0.300000012 + 0.200000003;
    u_xlat16_1.x = u_xlat6 * PropsArray[0]._Color.y + 1.0;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = _RGBloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _Extent;
uniform 	mediump float _Frequency;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct PropsArray_Type {
	vec4 _Color;
};
layout(std140) uniform UnityInstancing_Props {
	PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = u_xlat0.x * PropsArray[u_xlati3]._Color.x;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.xz = u_xlat0.xx * vec2(vec2(_Extent, _Extent)) + u_xlat1.xz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD2.xyz = u_xlat1.xyz / u_xlat1.www;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _BlinSpeed;
struct PropsArray_Type {
	vec4 _Color;
};
layout(std140) uniform UnityInstancing_Props {
	PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = log2(u_xlat16_1.x);
    u_xlat0.x = u_xlat16_0 * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_1.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xxx * _RGColor.xyz + (-_BaseColor.xyz);
    u_xlat6 = u_xlat16_1.x * _RGRatio;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + _BaseColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _BaseColor.xyz;
    u_xlat6 = _Time.y * _BlinSpeed;
    u_xlat6 = sin(u_xlat6);
    u_xlat6 = abs(u_xlat6) * 0.300000012 + 0.200000003;
    u_xlat16_1.x = u_xlat6 * PropsArray[0]._Color.y + 1.0;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = _RGBloomFactor;
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
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
""
}
}
}
}
Fallback "Diffuse"
}