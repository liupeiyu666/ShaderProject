//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/Scene_Air_LightMap_Matcap_CamClip" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_LightMapIntensity ("Light Map Intensity", Float) = 1
[MHYHeaderBox(MATCAP)] _MatcapMaskMap ("MatcapMask Map", 2D) = "white" { }
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
[MHYHeaderBox(Fresnel)] _fresnelColA ("FresnelCol", Color) = (1,1,1,1)
_fresnelBaseA ("FresnelBase", Range(0, 4)) = 0
_fresnelScaleA ("FresnelScale", Range(0, 4)) = 0
_fresnelIndensity ("FresnelIndensity", Range(0, 5)) = 5
[MHYHeaderBox(FOG)] _FogTune ("Fog Tune", Range(0, 1)) = 1
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
}
SubShader {
 Tags { "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
  GpuProgramID 2373
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
uniform 	vec4 _BumpMap_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat21;
vec2 u_xlat27;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0.x;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat10;
    u_xlat20 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat20;
    u_xlat30 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat30;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.zxy * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.yzx * u_xlat4.yzx + (-u_xlat16_5.xyz);
    u_xlat6.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat31 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat7.xyz = vec3(u_xlat31) * in_NORMAL0.zxy;
    u_xlat31 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * in_TANGENT0.yzx;
    u_xlat9.xyz = u_xlat7.xyz * u_xlat8.xyz;
    u_xlat7.xyz = u_xlat7.zxy * u_xlat8.yzx + (-u_xlat9.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-in_POSITION0.xyz);
    u_xlat9.x = dot(in_TANGENT0.xyz, (-u_xlat8.xyz));
    u_xlat9.y = dot(u_xlat7.xyz, (-u_xlat8.xyz));
    u_xlat9.z = dot(in_NORMAL0.xyz, (-u_xlat8.xyz));
    u_xlat31 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    vs_TEXCOORD5.xyz = vec3(u_xlat31) * u_xlat9.xyz;
    u_xlat7.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb31 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb31){
        u_xlat8.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat31 = sqrt(u_xlat31);
        u_xlat31 = u_xlat31 + (-_FogStartDistance);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat27.xy = vec2(u_xlat31) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat27.xy = u_xlat27.xy * (-u_xlat27.xy);
        u_xlat31 = u_xlat27.x * _FogTune;
        u_xlat31 = u_xlat31 * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat31 = (-u_xlat31) + 1.0;
        u_xlat31 = u_xlat31 * _FogEffectLimit;
        u_xlat32 = _FogEffectStart * _FogTune;
        u_xlat31 = max(u_xlat31, u_xlat32);
        u_xlat5.w = min(u_xlat31, _FogEffectLimit);
        u_xlat31 = u_xlat27.y * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat21);
        u_xlat11.x = u_xlat1.y * _FogEffectLimit;
        u_xlat21 = _FogEffectStart * _FogTune;
        u_xlat11.x = max(u_xlat21, u_xlat11.x);
        u_xlat5.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat1.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    u_xlat10 = u_xlat10 * in_POSITION0.y;
    u_xlat0.x = u_xlat0.x * in_POSITION0.x + u_xlat10;
    u_xlat0.x = u_xlat20 * in_POSITION0.z + u_xlat0.x;
    u_xlat0.x = u_xlat30 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.z;
    u_xlat0.y = u_xlat6.x;
    u_xlat0.z = u_xlat3.x;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat4.x;
    u_xlat0.y = u_xlat6.y;
    u_xlat0.z = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.x = u_xlat4.y;
    u_xlat3.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.xy = u_xlat7.xy;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD5.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 _BumpMap_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat21;
vec2 u_xlat27;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0.x;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat10;
    u_xlat20 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat20;
    u_xlat30 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat30;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.zxy * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.yzx * u_xlat4.yzx + (-u_xlat16_5.xyz);
    u_xlat6.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat31 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat7.xyz = vec3(u_xlat31) * in_NORMAL0.zxy;
    u_xlat31 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * in_TANGENT0.yzx;
    u_xlat9.xyz = u_xlat7.xyz * u_xlat8.xyz;
    u_xlat7.xyz = u_xlat7.zxy * u_xlat8.yzx + (-u_xlat9.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-in_POSITION0.xyz);
    u_xlat9.x = dot(in_TANGENT0.xyz, (-u_xlat8.xyz));
    u_xlat9.y = dot(u_xlat7.xyz, (-u_xlat8.xyz));
    u_xlat9.z = dot(in_NORMAL0.xyz, (-u_xlat8.xyz));
    u_xlat31 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    vs_TEXCOORD5.xyz = vec3(u_xlat31) * u_xlat9.xyz;
    u_xlat7.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb31 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb31){
        u_xlat8.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat31 = sqrt(u_xlat31);
        u_xlat31 = u_xlat31 + (-_FogStartDistance);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat27.xy = vec2(u_xlat31) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat27.xy = u_xlat27.xy * (-u_xlat27.xy);
        u_xlat31 = u_xlat27.x * _FogTune;
        u_xlat31 = u_xlat31 * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat31 = (-u_xlat31) + 1.0;
        u_xlat31 = u_xlat31 * _FogEffectLimit;
        u_xlat32 = _FogEffectStart * _FogTune;
        u_xlat31 = max(u_xlat31, u_xlat32);
        u_xlat5.w = min(u_xlat31, _FogEffectLimit);
        u_xlat31 = u_xlat27.y * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat21);
        u_xlat11.x = u_xlat1.y * _FogEffectLimit;
        u_xlat21 = _FogEffectStart * _FogTune;
        u_xlat11.x = max(u_xlat21, u_xlat11.x);
        u_xlat5.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat1.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    u_xlat10 = u_xlat10 * in_POSITION0.y;
    u_xlat0.x = u_xlat0.x * in_POSITION0.x + u_xlat10;
    u_xlat0.x = u_xlat20 * in_POSITION0.z + u_xlat0.x;
    u_xlat0.x = u_xlat30 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.z;
    u_xlat0.y = u_xlat6.x;
    u_xlat0.z = u_xlat3.x;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat4.x;
    u_xlat0.y = u_xlat6.y;
    u_xlat0.z = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.x = u_xlat4.y;
    u_xlat3.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.xy = u_xlat7.xy;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD5.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 _BumpMap_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat21;
vec2 u_xlat27;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0.x;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat10;
    u_xlat20 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat20;
    u_xlat30 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat30;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.zxy * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.yzx * u_xlat4.yzx + (-u_xlat16_5.xyz);
    u_xlat6.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat31 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat7.xyz = vec3(u_xlat31) * in_NORMAL0.zxy;
    u_xlat31 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * in_TANGENT0.yzx;
    u_xlat9.xyz = u_xlat7.xyz * u_xlat8.xyz;
    u_xlat7.xyz = u_xlat7.zxy * u_xlat8.yzx + (-u_xlat9.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-in_POSITION0.xyz);
    u_xlat9.x = dot(in_TANGENT0.xyz, (-u_xlat8.xyz));
    u_xlat9.y = dot(u_xlat7.xyz, (-u_xlat8.xyz));
    u_xlat9.z = dot(in_NORMAL0.xyz, (-u_xlat8.xyz));
    u_xlat31 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    vs_TEXCOORD5.xyz = vec3(u_xlat31) * u_xlat9.xyz;
    u_xlat7.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb31 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb31){
        u_xlat8.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat31 = sqrt(u_xlat31);
        u_xlat31 = u_xlat31 + (-_FogStartDistance);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat27.xy = vec2(u_xlat31) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat27.xy = u_xlat27.xy * (-u_xlat27.xy);
        u_xlat31 = u_xlat27.x * _FogTune;
        u_xlat31 = u_xlat31 * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat31 = (-u_xlat31) + 1.0;
        u_xlat31 = u_xlat31 * _FogEffectLimit;
        u_xlat32 = _FogEffectStart * _FogTune;
        u_xlat31 = max(u_xlat31, u_xlat32);
        u_xlat5.w = min(u_xlat31, _FogEffectLimit);
        u_xlat31 = u_xlat27.y * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat21);
        u_xlat11.x = u_xlat1.y * _FogEffectLimit;
        u_xlat21 = _FogEffectStart * _FogTune;
        u_xlat11.x = max(u_xlat21, u_xlat11.x);
        u_xlat5.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat1.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    u_xlat10 = u_xlat10 * in_POSITION0.y;
    u_xlat0.x = u_xlat0.x * in_POSITION0.x + u_xlat10;
    u_xlat0.x = u_xlat20 * in_POSITION0.z + u_xlat0.x;
    u_xlat0.x = u_xlat30 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.z;
    u_xlat0.y = u_xlat6.x;
    u_xlat0.z = u_xlat3.x;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat4.x;
    u_xlat0.y = u_xlat6.y;
    u_xlat0.z = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.x = u_xlat4.y;
    u_xlat3.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.xy = u_xlat7.xy;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD5.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" }
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
uniform 	vec4 _BumpMap_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat21;
vec2 u_xlat27;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0.x;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat10;
    u_xlat20 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat20;
    u_xlat30 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat30;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.zxy * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.yzx * u_xlat4.yzx + (-u_xlat16_5.xyz);
    u_xlat6.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat31 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat7.xyz = vec3(u_xlat31) * in_NORMAL0.zxy;
    u_xlat31 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * in_TANGENT0.yzx;
    u_xlat9.xyz = u_xlat7.xyz * u_xlat8.xyz;
    u_xlat7.xyz = u_xlat7.zxy * u_xlat8.yzx + (-u_xlat9.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-in_POSITION0.xyz);
    u_xlat9.x = dot(in_TANGENT0.xyz, (-u_xlat8.xyz));
    u_xlat9.y = dot(u_xlat7.xyz, (-u_xlat8.xyz));
    u_xlat9.z = dot(in_NORMAL0.xyz, (-u_xlat8.xyz));
    u_xlat31 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    vs_TEXCOORD5.xyz = vec3(u_xlat31) * u_xlat9.xyz;
    u_xlat7.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb31 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb31){
        u_xlat8.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat31 = sqrt(u_xlat31);
        u_xlat31 = u_xlat31 + (-_FogStartDistance);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat27.xy = vec2(u_xlat31) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat27.xy = u_xlat27.xy * (-u_xlat27.xy);
        u_xlat31 = u_xlat27.x * _FogTune;
        u_xlat31 = u_xlat31 * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat31 = (-u_xlat31) + 1.0;
        u_xlat31 = u_xlat31 * _FogEffectLimit;
        u_xlat32 = _FogEffectStart * _FogTune;
        u_xlat31 = max(u_xlat31, u_xlat32);
        u_xlat5.w = min(u_xlat31, _FogEffectLimit);
        u_xlat31 = u_xlat27.y * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat21);
        u_xlat11.x = u_xlat1.y * _FogEffectLimit;
        u_xlat21 = _FogEffectStart * _FogTune;
        u_xlat11.x = max(u_xlat21, u_xlat11.x);
        u_xlat5.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat1.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    u_xlat10 = u_xlat10 * in_POSITION0.y;
    u_xlat0.x = u_xlat0.x * in_POSITION0.x + u_xlat10;
    u_xlat0.x = u_xlat20 * in_POSITION0.z + u_xlat0.x;
    u_xlat0.x = u_xlat30 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.z;
    u_xlat0.y = u_xlat6.x;
    u_xlat0.z = u_xlat3.x;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat4.x;
    u_xlat0.y = u_xlat6.y;
    u_xlat0.z = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.x = u_xlat4.y;
    u_xlat3.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.xy = u_xlat7.xy;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD5.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
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
uniform 	vec4 _BumpMap_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat21;
vec2 u_xlat27;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0.x;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat10;
    u_xlat20 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat20;
    u_xlat30 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat30;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.zxy * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.yzx * u_xlat4.yzx + (-u_xlat16_5.xyz);
    u_xlat6.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat31 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat7.xyz = vec3(u_xlat31) * in_NORMAL0.zxy;
    u_xlat31 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * in_TANGENT0.yzx;
    u_xlat9.xyz = u_xlat7.xyz * u_xlat8.xyz;
    u_xlat7.xyz = u_xlat7.zxy * u_xlat8.yzx + (-u_xlat9.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-in_POSITION0.xyz);
    u_xlat9.x = dot(in_TANGENT0.xyz, (-u_xlat8.xyz));
    u_xlat9.y = dot(u_xlat7.xyz, (-u_xlat8.xyz));
    u_xlat9.z = dot(in_NORMAL0.xyz, (-u_xlat8.xyz));
    u_xlat31 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    vs_TEXCOORD5.xyz = vec3(u_xlat31) * u_xlat9.xyz;
    u_xlat7.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb31 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb31){
        u_xlat8.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat31 = sqrt(u_xlat31);
        u_xlat31 = u_xlat31 + (-_FogStartDistance);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat27.xy = vec2(u_xlat31) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat27.xy = u_xlat27.xy * (-u_xlat27.xy);
        u_xlat31 = u_xlat27.x * _FogTune;
        u_xlat31 = u_xlat31 * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat31 = (-u_xlat31) + 1.0;
        u_xlat31 = u_xlat31 * _FogEffectLimit;
        u_xlat32 = _FogEffectStart * _FogTune;
        u_xlat31 = max(u_xlat31, u_xlat32);
        u_xlat5.w = min(u_xlat31, _FogEffectLimit);
        u_xlat31 = u_xlat27.y * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat21);
        u_xlat11.x = u_xlat1.y * _FogEffectLimit;
        u_xlat21 = _FogEffectStart * _FogTune;
        u_xlat11.x = max(u_xlat21, u_xlat11.x);
        u_xlat5.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat1.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    u_xlat10 = u_xlat10 * in_POSITION0.y;
    u_xlat0.x = u_xlat0.x * in_POSITION0.x + u_xlat10;
    u_xlat0.x = u_xlat20 * in_POSITION0.z + u_xlat0.x;
    u_xlat0.x = u_xlat30 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.z;
    u_xlat0.y = u_xlat6.x;
    u_xlat0.z = u_xlat3.x;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat4.x;
    u_xlat0.y = u_xlat6.y;
    u_xlat0.z = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.x = u_xlat4.y;
    u_xlat3.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.xy = u_xlat7.xy;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD5.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
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
uniform 	vec4 _BumpMap_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat21;
vec2 u_xlat27;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0.x;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat10;
    u_xlat20 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat20;
    u_xlat30 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat30;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.zxy * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.yzx * u_xlat4.yzx + (-u_xlat16_5.xyz);
    u_xlat6.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat31 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat7.xyz = vec3(u_xlat31) * in_NORMAL0.zxy;
    u_xlat31 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * in_TANGENT0.yzx;
    u_xlat9.xyz = u_xlat7.xyz * u_xlat8.xyz;
    u_xlat7.xyz = u_xlat7.zxy * u_xlat8.yzx + (-u_xlat9.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-in_POSITION0.xyz);
    u_xlat9.x = dot(in_TANGENT0.xyz, (-u_xlat8.xyz));
    u_xlat9.y = dot(u_xlat7.xyz, (-u_xlat8.xyz));
    u_xlat9.z = dot(in_NORMAL0.xyz, (-u_xlat8.xyz));
    u_xlat31 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    vs_TEXCOORD5.xyz = vec3(u_xlat31) * u_xlat9.xyz;
    u_xlat7.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb31 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb31){
        u_xlat8.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat31 = sqrt(u_xlat31);
        u_xlat31 = u_xlat31 + (-_FogStartDistance);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat27.xy = vec2(u_xlat31) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat27.xy = u_xlat27.xy * (-u_xlat27.xy);
        u_xlat31 = u_xlat27.x * _FogTune;
        u_xlat31 = u_xlat31 * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat31 = (-u_xlat31) + 1.0;
        u_xlat31 = u_xlat31 * _FogEffectLimit;
        u_xlat32 = _FogEffectStart * _FogTune;
        u_xlat31 = max(u_xlat31, u_xlat32);
        u_xlat5.w = min(u_xlat31, _FogEffectLimit);
        u_xlat31 = u_xlat27.y * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat21);
        u_xlat11.x = u_xlat1.y * _FogEffectLimit;
        u_xlat21 = _FogEffectStart * _FogTune;
        u_xlat11.x = max(u_xlat21, u_xlat11.x);
        u_xlat5.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat1.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    u_xlat10 = u_xlat10 * in_POSITION0.y;
    u_xlat0.x = u_xlat0.x * in_POSITION0.x + u_xlat10;
    u_xlat0.x = u_xlat20 * in_POSITION0.z + u_xlat0.x;
    u_xlat0.x = u_xlat30 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.z;
    u_xlat0.y = u_xlat6.x;
    u_xlat0.z = u_xlat3.x;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat4.x;
    u_xlat0.y = u_xlat6.y;
    u_xlat0.z = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.x = u_xlat4.y;
    u_xlat3.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.xy = u_xlat7.xy;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD5.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat14;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat20 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat18>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat18>=u_xlat2.x;
#endif
    u_xlat8 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat8) + 2.0;
    u_xlat8 = u_xlat14 * u_xlat8;
    u_xlat14 = u_xlat8 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat14 : u_xlat8;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat8 = u_xlat19 * -1.44269502;
    u_xlat2.y = exp2(u_xlat8);
    u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
    u_xlat8 = u_xlat2.y / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3.x = (u_xlatb19) ? u_xlat8 : 1.0;
    u_xlat19 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat18 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat19 = (-u_xlat18) + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.w = u_xlat19 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.x = u_xlat1.z;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat5.zxy;
    u_xlat16_3.xyz = u_xlat5.yzx * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat5.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat5.x = u_xlat1.y;
    u_xlat1.z = u_xlat5.y;
    u_xlat1.y = u_xlat4.y;
    u_xlat5.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat18 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat18;
    u_xlat18 = u_xlat18 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.x + u_xlat18;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.z + u_xlat18;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.w + u_xlat18;
    u_xlat18 = (-u_xlat18) + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat18 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * in_NORMAL0.zxy;
    u_xlat18 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_TANGENT0.yzx;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat1.y = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat1.x = dot(in_TANGENT0.xyz, (-u_xlat2.xyz));
    u_xlat1.z = dot(in_NORMAL0.xyz, (-u_xlat2.xyz));
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD5.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD7.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.x = vs_TEXCOORD5.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat14;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat20 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat18>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat18>=u_xlat2.x;
#endif
    u_xlat8 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat8) + 2.0;
    u_xlat8 = u_xlat14 * u_xlat8;
    u_xlat14 = u_xlat8 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat14 : u_xlat8;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat8 = u_xlat19 * -1.44269502;
    u_xlat2.y = exp2(u_xlat8);
    u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
    u_xlat8 = u_xlat2.y / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3.x = (u_xlatb19) ? u_xlat8 : 1.0;
    u_xlat19 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat18 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat19 = (-u_xlat18) + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.w = u_xlat19 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.x = u_xlat1.z;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat5.zxy;
    u_xlat16_3.xyz = u_xlat5.yzx * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat5.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat5.x = u_xlat1.y;
    u_xlat1.z = u_xlat5.y;
    u_xlat1.y = u_xlat4.y;
    u_xlat5.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat18 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat18;
    u_xlat18 = u_xlat18 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.x + u_xlat18;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.z + u_xlat18;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.w + u_xlat18;
    u_xlat18 = (-u_xlat18) + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat18 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * in_NORMAL0.zxy;
    u_xlat18 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_TANGENT0.yzx;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat1.y = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat1.x = dot(in_TANGENT0.xyz, (-u_xlat2.xyz));
    u_xlat1.z = dot(in_NORMAL0.xyz, (-u_xlat2.xyz));
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD5.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD7.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.x = vs_TEXCOORD5.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat14;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat20 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat18>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat18>=u_xlat2.x;
#endif
    u_xlat8 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat8) + 2.0;
    u_xlat8 = u_xlat14 * u_xlat8;
    u_xlat14 = u_xlat8 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat14 : u_xlat8;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat8 = u_xlat19 * -1.44269502;
    u_xlat2.y = exp2(u_xlat8);
    u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
    u_xlat8 = u_xlat2.y / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3.x = (u_xlatb19) ? u_xlat8 : 1.0;
    u_xlat19 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat18 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat19 = (-u_xlat18) + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.w = u_xlat19 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.x = u_xlat1.z;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat5.zxy;
    u_xlat16_3.xyz = u_xlat5.yzx * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat5.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat5.x = u_xlat1.y;
    u_xlat1.z = u_xlat5.y;
    u_xlat1.y = u_xlat4.y;
    u_xlat5.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat18 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat18;
    u_xlat18 = u_xlat18 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.x + u_xlat18;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.z + u_xlat18;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.w + u_xlat18;
    u_xlat18 = (-u_xlat18) + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat18 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * in_NORMAL0.zxy;
    u_xlat18 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_TANGENT0.yzx;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat1.y = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat1.x = dot(in_TANGENT0.xyz, (-u_xlat2.xyz));
    u_xlat1.z = dot(in_NORMAL0.xyz, (-u_xlat2.xyz));
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD5.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD7.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.x = vs_TEXCOORD5.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat16;
float u_xlat21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta3.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor3.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat16 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat2.x * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3 = (u_xlatb2) ? u_xlat23 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat2.x) + 2.0;
    u_xlat16_10 = u_xlat2.x * u_xlat16_10;
    u_xlat2.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat23 = (-u_xlat2.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat23);
    u_xlat3.w = u_xlat22 * u_xlat23;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat1.x) + 2.0;
    u_xlat16_5.x = u_xlat1.x * u_xlat16_5.x;
    u_xlat1.xyz = u_xlat16_5.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta2.w;
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor2.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase2.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat16 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_5.x = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5.x = u_xlat21 * u_xlat16_5.x;
    u_xlat21 = min(u_xlat16_5.x, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat3;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = u_xlat1.z;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat1.xyz * u_xlat6.zxy;
    u_xlat16_5.xyz = u_xlat6.yzx * u_xlat1.yzx + (-u_xlat16_5.xyz);
    u_xlat4.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat6.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat6.x = u_xlat1.y;
    u_xlat1.z = u_xlat6.y;
    u_xlat1.y = u_xlat4.y;
    u_xlat6.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat6.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat21 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat21;
    u_xlat21 = u_xlat21 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.x + u_xlat21;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.z + u_xlat21;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.w + u_xlat21;
    u_xlat21 = (-u_xlat21) + (-_ProjectionParams.y);
    u_xlat21 = u_xlat21 + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat21 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat1.y = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat1.x = dot(in_TANGENT0.xyz, (-u_xlat2.xyz));
    u_xlat1.z = dot(in_NORMAL0.xyz, (-u_xlat2.xyz));
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD7.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.x = vs_TEXCOORD5.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat16;
float u_xlat21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta3.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor3.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat16 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat2.x * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3 = (u_xlatb2) ? u_xlat23 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat2.x) + 2.0;
    u_xlat16_10 = u_xlat2.x * u_xlat16_10;
    u_xlat2.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat23 = (-u_xlat2.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat23);
    u_xlat3.w = u_xlat22 * u_xlat23;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat1.x) + 2.0;
    u_xlat16_5.x = u_xlat1.x * u_xlat16_5.x;
    u_xlat1.xyz = u_xlat16_5.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta2.w;
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor2.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase2.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat16 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_5.x = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5.x = u_xlat21 * u_xlat16_5.x;
    u_xlat21 = min(u_xlat16_5.x, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat3;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = u_xlat1.z;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat1.xyz * u_xlat6.zxy;
    u_xlat16_5.xyz = u_xlat6.yzx * u_xlat1.yzx + (-u_xlat16_5.xyz);
    u_xlat4.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat6.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat6.x = u_xlat1.y;
    u_xlat1.z = u_xlat6.y;
    u_xlat1.y = u_xlat4.y;
    u_xlat6.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat6.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat21 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat21;
    u_xlat21 = u_xlat21 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.x + u_xlat21;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.z + u_xlat21;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.w + u_xlat21;
    u_xlat21 = (-u_xlat21) + (-_ProjectionParams.y);
    u_xlat21 = u_xlat21 + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat21 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat1.y = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat1.x = dot(in_TANGENT0.xyz, (-u_xlat2.xyz));
    u_xlat1.z = dot(in_NORMAL0.xyz, (-u_xlat2.xyz));
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD7.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.x = vs_TEXCOORD5.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat16;
float u_xlat21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta3.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor3.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat16 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat2.x * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3 = (u_xlatb2) ? u_xlat23 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat2.x) + 2.0;
    u_xlat16_10 = u_xlat2.x * u_xlat16_10;
    u_xlat2.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat23 = (-u_xlat2.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat23);
    u_xlat3.w = u_xlat22 * u_xlat23;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat1.x) + 2.0;
    u_xlat16_5.x = u_xlat1.x * u_xlat16_5.x;
    u_xlat1.xyz = u_xlat16_5.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta2.w;
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor2.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase2.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat16 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_5.x = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5.x = u_xlat21 * u_xlat16_5.x;
    u_xlat21 = min(u_xlat16_5.x, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat3;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = u_xlat1.z;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat1.xyz * u_xlat6.zxy;
    u_xlat16_5.xyz = u_xlat6.yzx * u_xlat1.yzx + (-u_xlat16_5.xyz);
    u_xlat4.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat6.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat6.x = u_xlat1.y;
    u_xlat1.z = u_xlat6.y;
    u_xlat1.y = u_xlat4.y;
    u_xlat6.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat6.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat21 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat21;
    u_xlat21 = u_xlat21 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.x + u_xlat21;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.z + u_xlat21;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.w + u_xlat21;
    u_xlat21 = (-u_xlat21) + (-_ProjectionParams.y);
    u_xlat21 = u_xlat21 + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat21 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat1.y = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat1.x = dot(in_TANGENT0.xyz, (-u_xlat2.xyz));
    u_xlat1.z = dot(in_NORMAL0.xyz, (-u_xlat2.xyz));
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD7.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.x = vs_TEXCOORD5.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 _BumpMap_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat21;
vec2 u_xlat27;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0.x;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat10;
    u_xlat20 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat20;
    u_xlat30 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat30;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.zxy * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.yzx * u_xlat4.yzx + (-u_xlat16_5.xyz);
    u_xlat6.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat31 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat7.xyz = vec3(u_xlat31) * in_NORMAL0.zxy;
    u_xlat31 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * in_TANGENT0.yzx;
    u_xlat9.xyz = u_xlat7.xyz * u_xlat8.xyz;
    u_xlat7.xyz = u_xlat7.zxy * u_xlat8.yzx + (-u_xlat9.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-in_POSITION0.xyz);
    u_xlat9.x = dot(in_TANGENT0.xyz, (-u_xlat8.xyz));
    u_xlat9.y = dot(u_xlat7.xyz, (-u_xlat8.xyz));
    u_xlat9.z = dot(in_NORMAL0.xyz, (-u_xlat8.xyz));
    u_xlat31 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    vs_TEXCOORD5.xyz = vec3(u_xlat31) * u_xlat9.xyz;
    u_xlat7.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb31 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb31){
        u_xlat8.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat31 = sqrt(u_xlat31);
        u_xlat31 = u_xlat31 + (-_FogStartDistance);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat27.xy = vec2(u_xlat31) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat27.xy = u_xlat27.xy * (-u_xlat27.xy);
        u_xlat31 = u_xlat27.x * _FogTune;
        u_xlat31 = u_xlat31 * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat31 = (-u_xlat31) + 1.0;
        u_xlat31 = u_xlat31 * _FogEffectLimit;
        u_xlat32 = _FogEffectStart * _FogTune;
        u_xlat31 = max(u_xlat31, u_xlat32);
        u_xlat5.w = min(u_xlat31, _FogEffectLimit);
        u_xlat31 = u_xlat27.y * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat21);
        u_xlat11.x = u_xlat1.y * _FogEffectLimit;
        u_xlat21 = _FogEffectStart * _FogTune;
        u_xlat11.x = max(u_xlat21, u_xlat11.x);
        u_xlat5.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat1.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    u_xlat10 = u_xlat10 * in_POSITION0.y;
    u_xlat0.x = u_xlat0.x * in_POSITION0.x + u_xlat10;
    u_xlat0.x = u_xlat20 * in_POSITION0.z + u_xlat0.x;
    u_xlat0.x = u_xlat30 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.z;
    u_xlat0.y = u_xlat6.x;
    u_xlat0.z = u_xlat3.x;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat4.x;
    u_xlat0.y = u_xlat6.y;
    u_xlat0.z = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.x = u_xlat4.y;
    u_xlat3.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.xy = u_xlat7.xy;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat0.w = vs_TEXCOORD5.w;
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
uniform 	vec4 _BumpMap_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat21;
vec2 u_xlat27;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0.x;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat10;
    u_xlat20 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat20;
    u_xlat30 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat30;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.zxy * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.yzx * u_xlat4.yzx + (-u_xlat16_5.xyz);
    u_xlat6.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat31 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat7.xyz = vec3(u_xlat31) * in_NORMAL0.zxy;
    u_xlat31 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * in_TANGENT0.yzx;
    u_xlat9.xyz = u_xlat7.xyz * u_xlat8.xyz;
    u_xlat7.xyz = u_xlat7.zxy * u_xlat8.yzx + (-u_xlat9.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-in_POSITION0.xyz);
    u_xlat9.x = dot(in_TANGENT0.xyz, (-u_xlat8.xyz));
    u_xlat9.y = dot(u_xlat7.xyz, (-u_xlat8.xyz));
    u_xlat9.z = dot(in_NORMAL0.xyz, (-u_xlat8.xyz));
    u_xlat31 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    vs_TEXCOORD5.xyz = vec3(u_xlat31) * u_xlat9.xyz;
    u_xlat7.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb31 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb31){
        u_xlat8.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat31 = sqrt(u_xlat31);
        u_xlat31 = u_xlat31 + (-_FogStartDistance);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat27.xy = vec2(u_xlat31) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat27.xy = u_xlat27.xy * (-u_xlat27.xy);
        u_xlat31 = u_xlat27.x * _FogTune;
        u_xlat31 = u_xlat31 * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat31 = (-u_xlat31) + 1.0;
        u_xlat31 = u_xlat31 * _FogEffectLimit;
        u_xlat32 = _FogEffectStart * _FogTune;
        u_xlat31 = max(u_xlat31, u_xlat32);
        u_xlat5.w = min(u_xlat31, _FogEffectLimit);
        u_xlat31 = u_xlat27.y * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat21);
        u_xlat11.x = u_xlat1.y * _FogEffectLimit;
        u_xlat21 = _FogEffectStart * _FogTune;
        u_xlat11.x = max(u_xlat21, u_xlat11.x);
        u_xlat5.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat1.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    u_xlat10 = u_xlat10 * in_POSITION0.y;
    u_xlat0.x = u_xlat0.x * in_POSITION0.x + u_xlat10;
    u_xlat0.x = u_xlat20 * in_POSITION0.z + u_xlat0.x;
    u_xlat0.x = u_xlat30 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.z;
    u_xlat0.y = u_xlat6.x;
    u_xlat0.z = u_xlat3.x;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat4.x;
    u_xlat0.y = u_xlat6.y;
    u_xlat0.z = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.x = u_xlat4.y;
    u_xlat3.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.xy = u_xlat7.xy;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat0.w = vs_TEXCOORD5.w;
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
uniform 	vec4 _BumpMap_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat21;
vec2 u_xlat27;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0.x;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat10;
    u_xlat20 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat20;
    u_xlat30 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat30;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.zxy * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.yzx * u_xlat4.yzx + (-u_xlat16_5.xyz);
    u_xlat6.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat31 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat7.xyz = vec3(u_xlat31) * in_NORMAL0.zxy;
    u_xlat31 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * in_TANGENT0.yzx;
    u_xlat9.xyz = u_xlat7.xyz * u_xlat8.xyz;
    u_xlat7.xyz = u_xlat7.zxy * u_xlat8.yzx + (-u_xlat9.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-in_POSITION0.xyz);
    u_xlat9.x = dot(in_TANGENT0.xyz, (-u_xlat8.xyz));
    u_xlat9.y = dot(u_xlat7.xyz, (-u_xlat8.xyz));
    u_xlat9.z = dot(in_NORMAL0.xyz, (-u_xlat8.xyz));
    u_xlat31 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    vs_TEXCOORD5.xyz = vec3(u_xlat31) * u_xlat9.xyz;
    u_xlat7.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb31 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb31){
        u_xlat8.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat31 = sqrt(u_xlat31);
        u_xlat31 = u_xlat31 + (-_FogStartDistance);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat27.xy = vec2(u_xlat31) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat27.xy = u_xlat27.xy * (-u_xlat27.xy);
        u_xlat31 = u_xlat27.x * _FogTune;
        u_xlat31 = u_xlat31 * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat31 = (-u_xlat31) + 1.0;
        u_xlat31 = u_xlat31 * _FogEffectLimit;
        u_xlat32 = _FogEffectStart * _FogTune;
        u_xlat31 = max(u_xlat31, u_xlat32);
        u_xlat5.w = min(u_xlat31, _FogEffectLimit);
        u_xlat31 = u_xlat27.y * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat21);
        u_xlat11.x = u_xlat1.y * _FogEffectLimit;
        u_xlat21 = _FogEffectStart * _FogTune;
        u_xlat11.x = max(u_xlat21, u_xlat11.x);
        u_xlat5.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat1.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    u_xlat10 = u_xlat10 * in_POSITION0.y;
    u_xlat0.x = u_xlat0.x * in_POSITION0.x + u_xlat10;
    u_xlat0.x = u_xlat20 * in_POSITION0.z + u_xlat0.x;
    u_xlat0.x = u_xlat30 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.z;
    u_xlat0.y = u_xlat6.x;
    u_xlat0.z = u_xlat3.x;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat4.x;
    u_xlat0.y = u_xlat6.y;
    u_xlat0.z = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.x = u_xlat4.y;
    u_xlat3.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.xy = u_xlat7.xy;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat0.w = vs_TEXCOORD5.w;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
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
uniform 	vec4 _BumpMap_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat21;
vec2 u_xlat27;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0.x;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat10;
    u_xlat20 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat20;
    u_xlat30 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat30;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.zxy * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.yzx * u_xlat4.yzx + (-u_xlat16_5.xyz);
    u_xlat6.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat31 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat7.xyz = vec3(u_xlat31) * in_NORMAL0.zxy;
    u_xlat31 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * in_TANGENT0.yzx;
    u_xlat9.xyz = u_xlat7.xyz * u_xlat8.xyz;
    u_xlat7.xyz = u_xlat7.zxy * u_xlat8.yzx + (-u_xlat9.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-in_POSITION0.xyz);
    u_xlat9.x = dot(in_TANGENT0.xyz, (-u_xlat8.xyz));
    u_xlat9.y = dot(u_xlat7.xyz, (-u_xlat8.xyz));
    u_xlat9.z = dot(in_NORMAL0.xyz, (-u_xlat8.xyz));
    u_xlat31 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    vs_TEXCOORD5.xyz = vec3(u_xlat31) * u_xlat9.xyz;
    u_xlat7.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb31 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb31){
        u_xlat8.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat31 = sqrt(u_xlat31);
        u_xlat31 = u_xlat31 + (-_FogStartDistance);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat27.xy = vec2(u_xlat31) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat27.xy = u_xlat27.xy * (-u_xlat27.xy);
        u_xlat31 = u_xlat27.x * _FogTune;
        u_xlat31 = u_xlat31 * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat31 = (-u_xlat31) + 1.0;
        u_xlat31 = u_xlat31 * _FogEffectLimit;
        u_xlat32 = _FogEffectStart * _FogTune;
        u_xlat31 = max(u_xlat31, u_xlat32);
        u_xlat5.w = min(u_xlat31, _FogEffectLimit);
        u_xlat31 = u_xlat27.y * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat21);
        u_xlat11.x = u_xlat1.y * _FogEffectLimit;
        u_xlat21 = _FogEffectStart * _FogTune;
        u_xlat11.x = max(u_xlat21, u_xlat11.x);
        u_xlat5.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat1.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    u_xlat10 = u_xlat10 * in_POSITION0.y;
    u_xlat0.x = u_xlat0.x * in_POSITION0.x + u_xlat10;
    u_xlat0.x = u_xlat20 * in_POSITION0.z + u_xlat0.x;
    u_xlat0.x = u_xlat30 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.z;
    u_xlat0.y = u_xlat6.x;
    u_xlat0.z = u_xlat3.x;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat4.x;
    u_xlat0.y = u_xlat6.y;
    u_xlat0.z = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.x = u_xlat4.y;
    u_xlat3.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.xy = u_xlat7.xy;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat0.w = vs_TEXCOORD5.w;
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
Keywords { "LUMINANCE" "FOG_LERP" }
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
uniform 	vec4 _BumpMap_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat21;
vec2 u_xlat27;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0.x;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat10;
    u_xlat20 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat20;
    u_xlat30 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat30;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.zxy * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.yzx * u_xlat4.yzx + (-u_xlat16_5.xyz);
    u_xlat6.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat31 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat7.xyz = vec3(u_xlat31) * in_NORMAL0.zxy;
    u_xlat31 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * in_TANGENT0.yzx;
    u_xlat9.xyz = u_xlat7.xyz * u_xlat8.xyz;
    u_xlat7.xyz = u_xlat7.zxy * u_xlat8.yzx + (-u_xlat9.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-in_POSITION0.xyz);
    u_xlat9.x = dot(in_TANGENT0.xyz, (-u_xlat8.xyz));
    u_xlat9.y = dot(u_xlat7.xyz, (-u_xlat8.xyz));
    u_xlat9.z = dot(in_NORMAL0.xyz, (-u_xlat8.xyz));
    u_xlat31 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    vs_TEXCOORD5.xyz = vec3(u_xlat31) * u_xlat9.xyz;
    u_xlat7.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb31 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb31){
        u_xlat8.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat31 = sqrt(u_xlat31);
        u_xlat31 = u_xlat31 + (-_FogStartDistance);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat27.xy = vec2(u_xlat31) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat27.xy = u_xlat27.xy * (-u_xlat27.xy);
        u_xlat31 = u_xlat27.x * _FogTune;
        u_xlat31 = u_xlat31 * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat31 = (-u_xlat31) + 1.0;
        u_xlat31 = u_xlat31 * _FogEffectLimit;
        u_xlat32 = _FogEffectStart * _FogTune;
        u_xlat31 = max(u_xlat31, u_xlat32);
        u_xlat5.w = min(u_xlat31, _FogEffectLimit);
        u_xlat31 = u_xlat27.y * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat21);
        u_xlat11.x = u_xlat1.y * _FogEffectLimit;
        u_xlat21 = _FogEffectStart * _FogTune;
        u_xlat11.x = max(u_xlat21, u_xlat11.x);
        u_xlat5.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat1.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    u_xlat10 = u_xlat10 * in_POSITION0.y;
    u_xlat0.x = u_xlat0.x * in_POSITION0.x + u_xlat10;
    u_xlat0.x = u_xlat20 * in_POSITION0.z + u_xlat0.x;
    u_xlat0.x = u_xlat30 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.z;
    u_xlat0.y = u_xlat6.x;
    u_xlat0.z = u_xlat3.x;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat4.x;
    u_xlat0.y = u_xlat6.y;
    u_xlat0.z = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.x = u_xlat4.y;
    u_xlat3.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.xy = u_xlat7.xy;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat0.w = vs_TEXCOORD5.w;
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
Keywords { "LUMINANCE" "FOG_LERP" }
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
uniform 	vec4 _BumpMap_ST;
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat21;
vec2 u_xlat27;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0.x;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat10;
    u_xlat20 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat20;
    u_xlat20 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat20;
    u_xlat30 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat30;
    u_xlat30 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat30;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.zxy * u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat3.yzx * u_xlat4.yzx + (-u_xlat16_5.xyz);
    u_xlat6.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat31 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat7.xyz = vec3(u_xlat31) * in_NORMAL0.zxy;
    u_xlat31 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * in_TANGENT0.yzx;
    u_xlat9.xyz = u_xlat7.xyz * u_xlat8.xyz;
    u_xlat7.xyz = u_xlat7.zxy * u_xlat8.yzx + (-u_xlat9.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-in_POSITION0.xyz);
    u_xlat9.x = dot(in_TANGENT0.xyz, (-u_xlat8.xyz));
    u_xlat9.y = dot(u_xlat7.xyz, (-u_xlat8.xyz));
    u_xlat9.z = dot(in_NORMAL0.xyz, (-u_xlat8.xyz));
    u_xlat31 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    vs_TEXCOORD5.xyz = vec3(u_xlat31) * u_xlat9.xyz;
    u_xlat7.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb31 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb31){
        u_xlat8.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat31 = sqrt(u_xlat31);
        u_xlat31 = u_xlat31 + (-_FogStartDistance);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat27.xy = vec2(u_xlat31) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat27.xy = u_xlat27.xy * (-u_xlat27.xy);
        u_xlat31 = u_xlat27.x * _FogTune;
        u_xlat31 = u_xlat31 * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat31 = (-u_xlat31) + 1.0;
        u_xlat31 = u_xlat31 * _FogEffectLimit;
        u_xlat32 = _FogEffectStart * _FogTune;
        u_xlat31 = max(u_xlat31, u_xlat32);
        u_xlat5.w = min(u_xlat31, _FogEffectLimit);
        u_xlat31 = u_xlat27.y * 1.44269502;
        u_xlat31 = exp2(u_xlat31);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat21);
        u_xlat11.x = u_xlat1.y * _FogEffectLimit;
        u_xlat21 = _FogEffectStart * _FogTune;
        u_xlat11.x = max(u_xlat21, u_xlat11.x);
        u_xlat5.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat1.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    u_xlat10 = u_xlat10 * in_POSITION0.y;
    u_xlat0.x = u_xlat0.x * in_POSITION0.x + u_xlat10;
    u_xlat0.x = u_xlat20 * in_POSITION0.z + u_xlat0.x;
    u_xlat0.x = u_xlat30 * in_POSITION0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.z;
    u_xlat0.y = u_xlat6.x;
    u_xlat0.z = u_xlat3.x;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat4.x;
    u_xlat0.y = u_xlat6.y;
    u_xlat0.z = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.x = u_xlat4.y;
    u_xlat3.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.xy = u_xlat7.xy;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat0.w = vs_TEXCOORD5.w;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat14;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat20 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat18>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat18>=u_xlat2.x;
#endif
    u_xlat8 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat8) + 2.0;
    u_xlat8 = u_xlat14 * u_xlat8;
    u_xlat14 = u_xlat8 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat14 : u_xlat8;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat8 = u_xlat19 * -1.44269502;
    u_xlat2.y = exp2(u_xlat8);
    u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
    u_xlat8 = u_xlat2.y / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3.x = (u_xlatb19) ? u_xlat8 : 1.0;
    u_xlat19 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat18 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat19 = (-u_xlat18) + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.w = u_xlat19 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.x = u_xlat1.z;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat5.zxy;
    u_xlat16_3.xyz = u_xlat5.yzx * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat5.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat5.x = u_xlat1.y;
    u_xlat1.z = u_xlat5.y;
    u_xlat1.y = u_xlat4.y;
    u_xlat5.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat18 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat18;
    u_xlat18 = u_xlat18 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.x + u_xlat18;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.z + u_xlat18;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.w + u_xlat18;
    u_xlat18 = (-u_xlat18) + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat18 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * in_NORMAL0.zxy;
    u_xlat18 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_TANGENT0.yzx;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat1.y = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat1.x = dot(in_TANGENT0.xyz, (-u_xlat2.xyz));
    u_xlat1.z = dot(in_NORMAL0.xyz, (-u_xlat2.xyz));
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD5.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD7.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat0.w = vs_TEXCOORD5.w;
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
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat14;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat20 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat18>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat18>=u_xlat2.x;
#endif
    u_xlat8 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat8) + 2.0;
    u_xlat8 = u_xlat14 * u_xlat8;
    u_xlat14 = u_xlat8 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat14 : u_xlat8;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat8 = u_xlat19 * -1.44269502;
    u_xlat2.y = exp2(u_xlat8);
    u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
    u_xlat8 = u_xlat2.y / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3.x = (u_xlatb19) ? u_xlat8 : 1.0;
    u_xlat19 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat18 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat19 = (-u_xlat18) + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.w = u_xlat19 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.x = u_xlat1.z;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat5.zxy;
    u_xlat16_3.xyz = u_xlat5.yzx * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat5.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat5.x = u_xlat1.y;
    u_xlat1.z = u_xlat5.y;
    u_xlat1.y = u_xlat4.y;
    u_xlat5.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat18 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat18;
    u_xlat18 = u_xlat18 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.x + u_xlat18;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.z + u_xlat18;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.w + u_xlat18;
    u_xlat18 = (-u_xlat18) + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat18 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * in_NORMAL0.zxy;
    u_xlat18 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_TANGENT0.yzx;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat1.y = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat1.x = dot(in_TANGENT0.xyz, (-u_xlat2.xyz));
    u_xlat1.z = dot(in_NORMAL0.xyz, (-u_xlat2.xyz));
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD5.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD7.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat0.w = vs_TEXCOORD5.w;
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
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat14;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
float u_xlat20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat20 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat18>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat18>=u_xlat2.x;
#endif
    u_xlat8 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat8) + 2.0;
    u_xlat8 = u_xlat14 * u_xlat8;
    u_xlat14 = u_xlat8 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat14 : u_xlat8;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat8 = u_xlat19 * -1.44269502;
    u_xlat2.y = exp2(u_xlat8);
    u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
    u_xlat8 = u_xlat2.y / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3.x = (u_xlatb19) ? u_xlat8 : 1.0;
    u_xlat19 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat18 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat19 = (-u_xlat18) + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.w = u_xlat19 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.x = u_xlat1.z;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat5.zxy;
    u_xlat16_3.xyz = u_xlat5.yzx * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat5.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat5.x = u_xlat1.y;
    u_xlat1.z = u_xlat5.y;
    u_xlat1.y = u_xlat4.y;
    u_xlat5.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat18 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat18;
    u_xlat18 = u_xlat18 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.x + u_xlat18;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.z + u_xlat18;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat18 = u_xlat1.x * in_POSITION0.w + u_xlat18;
    u_xlat18 = (-u_xlat18) + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat18 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * in_NORMAL0.zxy;
    u_xlat18 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_TANGENT0.yzx;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat1.y = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat1.x = dot(in_TANGENT0.xyz, (-u_xlat2.xyz));
    u_xlat1.z = dot(in_NORMAL0.xyz, (-u_xlat2.xyz));
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD5.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD7.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat0.w = vs_TEXCOORD5.w;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat16;
float u_xlat21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta3.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor3.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat16 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat2.x * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3 = (u_xlatb2) ? u_xlat23 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat2.x) + 2.0;
    u_xlat16_10 = u_xlat2.x * u_xlat16_10;
    u_xlat2.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat23 = (-u_xlat2.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat23);
    u_xlat3.w = u_xlat22 * u_xlat23;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat1.x) + 2.0;
    u_xlat16_5.x = u_xlat1.x * u_xlat16_5.x;
    u_xlat1.xyz = u_xlat16_5.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta2.w;
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor2.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase2.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat16 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_5.x = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5.x = u_xlat21 * u_xlat16_5.x;
    u_xlat21 = min(u_xlat16_5.x, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat3;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = u_xlat1.z;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat1.xyz * u_xlat6.zxy;
    u_xlat16_5.xyz = u_xlat6.yzx * u_xlat1.yzx + (-u_xlat16_5.xyz);
    u_xlat4.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat6.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat6.x = u_xlat1.y;
    u_xlat1.z = u_xlat6.y;
    u_xlat1.y = u_xlat4.y;
    u_xlat6.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat6.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat21 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat21;
    u_xlat21 = u_xlat21 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.x + u_xlat21;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.z + u_xlat21;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.w + u_xlat21;
    u_xlat21 = (-u_xlat21) + (-_ProjectionParams.y);
    u_xlat21 = u_xlat21 + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat21 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat1.y = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat1.x = dot(in_TANGENT0.xyz, (-u_xlat2.xyz));
    u_xlat1.z = dot(in_NORMAL0.xyz, (-u_xlat2.xyz));
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD7.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat0.w = vs_TEXCOORD5.w;
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
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat16;
float u_xlat21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta3.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor3.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat16 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat2.x * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3 = (u_xlatb2) ? u_xlat23 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat2.x) + 2.0;
    u_xlat16_10 = u_xlat2.x * u_xlat16_10;
    u_xlat2.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat23 = (-u_xlat2.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat23);
    u_xlat3.w = u_xlat22 * u_xlat23;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat1.x) + 2.0;
    u_xlat16_5.x = u_xlat1.x * u_xlat16_5.x;
    u_xlat1.xyz = u_xlat16_5.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta2.w;
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor2.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase2.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat16 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_5.x = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5.x = u_xlat21 * u_xlat16_5.x;
    u_xlat21 = min(u_xlat16_5.x, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat3;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = u_xlat1.z;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat1.xyz * u_xlat6.zxy;
    u_xlat16_5.xyz = u_xlat6.yzx * u_xlat1.yzx + (-u_xlat16_5.xyz);
    u_xlat4.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat6.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat6.x = u_xlat1.y;
    u_xlat1.z = u_xlat6.y;
    u_xlat1.y = u_xlat4.y;
    u_xlat6.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat6.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat21 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat21;
    u_xlat21 = u_xlat21 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.x + u_xlat21;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.z + u_xlat21;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.w + u_xlat21;
    u_xlat21 = (-u_xlat21) + (-_ProjectionParams.y);
    u_xlat21 = u_xlat21 + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat21 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat1.y = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat1.x = dot(in_TANGENT0.xyz, (-u_xlat2.xyz));
    u_xlat1.z = dot(in_NORMAL0.xyz, (-u_xlat2.xyz));
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD7.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat0.w = vs_TEXCOORD5.w;
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
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat16;
float u_xlat21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta3.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor3.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat16 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat2.x * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3 = (u_xlatb2) ? u_xlat23 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat2.x) + 2.0;
    u_xlat16_10 = u_xlat2.x * u_xlat16_10;
    u_xlat2.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat23 = (-u_xlat2.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat23);
    u_xlat3.w = u_xlat22 * u_xlat23;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat1.x) + 2.0;
    u_xlat16_5.x = u_xlat1.x * u_xlat16_5.x;
    u_xlat1.xyz = u_xlat16_5.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta2.w;
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor2.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase2.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat16 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_5.x = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5.x = u_xlat21 * u_xlat16_5.x;
    u_xlat21 = min(u_xlat16_5.x, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat3;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = u_xlat1.z;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat1.xyz * u_xlat6.zxy;
    u_xlat16_5.xyz = u_xlat6.yzx * u_xlat1.yzx + (-u_xlat16_5.xyz);
    u_xlat4.xyz = u_xlat16_5.xyz * in_TANGENT0.www;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat6.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat6.x = u_xlat1.y;
    u_xlat1.z = u_xlat6.y;
    u_xlat1.y = u_xlat4.y;
    u_xlat6.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat6.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat21 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat21;
    u_xlat21 = u_xlat21 * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.x + u_xlat21;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.z + u_xlat21;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat1.x;
    u_xlat21 = u_xlat1.x * in_POSITION0.w + u_xlat21;
    u_xlat21 = (-u_xlat21) + (-_ProjectionParams.y);
    u_xlat21 = u_xlat21 + (-_FadeOffset);
    vs_TEXCOORD5.w = u_xlat21 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.w = min(max(vs_TEXCOORD5.w, 0.0), 1.0);
#else
    vs_TEXCOORD5.w = clamp(vs_TEXCOORD5.w, 0.0, 1.0);
#endif
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat1.y = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat1.x = dot(in_TANGENT0.xyz, (-u_xlat2.xyz));
    u_xlat1.z = dot(in_NORMAL0.xyz, (-u_xlat2.xyz));
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD7.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_16 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_16) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_16 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_16) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat2.xy * u_xlat10.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat10.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_15 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_15) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity);
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat15 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD9.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat15 = (-u_xlat15) + 1.00100005;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _fresnelIndensity;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = _fresnelScaleA * u_xlat15 + _fresnelBaseA;
    u_xlat2.xyz = vec3(u_xlat15) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _EnvColor.xyz + u_xlat2.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat0.w = vs_TEXCOORD5.w;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
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
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
}
}
 Pass {
  Name "CONSTANT_REPLACE"
  Tags { "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
  GpuProgramID 71689
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
Fallback "VertexLit"
}