//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_VertexFire_New" {
Properties {
_MainOffsetTex ("MainOffsetTex", 2D) = "bump" { }
_MainOffsetIntensity ("MainOffsetIntensity", Float) = 1
_MainOffsetSpeed ("MainOffsetSpeed", Vector) = (0,0,0,0)
_DisTex ("DisTex", 2D) = "white" { }
_DisTexSpeed ("DisTexSpeed", Vector) = (0,0,0,0)
_DisTexClip ("DisTexClip", Float) = 0.47
_MainTex ("MainTex", 2D) = "white" { }
_MainLightColor ("MainLightColor", Color) = (0.259434,0.9920127,1,0)
_MainDarkColor ("MainDarkColor", Color) = (1,0.2889685,0,0)
_MainAddColor ("MainAddColor", Color) = (0.3410911,0.9112098,0.990566,0)
_MainAddColClip ("MainAddColClip", Float) = 0.77
_MainAddColorIntensity ("MainAddColorIntensity", Float) = 1
_texcoord ("", 2D) = "white" { }
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 63874
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainOffsetTex_ST;
uniform 	vec2 _MainOffsetSpeed;
uniform 	float _MainOffsetIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainOffsetTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainOffsetTex_ST.xy + _MainOffsetTex_ST.zw;
    u_xlat0.xy = _Time.yy * _MainOffsetSpeed.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_MainOffsetTex, u_xlat0.xy, 0.0).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_1.xyz * in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_MainOffsetIntensity, _MainOffsetIntensity, _MainOffsetIntensity));
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9 = textureLod(_MainTex, u_xlat2.xy, 0.0).x;
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainOffsetTex_ST;
uniform 	vec2 _MainOffsetSpeed;
uniform 	float _DisTexClip;
uniform 	vec4 _DisTex_ST;
uniform 	vec2 _DisTexSpeed;
uniform 	float _MainAddColClip;
uniform 	vec4 _MainAddColor;
uniform 	float _MainAddColorIntensity;
uniform 	vec4 _MainLightColor;
uniform 	vec4 _MainDarkColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DisTex;
uniform lowp sampler2D _MainOffsetTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
vec2 u_xlat2;
mediump float u_xlat16_2;
float u_xlat3;
vec3 u_xlat5;
lowp float u_xlat10_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainOffsetTex_ST.xy + _MainOffsetTex_ST.zw;
    u_xlat0.xy = _Time.yy * _MainOffsetSpeed.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_MainOffsetTex, u_xlat0.xy).z;
    u_xlat16_1 = u_xlat10_0 * 2.0 + -1.0;
    u_xlat0.x = u_xlat16_1 + (-_MainAddColClip);
    u_xlat0.x = u_xlat0.x * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat3) * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * _MainAddColor.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_9 = texture(_MainTex, u_xlat2.xy).x;
    u_xlat16_2 = (-u_xlat10_9) + 1.0;
    u_xlat5.xyz = vec3(u_xlat16_2) * _MainDarkColor.xyz;
    u_xlat5.xyz = vec3(u_xlat10_9) * _MainLightColor.xyz + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_MainAddColorIntensity) + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DisTex_ST.xy + _DisTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DisTexSpeed.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DisTex, u_xlat0.xy).x;
    u_xlat0.x = (-_DisTexClip) * u_xlat16_2 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    SV_Target0.w = min(u_xlat0.x, 1.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainOffsetTex_ST;
uniform 	vec2 _MainOffsetSpeed;
uniform 	float _MainOffsetIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainOffsetTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainOffsetTex_ST.xy + _MainOffsetTex_ST.zw;
    u_xlat0.xy = _Time.yy * _MainOffsetSpeed.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_MainOffsetTex, u_xlat0.xy, 0.0).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_1.xyz * in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_MainOffsetIntensity, _MainOffsetIntensity, _MainOffsetIntensity));
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9 = textureLod(_MainTex, u_xlat2.xy, 0.0).x;
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainOffsetTex_ST;
uniform 	vec2 _MainOffsetSpeed;
uniform 	float _DisTexClip;
uniform 	vec4 _DisTex_ST;
uniform 	vec2 _DisTexSpeed;
uniform 	float _MainAddColClip;
uniform 	vec4 _MainAddColor;
uniform 	float _MainAddColorIntensity;
uniform 	vec4 _MainLightColor;
uniform 	vec4 _MainDarkColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DisTex;
uniform lowp sampler2D _MainOffsetTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
vec2 u_xlat2;
mediump float u_xlat16_2;
float u_xlat3;
vec3 u_xlat5;
lowp float u_xlat10_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainOffsetTex_ST.xy + _MainOffsetTex_ST.zw;
    u_xlat0.xy = _Time.yy * _MainOffsetSpeed.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_MainOffsetTex, u_xlat0.xy).z;
    u_xlat16_1 = u_xlat10_0 * 2.0 + -1.0;
    u_xlat0.x = u_xlat16_1 + (-_MainAddColClip);
    u_xlat0.x = u_xlat0.x * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat3) * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * _MainAddColor.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_9 = texture(_MainTex, u_xlat2.xy).x;
    u_xlat16_2 = (-u_xlat10_9) + 1.0;
    u_xlat5.xyz = vec3(u_xlat16_2) * _MainDarkColor.xyz;
    u_xlat5.xyz = vec3(u_xlat10_9) * _MainLightColor.xyz + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_MainAddColorIntensity) + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DisTex_ST.xy + _DisTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DisTexSpeed.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DisTex, u_xlat0.xy).x;
    u_xlat0.x = (-_DisTexClip) * u_xlat16_2 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    SV_Target0.w = min(u_xlat0.x, 1.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainOffsetTex_ST;
uniform 	vec2 _MainOffsetSpeed;
uniform 	float _MainOffsetIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainOffsetTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainOffsetTex_ST.xy + _MainOffsetTex_ST.zw;
    u_xlat0.xy = _Time.yy * _MainOffsetSpeed.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_MainOffsetTex, u_xlat0.xy, 0.0).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_1.xyz * in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_MainOffsetIntensity, _MainOffsetIntensity, _MainOffsetIntensity));
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9 = textureLod(_MainTex, u_xlat2.xy, 0.0).x;
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainOffsetTex_ST;
uniform 	vec2 _MainOffsetSpeed;
uniform 	float _DisTexClip;
uniform 	vec4 _DisTex_ST;
uniform 	vec2 _DisTexSpeed;
uniform 	float _MainAddColClip;
uniform 	vec4 _MainAddColor;
uniform 	float _MainAddColorIntensity;
uniform 	vec4 _MainLightColor;
uniform 	vec4 _MainDarkColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DisTex;
uniform lowp sampler2D _MainOffsetTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
vec2 u_xlat2;
mediump float u_xlat16_2;
float u_xlat3;
vec3 u_xlat5;
lowp float u_xlat10_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainOffsetTex_ST.xy + _MainOffsetTex_ST.zw;
    u_xlat0.xy = _Time.yy * _MainOffsetSpeed.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_MainOffsetTex, u_xlat0.xy).z;
    u_xlat16_1 = u_xlat10_0 * 2.0 + -1.0;
    u_xlat0.x = u_xlat16_1 + (-_MainAddColClip);
    u_xlat0.x = u_xlat0.x * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat3) * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * _MainAddColor.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_9 = texture(_MainTex, u_xlat2.xy).x;
    u_xlat16_2 = (-u_xlat10_9) + 1.0;
    u_xlat5.xyz = vec3(u_xlat16_2) * _MainDarkColor.xyz;
    u_xlat5.xyz = vec3(u_xlat10_9) * _MainLightColor.xyz + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_MainAddColorIntensity) + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DisTex_ST.xy + _DisTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DisTexSpeed.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DisTex, u_xlat0.xy).x;
    u_xlat0.x = (-_DisTexClip) * u_xlat16_2 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    SV_Target0.w = min(u_xlat0.x, 1.0);
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