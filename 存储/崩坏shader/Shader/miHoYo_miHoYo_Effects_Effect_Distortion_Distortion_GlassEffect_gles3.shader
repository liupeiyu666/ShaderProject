//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Distortion/Distortion_GlassEffect" {
Properties {
_MainTexture ("MainTexture", 2D) = "white" { }
_MainTextureIntensity ("MainTextureIntensity", Float) = 1
_MainTextureColor ("MainTextureColor", Color) = (1,1,1,0)
_Opacity ("Opacity", Float) = 0
_FresnelColor ("FresnelColor", Color) = (0.1453287,0.6777233,0.9411765,0)
_Fresnel ("Fresnel", Vector) = (0,1,5,0)
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 30960
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _Opacity;
uniform 	vec3 _Fresnel;
uniform 	vec4 _FresnelColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _MainTextureIntensity;
uniform 	vec4 _MainTextureColor;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat3;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnel.xxyz.z;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _Fresnel.xxyz.z * u_xlat0.x + _Fresnel.xxyz.y;
    u_xlat1.xy = vs_TEXCOORD2.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1.xyz = texture(_MainTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_MainTextureIntensity);
    u_xlat1.xyz = u_xlat1.xyz * _MainTextureColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _FresnelColor.xyz + u_xlat1.xyz;
    u_xlat0.w = _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _Opacity;
uniform 	vec3 _Fresnel;
uniform 	vec4 _FresnelColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _MainTextureIntensity;
uniform 	vec4 _MainTextureColor;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat3;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnel.xxyz.z;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _Fresnel.xxyz.z * u_xlat0.x + _Fresnel.xxyz.y;
    u_xlat1.xy = vs_TEXCOORD2.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1.xyz = texture(_MainTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_MainTextureIntensity);
    u_xlat1.xyz = u_xlat1.xyz * _MainTextureColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _FresnelColor.xyz + u_xlat1.xyz;
    u_xlat0.w = _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _Opacity;
uniform 	vec3 _Fresnel;
uniform 	vec4 _FresnelColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _MainTextureIntensity;
uniform 	vec4 _MainTextureColor;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat3;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnel.xxyz.z;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _Fresnel.xxyz.z * u_xlat0.x + _Fresnel.xxyz.y;
    u_xlat1.xy = vs_TEXCOORD2.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1.xyz = texture(_MainTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_MainTextureIntensity);
    u_xlat1.xyz = u_xlat1.xyz * _MainTextureColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _FresnelColor.xyz + u_xlat1.xyz;
    u_xlat0.w = _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
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
CustomEditor "MoleMole.ParticleShaderEditorBase"
}