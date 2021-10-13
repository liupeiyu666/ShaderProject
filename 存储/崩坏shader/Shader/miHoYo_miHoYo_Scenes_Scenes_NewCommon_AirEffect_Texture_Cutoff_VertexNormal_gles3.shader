//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/AirEffect_Texture_Cutoff_VertexNormal" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_MainColor ("MainColor", Color) = (1,1,1,1)
_MainColorFar ("MainColorFar", Color) = (1,1,1,1)
_LightPosition ("LightPosition", Vector) = (1,1,1,1)
_LightIndensity ("LightIndensity", Range(0, 1)) = 0.5
_fresnelCol ("FresnelCol", Color) = (1,1,1,1)
_fresnelBase ("FresnelBase", Range(0, 1)) = 1
_fresnelScale ("FresnelScale", Range(0, 1)) = 1
_fresnelIndensity ("FresnelIndensity", Range(0, 5)) = 5
_FadeDistance ("Fade Color Start Distance", Range(0.1, 500)) = 0.5
_FadeOffset ("Fade Color Start Offset", Range(0, 500)) = 1
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 40095
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD5;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_NORMAL0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb16 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb16){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat16 = u_xlat16 * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat12.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / vec2(u_xlat16);
        u_xlat16 = u_xlat12.y * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5 = u_xlat5 * in_POSITION0.y;
    u_xlat0 = u_xlat0 * in_POSITION0.x + u_xlat5;
    u_xlat0 = u_xlat10 * in_POSITION0.z + u_xlat0;
    u_xlat0 = u_xlat15 * in_POSITION0.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainColorFar;
uniform 	vec3 _LightPosition;
uniform 	mediump float _LightIndensity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD5;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_NORMAL0;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
int u_xlati15;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati15 = int(u_xlat16_1.x);
    if((u_xlati15)==0){discard;}
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = (-_MainColor.xyz) + _MainColorFar.xyz;
    u_xlat0.xyz = vec3(vs_TEXCOORD5) * u_xlat0.xyz + _MainColor.xyz;
    u_xlat3.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, _LightPosition.xyz);
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat0.xyz = vec3(_LightIndensity) * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD3.xyz;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScale * u_xlat15 + _fresnelBase;
    u_xlat3.xyz = vec3(u_xlat15) * _fresnelCol.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD5;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_NORMAL0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb16 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb16){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat16 = u_xlat16 * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat12.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / vec2(u_xlat16);
        u_xlat16 = u_xlat12.y * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5 = u_xlat5 * in_POSITION0.y;
    u_xlat0 = u_xlat0 * in_POSITION0.x + u_xlat5;
    u_xlat0 = u_xlat10 * in_POSITION0.z + u_xlat0;
    u_xlat0 = u_xlat15 * in_POSITION0.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainColorFar;
uniform 	vec3 _LightPosition;
uniform 	mediump float _LightIndensity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD5;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_NORMAL0;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
int u_xlati15;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati15 = int(u_xlat16_1.x);
    if((u_xlati15)==0){discard;}
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = (-_MainColor.xyz) + _MainColorFar.xyz;
    u_xlat0.xyz = vec3(vs_TEXCOORD5) * u_xlat0.xyz + _MainColor.xyz;
    u_xlat3.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, _LightPosition.xyz);
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat0.xyz = vec3(_LightIndensity) * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD3.xyz;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScale * u_xlat15 + _fresnelBase;
    u_xlat3.xyz = vec3(u_xlat15) * _fresnelCol.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD5;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_NORMAL0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb16 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb16){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat16 = u_xlat16 * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat12.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / vec2(u_xlat16);
        u_xlat16 = u_xlat12.y * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5 = u_xlat5 * in_POSITION0.y;
    u_xlat0 = u_xlat0 * in_POSITION0.x + u_xlat5;
    u_xlat0 = u_xlat10 * in_POSITION0.z + u_xlat0;
    u_xlat0 = u_xlat15 * in_POSITION0.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainColorFar;
uniform 	vec3 _LightPosition;
uniform 	mediump float _LightIndensity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD5;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_NORMAL0;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
int u_xlati15;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati15 = int(u_xlat16_1.x);
    if((u_xlati15)==0){discard;}
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = (-_MainColor.xyz) + _MainColorFar.xyz;
    u_xlat0.xyz = vec3(vs_TEXCOORD5) * u_xlat0.xyz + _MainColor.xyz;
    u_xlat3.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, _LightPosition.xyz);
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat0.xyz = vec3(_LightIndensity) * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD3.xyz;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScale * u_xlat15 + _fresnelBase;
    u_xlat3.xyz = vec3(u_xlat15) * _fresnelCol.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD5;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_NORMAL0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb16 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb16){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat16 = u_xlat16 * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat12.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / vec2(u_xlat16);
        u_xlat16 = u_xlat12.y * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5 = u_xlat5 * in_POSITION0.y;
    u_xlat0 = u_xlat0 * in_POSITION0.x + u_xlat5;
    u_xlat0 = u_xlat10 * in_POSITION0.z + u_xlat0;
    u_xlat0 = u_xlat15 * in_POSITION0.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainColorFar;
uniform 	vec3 _LightPosition;
uniform 	mediump float _LightIndensity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD5;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_NORMAL0;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat18;
int u_xlati18;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati18 = int(u_xlat16_1.x);
    if((u_xlati18)==0){discard;}
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = (-_MainColor.xyz) + _MainColorFar.xyz;
    u_xlat3.xyz = vec3(vs_TEXCOORD5) * u_xlat3.xyz + _MainColor.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat18 = dot(u_xlat4.xyz, _LightPosition.xyz);
    u_xlat18 = u_xlat18 * 0.5 + 1.0;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat3.xyz = vec3(_LightIndensity) * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD3.xyz;
    u_xlat18 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScale * u_xlat18 + _fresnelBase;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelCol.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat3.xyz + u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD5;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_NORMAL0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb16 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb16){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat16 = u_xlat16 * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat12.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / vec2(u_xlat16);
        u_xlat16 = u_xlat12.y * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5 = u_xlat5 * in_POSITION0.y;
    u_xlat0 = u_xlat0 * in_POSITION0.x + u_xlat5;
    u_xlat0 = u_xlat10 * in_POSITION0.z + u_xlat0;
    u_xlat0 = u_xlat15 * in_POSITION0.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainColorFar;
uniform 	vec3 _LightPosition;
uniform 	mediump float _LightIndensity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD5;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_NORMAL0;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat18;
int u_xlati18;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati18 = int(u_xlat16_1.x);
    if((u_xlati18)==0){discard;}
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = (-_MainColor.xyz) + _MainColorFar.xyz;
    u_xlat3.xyz = vec3(vs_TEXCOORD5) * u_xlat3.xyz + _MainColor.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat18 = dot(u_xlat4.xyz, _LightPosition.xyz);
    u_xlat18 = u_xlat18 * 0.5 + 1.0;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat3.xyz = vec3(_LightIndensity) * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD3.xyz;
    u_xlat18 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScale * u_xlat18 + _fresnelBase;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelCol.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat3.xyz + u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD5;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_NORMAL0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb16 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb16){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat16 = u_xlat16 * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat12.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / vec2(u_xlat16);
        u_xlat16 = u_xlat12.y * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5 = u_xlat5 * in_POSITION0.y;
    u_xlat0 = u_xlat0 * in_POSITION0.x + u_xlat5;
    u_xlat0 = u_xlat10 * in_POSITION0.z + u_xlat0;
    u_xlat0 = u_xlat15 * in_POSITION0.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainColorFar;
uniform 	vec3 _LightPosition;
uniform 	mediump float _LightIndensity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD5;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_NORMAL0;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat18;
int u_xlati18;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati18 = int(u_xlat16_1.x);
    if((u_xlati18)==0){discard;}
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = (-_MainColor.xyz) + _MainColorFar.xyz;
    u_xlat3.xyz = vec3(vs_TEXCOORD5) * u_xlat3.xyz + _MainColor.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat18 = dot(u_xlat4.xyz, _LightPosition.xyz);
    u_xlat18 = u_xlat18 * 0.5 + 1.0;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat3.xyz = vec3(_LightIndensity) * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat18 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD3.xyz;
    u_xlat18 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScale * u_xlat18 + _fresnelBase;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelCol.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat3.xyz + u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD5;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb16 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb16){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat16 = u_xlat16 * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat12.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / vec2(u_xlat16);
        u_xlat16 = u_xlat12.y * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat12.xy = u_xlat1.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat16 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat16 = u_xlat16 + (-_UWFogDistStart);
    u_xlat16 = max(u_xlat16, 0.0);
    u_xlat12.xy = vec2(u_xlat16) * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
    u_xlat3.xy = exp2(u_xlat12.xy);
    u_xlat16 = (-u_xlat3.x) + 1.0;
    u_xlat16 = u_xlat16 * _UWFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWFogEffectStart);
    u_xlat3.z = min(u_xlat16, _UWFogEffectLimit);
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5 = u_xlat5 * in_POSITION0.y;
    u_xlat0 = u_xlat0 * in_POSITION0.x + u_xlat5;
    u_xlat0 = u_xlat10 * in_POSITION0.z + u_xlat0;
    u_xlat0 = u_xlat15 * in_POSITION0.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat3.w = u_xlat1.y;
    vs_TEXCOORD1.xyz = u_xlat3.yzw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainColorFar;
uniform 	vec3 _LightPosition;
uniform 	mediump float _LightIndensity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD5;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_NORMAL0;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
bool u_xlatb10;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati12 = int(u_xlat16_1.x);
    if((u_xlati12)==0){discard;}
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD1.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD1.z<_WaterPlaneHeight;
#endif
    u_xlat2.x = (-vs_TEXCOORD1.z) + _WaterPlaneHeight;
    u_xlat6 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat2.x = u_xlat2.x / u_xlat6;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat3.x = u_xlat2.x * _UWFogColorHLIntensity;
    u_xlat6 = (-_UWHeightFogDensity) * u_xlat2.x + 1.0;
    u_xlat6 = u_xlat6 * _UWHeightFogEffectLimit;
    u_xlat6 = max(u_xlat6, _UWHeightFogEffectStart);
    u_xlat6 = min(u_xlat6, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.99000001<vs_TEXCOORD1.y);
#else
    u_xlatb10 = 0.99000001<vs_TEXCOORD1.y;
#endif
    u_xlat2.x = (-u_xlat2.x) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD1.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat16_13 = (u_xlatb10) ? u_xlat2.x : vs_TEXCOORD1.y;
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat2.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xzw = vs_TEXCOORD1.xxx * u_xlat2.xzw + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-u_xlat2.xzw);
    u_xlat0.xyz = vec3(u_xlat16_13) * u_xlat0.xyz + u_xlat2.xzw;
    u_xlat2.xzw = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xzw = u_xlat3.xxx * u_xlat2.xzw + _UWFogColorLow.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xzw);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + u_xlat2.xzw;
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat0.xyz = (-_MainColor.xyz) + _MainColorFar.xyz;
    u_xlat0.xyz = vec3(vs_TEXCOORD5) * u_xlat0.xyz + _MainColor.xyz;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, _LightPosition.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 1.0;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat0.xyz = vec3(_LightIndensity) * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _fresnelIndensity;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = _fresnelScale * u_xlat12 + _fresnelBase;
    u_xlat2.xyz = vec3(u_xlat12) * _fresnelCol.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD5;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb16 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb16){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat16 = u_xlat16 * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat12.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / vec2(u_xlat16);
        u_xlat16 = u_xlat12.y * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat12.xy = u_xlat1.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat16 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat16 = u_xlat16 + (-_UWFogDistStart);
    u_xlat16 = max(u_xlat16, 0.0);
    u_xlat12.xy = vec2(u_xlat16) * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
    u_xlat3.xy = exp2(u_xlat12.xy);
    u_xlat16 = (-u_xlat3.x) + 1.0;
    u_xlat16 = u_xlat16 * _UWFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWFogEffectStart);
    u_xlat3.z = min(u_xlat16, _UWFogEffectLimit);
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5 = u_xlat5 * in_POSITION0.y;
    u_xlat0 = u_xlat0 * in_POSITION0.x + u_xlat5;
    u_xlat0 = u_xlat10 * in_POSITION0.z + u_xlat0;
    u_xlat0 = u_xlat15 * in_POSITION0.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat3.w = u_xlat1.y;
    vs_TEXCOORD1.xyz = u_xlat3.yzw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainColorFar;
uniform 	vec3 _LightPosition;
uniform 	mediump float _LightIndensity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD5;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_NORMAL0;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
bool u_xlatb10;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati12 = int(u_xlat16_1.x);
    if((u_xlati12)==0){discard;}
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD1.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD1.z<_WaterPlaneHeight;
#endif
    u_xlat2.x = (-vs_TEXCOORD1.z) + _WaterPlaneHeight;
    u_xlat6 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat2.x = u_xlat2.x / u_xlat6;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat3.x = u_xlat2.x * _UWFogColorHLIntensity;
    u_xlat6 = (-_UWHeightFogDensity) * u_xlat2.x + 1.0;
    u_xlat6 = u_xlat6 * _UWHeightFogEffectLimit;
    u_xlat6 = max(u_xlat6, _UWHeightFogEffectStart);
    u_xlat6 = min(u_xlat6, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.99000001<vs_TEXCOORD1.y);
#else
    u_xlatb10 = 0.99000001<vs_TEXCOORD1.y;
#endif
    u_xlat2.x = (-u_xlat2.x) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD1.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat16_13 = (u_xlatb10) ? u_xlat2.x : vs_TEXCOORD1.y;
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat2.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xzw = vs_TEXCOORD1.xxx * u_xlat2.xzw + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-u_xlat2.xzw);
    u_xlat0.xyz = vec3(u_xlat16_13) * u_xlat0.xyz + u_xlat2.xzw;
    u_xlat2.xzw = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xzw = u_xlat3.xxx * u_xlat2.xzw + _UWFogColorLow.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xzw);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + u_xlat2.xzw;
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat0.xyz = (-_MainColor.xyz) + _MainColorFar.xyz;
    u_xlat0.xyz = vec3(vs_TEXCOORD5) * u_xlat0.xyz + _MainColor.xyz;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, _LightPosition.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 1.0;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat0.xyz = vec3(_LightIndensity) * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _fresnelIndensity;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = _fresnelScale * u_xlat12 + _fresnelBase;
    u_xlat2.xyz = vec3(u_xlat12) * _fresnelCol.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD5;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb16 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb16){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat16 = u_xlat16 * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat12.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / vec2(u_xlat16);
        u_xlat16 = u_xlat12.y * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat12.xy = u_xlat1.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat16 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat16 = u_xlat16 + (-_UWFogDistStart);
    u_xlat16 = max(u_xlat16, 0.0);
    u_xlat12.xy = vec2(u_xlat16) * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
    u_xlat3.xy = exp2(u_xlat12.xy);
    u_xlat16 = (-u_xlat3.x) + 1.0;
    u_xlat16 = u_xlat16 * _UWFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWFogEffectStart);
    u_xlat3.z = min(u_xlat16, _UWFogEffectLimit);
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5 = u_xlat5 * in_POSITION0.y;
    u_xlat0 = u_xlat0 * in_POSITION0.x + u_xlat5;
    u_xlat0 = u_xlat10 * in_POSITION0.z + u_xlat0;
    u_xlat0 = u_xlat15 * in_POSITION0.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat3.w = u_xlat1.y;
    vs_TEXCOORD1.xyz = u_xlat3.yzw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainColorFar;
uniform 	vec3 _LightPosition;
uniform 	mediump float _LightIndensity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD5;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_NORMAL0;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
bool u_xlatb10;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati12 = int(u_xlat16_1.x);
    if((u_xlati12)==0){discard;}
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD1.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD1.z<_WaterPlaneHeight;
#endif
    u_xlat2.x = (-vs_TEXCOORD1.z) + _WaterPlaneHeight;
    u_xlat6 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat2.x = u_xlat2.x / u_xlat6;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat3.x = u_xlat2.x * _UWFogColorHLIntensity;
    u_xlat6 = (-_UWHeightFogDensity) * u_xlat2.x + 1.0;
    u_xlat6 = u_xlat6 * _UWHeightFogEffectLimit;
    u_xlat6 = max(u_xlat6, _UWHeightFogEffectStart);
    u_xlat6 = min(u_xlat6, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.99000001<vs_TEXCOORD1.y);
#else
    u_xlatb10 = 0.99000001<vs_TEXCOORD1.y;
#endif
    u_xlat2.x = (-u_xlat2.x) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD1.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat16_13 = (u_xlatb10) ? u_xlat2.x : vs_TEXCOORD1.y;
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat2.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xzw = vs_TEXCOORD1.xxx * u_xlat2.xzw + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-u_xlat2.xzw);
    u_xlat0.xyz = vec3(u_xlat16_13) * u_xlat0.xyz + u_xlat2.xzw;
    u_xlat2.xzw = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xzw = u_xlat3.xxx * u_xlat2.xzw + _UWFogColorLow.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xzw);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + u_xlat2.xzw;
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat0.xyz = (-_MainColor.xyz) + _MainColorFar.xyz;
    u_xlat0.xyz = vec3(vs_TEXCOORD5) * u_xlat0.xyz + _MainColor.xyz;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, _LightPosition.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 1.0;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat0.xyz = vec3(_LightIndensity) * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _fresnelIndensity;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = _fresnelScale * u_xlat12 + _fresnelBase;
    u_xlat2.xyz = vec3(u_xlat12) * _fresnelCol.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD5;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb16 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb16){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat16 = u_xlat16 * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat12.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / vec2(u_xlat16);
        u_xlat16 = u_xlat12.y * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat12.xy = u_xlat1.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat16 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat16 = u_xlat16 + (-_UWFogDistStart);
    u_xlat16 = max(u_xlat16, 0.0);
    u_xlat12.xy = vec2(u_xlat16) * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
    u_xlat3.xy = exp2(u_xlat12.xy);
    u_xlat16 = (-u_xlat3.x) + 1.0;
    u_xlat16 = u_xlat16 * _UWFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWFogEffectStart);
    u_xlat3.z = min(u_xlat16, _UWFogEffectLimit);
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5 = u_xlat5 * in_POSITION0.y;
    u_xlat0 = u_xlat0 * in_POSITION0.x + u_xlat5;
    u_xlat0 = u_xlat10 * in_POSITION0.z + u_xlat0;
    u_xlat0 = u_xlat15 * in_POSITION0.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat3.w = u_xlat1.y;
    vs_TEXCOORD1.xyz = u_xlat3.yzw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainColorFar;
uniform 	vec3 _LightPosition;
uniform 	mediump float _LightIndensity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD5;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_NORMAL0;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat7;
bool u_xlatb12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati15 = int(u_xlat16_1.x);
    if((u_xlati15)==0){discard;}
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD1.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD1.z<_WaterPlaneHeight;
#endif
    u_xlat2.x = (-vs_TEXCOORD1.z) + _WaterPlaneHeight;
    u_xlat7 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat2.x = u_xlat2.x / u_xlat7;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat3.x = u_xlat2.x * _UWFogColorHLIntensity;
    u_xlat7 = (-_UWHeightFogDensity) * u_xlat2.x + 1.0;
    u_xlat7 = u_xlat7 * _UWHeightFogEffectLimit;
    u_xlat7 = max(u_xlat7, _UWHeightFogEffectStart);
    u_xlat7 = min(u_xlat7, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.99000001<vs_TEXCOORD1.y);
#else
    u_xlatb12 = 0.99000001<vs_TEXCOORD1.y;
#endif
    u_xlat2.x = (-u_xlat2.x) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD1.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat16_16 = (u_xlatb12) ? u_xlat2.x : vs_TEXCOORD1.y;
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat2.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xzw = vs_TEXCOORD1.xxx * u_xlat2.xzw + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-u_xlat2.xzw);
    u_xlat0.xyz = vec3(u_xlat16_16) * u_xlat0.xyz + u_xlat2.xzw;
    u_xlat2.xzw = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xzw = u_xlat3.xxx * u_xlat2.xzw + _UWFogColorLow.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xzw);
    u_xlat0.xyz = vec3(u_xlat7) * u_xlat0.xyz + u_xlat2.xzw;
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-_MainColor.xyz) + _MainColorFar.xyz;
    u_xlat2.xyz = vec3(vs_TEXCOORD5) * u_xlat2.xyz + _MainColor.xyz;
    u_xlat3.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, _LightPosition.xyz);
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.xyz = vec3(_LightIndensity) * vec3(u_xlat15) + u_xlat2.xyz;
    u_xlat15 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD3.xyz;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScale * u_xlat15 + _fresnelBase;
    u_xlat3.xyz = vec3(u_xlat15) * _fresnelCol.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD5;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb16 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb16){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat16 = u_xlat16 * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat12.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / vec2(u_xlat16);
        u_xlat16 = u_xlat12.y * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat12.xy = u_xlat1.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat16 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat16 = u_xlat16 + (-_UWFogDistStart);
    u_xlat16 = max(u_xlat16, 0.0);
    u_xlat12.xy = vec2(u_xlat16) * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
    u_xlat3.xy = exp2(u_xlat12.xy);
    u_xlat16 = (-u_xlat3.x) + 1.0;
    u_xlat16 = u_xlat16 * _UWFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWFogEffectStart);
    u_xlat3.z = min(u_xlat16, _UWFogEffectLimit);
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5 = u_xlat5 * in_POSITION0.y;
    u_xlat0 = u_xlat0 * in_POSITION0.x + u_xlat5;
    u_xlat0 = u_xlat10 * in_POSITION0.z + u_xlat0;
    u_xlat0 = u_xlat15 * in_POSITION0.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat3.w = u_xlat1.y;
    vs_TEXCOORD1.xyz = u_xlat3.yzw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainColorFar;
uniform 	vec3 _LightPosition;
uniform 	mediump float _LightIndensity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD5;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_NORMAL0;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat7;
bool u_xlatb12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati15 = int(u_xlat16_1.x);
    if((u_xlati15)==0){discard;}
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD1.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD1.z<_WaterPlaneHeight;
#endif
    u_xlat2.x = (-vs_TEXCOORD1.z) + _WaterPlaneHeight;
    u_xlat7 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat2.x = u_xlat2.x / u_xlat7;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat3.x = u_xlat2.x * _UWFogColorHLIntensity;
    u_xlat7 = (-_UWHeightFogDensity) * u_xlat2.x + 1.0;
    u_xlat7 = u_xlat7 * _UWHeightFogEffectLimit;
    u_xlat7 = max(u_xlat7, _UWHeightFogEffectStart);
    u_xlat7 = min(u_xlat7, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.99000001<vs_TEXCOORD1.y);
#else
    u_xlatb12 = 0.99000001<vs_TEXCOORD1.y;
#endif
    u_xlat2.x = (-u_xlat2.x) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD1.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat16_16 = (u_xlatb12) ? u_xlat2.x : vs_TEXCOORD1.y;
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat2.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xzw = vs_TEXCOORD1.xxx * u_xlat2.xzw + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-u_xlat2.xzw);
    u_xlat0.xyz = vec3(u_xlat16_16) * u_xlat0.xyz + u_xlat2.xzw;
    u_xlat2.xzw = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xzw = u_xlat3.xxx * u_xlat2.xzw + _UWFogColorLow.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xzw);
    u_xlat0.xyz = vec3(u_xlat7) * u_xlat0.xyz + u_xlat2.xzw;
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-_MainColor.xyz) + _MainColorFar.xyz;
    u_xlat2.xyz = vec3(vs_TEXCOORD5) * u_xlat2.xyz + _MainColor.xyz;
    u_xlat3.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, _LightPosition.xyz);
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.xyz = vec3(_LightIndensity) * vec3(u_xlat15) + u_xlat2.xyz;
    u_xlat15 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD3.xyz;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScale * u_xlat15 + _fresnelBase;
    u_xlat3.xyz = vec3(u_xlat15) * _fresnelCol.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD5;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb16 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb16){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat16 = u_xlat16 * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat12.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat16 = sqrt(u_xlat16);
        u_xlat16 = u_xlat16 + (-_FogStartDistance);
        u_xlat16 = max(u_xlat16, 0.0);
        u_xlat12.xy = vec2(u_xlat16) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / vec2(u_xlat16);
        u_xlat16 = u_xlat12.y * _FogEffectLimit;
        u_xlat16 = max(u_xlat16, _FogEffectStart);
        u_xlat3.w = min(u_xlat16, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat16 = (-u_xlat12.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat12.xy = u_xlat1.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat16 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat16 = u_xlat16 + (-_UWFogDistStart);
    u_xlat16 = max(u_xlat16, 0.0);
    u_xlat12.xy = vec2(u_xlat16) * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
    u_xlat3.xy = exp2(u_xlat12.xy);
    u_xlat16 = (-u_xlat3.x) + 1.0;
    u_xlat16 = u_xlat16 * _UWFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWFogEffectStart);
    u_xlat3.z = min(u_xlat16, _UWFogEffectLimit);
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5 = u_xlat5 * in_POSITION0.y;
    u_xlat0 = u_xlat0 * in_POSITION0.x + u_xlat5;
    u_xlat0 = u_xlat10 * in_POSITION0.z + u_xlat0;
    u_xlat0 = u_xlat15 * in_POSITION0.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat3.w = u_xlat1.y;
    vs_TEXCOORD1.xyz = u_xlat3.yzw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainColorFar;
uniform 	vec3 _LightPosition;
uniform 	mediump float _LightIndensity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD5;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_NORMAL0;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat7;
bool u_xlatb12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati15 = int(u_xlat16_1.x);
    if((u_xlati15)==0){discard;}
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD1.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD1.z<_WaterPlaneHeight;
#endif
    u_xlat2.x = (-vs_TEXCOORD1.z) + _WaterPlaneHeight;
    u_xlat7 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat2.x = u_xlat2.x / u_xlat7;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat3.x = u_xlat2.x * _UWFogColorHLIntensity;
    u_xlat7 = (-_UWHeightFogDensity) * u_xlat2.x + 1.0;
    u_xlat7 = u_xlat7 * _UWHeightFogEffectLimit;
    u_xlat7 = max(u_xlat7, _UWHeightFogEffectStart);
    u_xlat7 = min(u_xlat7, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.99000001<vs_TEXCOORD1.y);
#else
    u_xlatb12 = 0.99000001<vs_TEXCOORD1.y;
#endif
    u_xlat2.x = (-u_xlat2.x) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD1.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat16_16 = (u_xlatb12) ? u_xlat2.x : vs_TEXCOORD1.y;
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat2.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xzw = vs_TEXCOORD1.xxx * u_xlat2.xzw + _UWFogColorFar.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-u_xlat2.xzw);
    u_xlat0.xyz = vec3(u_xlat16_16) * u_xlat0.xyz + u_xlat2.xzw;
    u_xlat2.xzw = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xzw = u_xlat3.xxx * u_xlat2.xzw + _UWFogColorLow.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xzw);
    u_xlat0.xyz = vec3(u_xlat7) * u_xlat0.xyz + u_xlat2.xzw;
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-_MainColor.xyz) + _MainColorFar.xyz;
    u_xlat2.xyz = vec3(vs_TEXCOORD5) * u_xlat2.xyz + _MainColor.xyz;
    u_xlat3.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, _LightPosition.xyz);
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.xyz = vec3(_LightIndensity) * vec3(u_xlat15) + u_xlat2.xyz;
    u_xlat15 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD3.xyz;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScale * u_xlat15 + _fresnelBase;
    u_xlat3.xyz = vec3(u_xlat15) * _fresnelCol.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
}
}
}
}