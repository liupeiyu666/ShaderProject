//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/SceneMatcapNormal" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Base (RGB)", 2D) = "white" { }
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
[Toggle(MATCAP_ACCURATE)] _MatCapAccurate ("Accurate Calculation", Float) = 0
_MetalRef ("MetalRef", Range(0, 1)) = 0
_FogTune ("Fog Tune", Range(0, 1)) = 1
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 64922
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCORRD4;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat12;
float u_xlat18;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat18 = dot(in_TANGENT0, in_TANGENT0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3 = vec4(u_xlat18) * in_TANGENT0;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat2.zxy * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.yzx + (-u_xlat5.xyz);
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD2.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.z = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.z = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, (-u_xlat0.xyz));
    u_xlat1.y = dot(u_xlat4.xyz, (-u_xlat0.xyz));
    u_xlat1.z = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCORRD4.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
        u_xlat0.x = u_xlat0.x * _FogTune;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat0.x = u_xlat0.x * _FogEffectLimit;
        u_xlat12 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat12, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat12);
        u_xlat6.x = u_xlat0.y * _FogEffectLimit;
        u_xlat12 = _FogEffectStart * _FogTune;
        u_xlat6.x = max(u_xlat12, u_xlat6.x);
        u_xlat1.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCORRD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCORRD4.xyz, u_xlat16_1.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat16_1.xyz * (-u_xlat0.xxx) + vs_TEXCORRD4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(_MetalRef) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat16_1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _Color.xyz + vs_COLOR1.xyz;
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCORRD4;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat12;
float u_xlat18;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat18 = dot(in_TANGENT0, in_TANGENT0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3 = vec4(u_xlat18) * in_TANGENT0;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat2.zxy * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.yzx + (-u_xlat5.xyz);
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD2.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.z = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.z = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, (-u_xlat0.xyz));
    u_xlat1.y = dot(u_xlat4.xyz, (-u_xlat0.xyz));
    u_xlat1.z = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCORRD4.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
        u_xlat0.x = u_xlat0.x * _FogTune;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat0.x = u_xlat0.x * _FogEffectLimit;
        u_xlat12 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat12, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat12);
        u_xlat6.x = u_xlat0.y * _FogEffectLimit;
        u_xlat12 = _FogEffectStart * _FogTune;
        u_xlat6.x = max(u_xlat12, u_xlat6.x);
        u_xlat1.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCORRD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCORRD4.xyz, u_xlat16_1.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat16_1.xyz * (-u_xlat0.xxx) + vs_TEXCORRD4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(_MetalRef) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat16_1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _Color.xyz + vs_COLOR1.xyz;
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCORRD4;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat12;
float u_xlat18;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat18 = dot(in_TANGENT0, in_TANGENT0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3 = vec4(u_xlat18) * in_TANGENT0;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat2.zxy * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.yzx + (-u_xlat5.xyz);
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD2.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.z = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.z = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, (-u_xlat0.xyz));
    u_xlat1.y = dot(u_xlat4.xyz, (-u_xlat0.xyz));
    u_xlat1.z = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCORRD4.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
        u_xlat0.x = u_xlat0.x * _FogTune;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat0.x = u_xlat0.x * _FogEffectLimit;
        u_xlat12 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat12, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat12);
        u_xlat6.x = u_xlat0.y * _FogEffectLimit;
        u_xlat12 = _FogEffectStart * _FogTune;
        u_xlat6.x = max(u_xlat12, u_xlat6.x);
        u_xlat1.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCORRD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCORRD4.xyz, u_xlat16_1.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat16_1.xyz * (-u_xlat0.xxx) + vs_TEXCORRD4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(_MetalRef) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat16_1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _Color.xyz + vs_COLOR1.xyz;
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCORRD4;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat12;
float u_xlat18;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat18 = dot(in_TANGENT0, in_TANGENT0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3 = vec4(u_xlat18) * in_TANGENT0;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat2.zxy * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.yzx + (-u_xlat5.xyz);
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD2.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.z = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.z = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, (-u_xlat0.xyz));
    u_xlat1.y = dot(u_xlat4.xyz, (-u_xlat0.xyz));
    u_xlat1.z = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCORRD4.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
        u_xlat0.x = u_xlat0.x * _FogTune;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat0.x = u_xlat0.x * _FogEffectLimit;
        u_xlat12 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat12, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat12);
        u_xlat6.x = u_xlat0.y * _FogEffectLimit;
        u_xlat12 = _FogEffectStart * _FogTune;
        u_xlat6.x = max(u_xlat12, u_xlat6.x);
        u_xlat1.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCORRD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCORRD4.xyz, u_xlat16_1.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat16_1.xyz * (-u_xlat0.xxx) + vs_TEXCORRD4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(_MetalRef) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat16_1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _Color.xyz + vs_COLOR1.xyz;
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCORRD4;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat12;
float u_xlat18;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat18 = dot(in_TANGENT0, in_TANGENT0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3 = vec4(u_xlat18) * in_TANGENT0;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat2.zxy * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.yzx + (-u_xlat5.xyz);
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD2.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.z = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.z = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, (-u_xlat0.xyz));
    u_xlat1.y = dot(u_xlat4.xyz, (-u_xlat0.xyz));
    u_xlat1.z = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCORRD4.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
        u_xlat0.x = u_xlat0.x * _FogTune;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat0.x = u_xlat0.x * _FogEffectLimit;
        u_xlat12 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat12, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat12);
        u_xlat6.x = u_xlat0.y * _FogEffectLimit;
        u_xlat12 = _FogEffectStart * _FogTune;
        u_xlat6.x = max(u_xlat12, u_xlat6.x);
        u_xlat1.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCORRD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCORRD4.xyz, u_xlat16_1.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat16_1.xyz * (-u_xlat0.xxx) + vs_TEXCORRD4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(_MetalRef) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat16_1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _Color.xyz + vs_COLOR1.xyz;
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCORRD4;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat12;
float u_xlat18;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat18 = dot(in_TANGENT0, in_TANGENT0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3 = vec4(u_xlat18) * in_TANGENT0;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat2.zxy * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.yzx + (-u_xlat5.xyz);
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD2.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.z = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.z = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, (-u_xlat0.xyz));
    u_xlat1.y = dot(u_xlat4.xyz, (-u_xlat0.xyz));
    u_xlat1.z = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCORRD4.xyz = u_xlat0.xxx * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
        u_xlat0.x = u_xlat0.x * _FogTune;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat0.x = u_xlat0.x * _FogEffectLimit;
        u_xlat12 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat12, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat12);
        u_xlat6.x = u_xlat0.y * _FogEffectLimit;
        u_xlat12 = _FogEffectStart * _FogTune;
        u_xlat6.x = max(u_xlat12, u_xlat6.x);
        u_xlat1.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCORRD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCORRD4.xyz, u_xlat16_1.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat16_1.xyz * (-u_xlat0.xxx) + vs_TEXCORRD4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(_MetalRef) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat16_1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _Color.xyz + vs_COLOR1.xyz;
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCORRD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3 = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat6 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(in_TANGENT0, in_TANGENT0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1 = vec4(u_xlat18) * in_TANGENT0;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat4.zxy;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat1.www * u_xlat2.xyz;
    vs_TEXCOORD2.y = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.y = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(u_xlat1.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(u_xlat4.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCORRD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCORRD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCORRD4.xyz, u_xlat16_1.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat16_1.xyz * (-u_xlat0.xxx) + vs_TEXCORRD4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(_MetalRef) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat16_1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCORRD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3 = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat6 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(in_TANGENT0, in_TANGENT0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1 = vec4(u_xlat18) * in_TANGENT0;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat4.zxy;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat1.www * u_xlat2.xyz;
    vs_TEXCOORD2.y = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.y = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(u_xlat1.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(u_xlat4.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCORRD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCORRD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCORRD4.xyz, u_xlat16_1.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat16_1.xyz * (-u_xlat0.xxx) + vs_TEXCORRD4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(_MetalRef) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat16_1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCORRD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3 = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat6 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(in_TANGENT0, in_TANGENT0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1 = vec4(u_xlat18) * in_TANGENT0;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat4.zxy;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat1.www * u_xlat2.xyz;
    vs_TEXCOORD2.y = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.y = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(u_xlat1.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(u_xlat4.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCORRD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCORRD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCORRD4.xyz, u_xlat16_1.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat16_1.xyz * (-u_xlat0.xxx) + vs_TEXCORRD4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(_MetalRef) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat16_1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCORRD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
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
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat21 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat21 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat21 = (u_xlatb2) ? u_xlat22 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor3.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat22 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat14 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat9.x = u_xlat22 * -1.44269502;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat9.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_3 = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat22 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat22) + 2.0;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat22 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_3 = u_xlat22 * u_xlat16_3;
    u_xlat22 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat7.x) + 2.0;
    u_xlat16_4 = u_xlat7.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat9.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat7.xxx * u_xlat9.xyz + u_xlat1.xyz;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb2) ? u_xlat21 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat14 * -1.44269502;
    u_xlat7.z = exp2(u_xlat21);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat7.z / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_4 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat14 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(in_TANGENT0, in_TANGENT0);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1 = vec4(u_xlat21) * in_TANGENT0;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * in_NORMAL0.xyz;
    u_xlat6.xyz = u_xlat2.xyz * u_xlat5.zxy;
    u_xlat2.xyz = u_xlat5.yzx * u_xlat2.yzx + (-u_xlat6.xyz);
    u_xlat2.xyz = u_xlat1.www * u_xlat2.xyz;
    vs_TEXCOORD2.y = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.z = dot(u_xlat5.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.z = dot(u_xlat5.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.y = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(u_xlat1.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(u_xlat5.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCORRD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCORRD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCORRD4.xyz, u_xlat16_1.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat16_1.xyz * (-u_xlat0.xxx) + vs_TEXCORRD4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(_MetalRef) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat16_1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCORRD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
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
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat21 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat21 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat21 = (u_xlatb2) ? u_xlat22 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor3.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat22 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat14 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat9.x = u_xlat22 * -1.44269502;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat9.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_3 = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat22 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat22) + 2.0;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat22 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_3 = u_xlat22 * u_xlat16_3;
    u_xlat22 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat7.x) + 2.0;
    u_xlat16_4 = u_xlat7.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat9.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat7.xxx * u_xlat9.xyz + u_xlat1.xyz;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb2) ? u_xlat21 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat14 * -1.44269502;
    u_xlat7.z = exp2(u_xlat21);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat7.z / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_4 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat14 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(in_TANGENT0, in_TANGENT0);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1 = vec4(u_xlat21) * in_TANGENT0;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * in_NORMAL0.xyz;
    u_xlat6.xyz = u_xlat2.xyz * u_xlat5.zxy;
    u_xlat2.xyz = u_xlat5.yzx * u_xlat2.yzx + (-u_xlat6.xyz);
    u_xlat2.xyz = u_xlat1.www * u_xlat2.xyz;
    vs_TEXCOORD2.y = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.z = dot(u_xlat5.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.z = dot(u_xlat5.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.y = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(u_xlat1.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(u_xlat5.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCORRD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCORRD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCORRD4.xyz, u_xlat16_1.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat16_1.xyz * (-u_xlat0.xxx) + vs_TEXCORRD4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(_MetalRef) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat16_1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCORRD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
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
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat21 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat21 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat21 = (u_xlatb2) ? u_xlat22 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor3.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat22 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat14 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat9.x = u_xlat22 * -1.44269502;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat9.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_3 = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat22 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat22) + 2.0;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat22 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_3 = u_xlat22 * u_xlat16_3;
    u_xlat22 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat7.x) + 2.0;
    u_xlat16_4 = u_xlat7.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat9.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat7.xxx * u_xlat9.xyz + u_xlat1.xyz;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb2) ? u_xlat21 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat14 * -1.44269502;
    u_xlat7.z = exp2(u_xlat21);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat7.z / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_4 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat14 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(in_TANGENT0, in_TANGENT0);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1 = vec4(u_xlat21) * in_TANGENT0;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * in_NORMAL0.xyz;
    u_xlat6.xyz = u_xlat2.xyz * u_xlat5.zxy;
    u_xlat2.xyz = u_xlat5.yzx * u_xlat2.yzx + (-u_xlat6.xyz);
    u_xlat2.xyz = u_xlat1.www * u_xlat2.xyz;
    vs_TEXCOORD2.y = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.z = dot(u_xlat5.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.z = dot(u_xlat5.xyz, u_xlat0.xyz);
    vs_TEXCOORD3.y = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(u_xlat1.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(u_xlat5.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCORRD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCORRD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCORRD4.xyz, u_xlat16_1.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat16_1.xyz * (-u_xlat0.xxx) + vs_TEXCORRD4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(_MetalRef) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat16_1.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MATCAP_ACCURATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCORRD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.yzx;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat3.xyz = u_xlat16_2.xyz * in_TANGENT0.www;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat6.xyz = u_xlat4.xyz * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat6.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-in_POSITION0.xyz);
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat5.xyz));
    u_xlat6.y = dot(u_xlat4.xyz, (-u_xlat5.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat5.xyz));
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCORRD5.xyz = vec3(u_xlat21) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat4.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat4.xy = u_xlat4.xy * (-u_xlat4.xy);
        u_xlat21 = u_xlat4.x * _FogTune;
        u_xlat21 = u_xlat21 * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat21 = (-u_xlat21) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat22 = _FogEffectStart * _FogTune;
        u_xlat21 = max(u_xlat21, u_xlat22);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat21 = u_xlat4.y * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat4.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat4.xy = u_xlat4.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat4.xy = u_xlat4.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat4.y * _FogEffectLimit;
        u_xlat22 = _FogEffectStart * _FogTune;
        u_xlat21 = max(u_xlat21, u_xlat22);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.x = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat4.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat4.x = u_xlat1.z;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.z = u_xlat0.x;
    vs_TEXCOORD2.xyz = u_xlat4.xyz;
    u_xlat4.x = u_xlat1.x;
    u_xlat4.y = u_xlat3.y;
    u_xlat4.z = u_xlat0.y;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    u_xlat0.x = u_xlat1.y;
    u_xlat0.y = u_xlat3.z;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCORRD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_13 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_13) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_13 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_13) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCORRD5.xyz, u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + vs_TEXCORRD5.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xy = u_xlat2.xy * u_xlat8.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _Color.xyz + vs_COLOR1.xyz;
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MATCAP_ACCURATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCORRD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.yzx;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat3.xyz = u_xlat16_2.xyz * in_TANGENT0.www;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat6.xyz = u_xlat4.xyz * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat6.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-in_POSITION0.xyz);
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat5.xyz));
    u_xlat6.y = dot(u_xlat4.xyz, (-u_xlat5.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat5.xyz));
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCORRD5.xyz = vec3(u_xlat21) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat4.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat4.xy = u_xlat4.xy * (-u_xlat4.xy);
        u_xlat21 = u_xlat4.x * _FogTune;
        u_xlat21 = u_xlat21 * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat21 = (-u_xlat21) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat22 = _FogEffectStart * _FogTune;
        u_xlat21 = max(u_xlat21, u_xlat22);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat21 = u_xlat4.y * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat4.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat4.xy = u_xlat4.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat4.xy = u_xlat4.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat4.y * _FogEffectLimit;
        u_xlat22 = _FogEffectStart * _FogTune;
        u_xlat21 = max(u_xlat21, u_xlat22);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.x = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat4.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat4.x = u_xlat1.z;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.z = u_xlat0.x;
    vs_TEXCOORD2.xyz = u_xlat4.xyz;
    u_xlat4.x = u_xlat1.x;
    u_xlat4.y = u_xlat3.y;
    u_xlat4.z = u_xlat0.y;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    u_xlat0.x = u_xlat1.y;
    u_xlat0.y = u_xlat3.z;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCORRD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_13 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_13) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_13 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_13) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCORRD5.xyz, u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + vs_TEXCORRD5.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xy = u_xlat2.xy * u_xlat8.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _Color.xyz + vs_COLOR1.xyz;
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MATCAP_ACCURATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCORRD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.yzx;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat3.xyz = u_xlat16_2.xyz * in_TANGENT0.www;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat6.xyz = u_xlat4.xyz * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat6.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-in_POSITION0.xyz);
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat5.xyz));
    u_xlat6.y = dot(u_xlat4.xyz, (-u_xlat5.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat5.xyz));
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCORRD5.xyz = vec3(u_xlat21) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat4.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat4.xy = u_xlat4.xy * (-u_xlat4.xy);
        u_xlat21 = u_xlat4.x * _FogTune;
        u_xlat21 = u_xlat21 * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat21 = (-u_xlat21) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat22 = _FogEffectStart * _FogTune;
        u_xlat21 = max(u_xlat21, u_xlat22);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat21 = u_xlat4.y * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat4.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat4.xy = u_xlat4.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat4.xy = u_xlat4.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat4.y * _FogEffectLimit;
        u_xlat22 = _FogEffectStart * _FogTune;
        u_xlat21 = max(u_xlat21, u_xlat22);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.x = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat4.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat4.x = u_xlat1.z;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.z = u_xlat0.x;
    vs_TEXCOORD2.xyz = u_xlat4.xyz;
    u_xlat4.x = u_xlat1.x;
    u_xlat4.y = u_xlat3.y;
    u_xlat4.z = u_xlat0.y;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    u_xlat0.x = u_xlat1.y;
    u_xlat0.y = u_xlat3.z;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCORRD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_13 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_13) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_13 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_13) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCORRD5.xyz, u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + vs_TEXCORRD5.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xy = u_xlat2.xy * u_xlat8.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _Color.xyz + vs_COLOR1.xyz;
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "MATCAP_ACCURATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCORRD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.yzx;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat3.xyz = u_xlat16_2.xyz * in_TANGENT0.www;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat6.xyz = u_xlat4.xyz * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat6.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-in_POSITION0.xyz);
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat5.xyz));
    u_xlat6.y = dot(u_xlat4.xyz, (-u_xlat5.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat5.xyz));
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCORRD5.xyz = vec3(u_xlat21) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat4.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat4.xy = u_xlat4.xy * (-u_xlat4.xy);
        u_xlat21 = u_xlat4.x * _FogTune;
        u_xlat21 = u_xlat21 * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat21 = (-u_xlat21) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat22 = _FogEffectStart * _FogTune;
        u_xlat21 = max(u_xlat21, u_xlat22);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat21 = u_xlat4.y * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat4.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat4.xy = u_xlat4.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat4.xy = u_xlat4.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat4.y * _FogEffectLimit;
        u_xlat22 = _FogEffectStart * _FogTune;
        u_xlat21 = max(u_xlat21, u_xlat22);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.x = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat4.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat4.x = u_xlat1.z;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.z = u_xlat0.x;
    vs_TEXCOORD2.xyz = u_xlat4.xyz;
    u_xlat4.x = u_xlat1.x;
    u_xlat4.y = u_xlat3.y;
    u_xlat4.z = u_xlat0.y;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    u_xlat0.x = u_xlat1.y;
    u_xlat0.y = u_xlat3.z;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCORRD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_13 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_13) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_13 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_13) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCORRD5.xyz, u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + vs_TEXCORRD5.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xy = u_xlat2.xy * u_xlat8.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _Color.xyz + vs_COLOR1.xyz;
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "MATCAP_ACCURATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCORRD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.yzx;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat3.xyz = u_xlat16_2.xyz * in_TANGENT0.www;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat6.xyz = u_xlat4.xyz * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat6.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-in_POSITION0.xyz);
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat5.xyz));
    u_xlat6.y = dot(u_xlat4.xyz, (-u_xlat5.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat5.xyz));
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCORRD5.xyz = vec3(u_xlat21) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat4.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat4.xy = u_xlat4.xy * (-u_xlat4.xy);
        u_xlat21 = u_xlat4.x * _FogTune;
        u_xlat21 = u_xlat21 * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat21 = (-u_xlat21) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat22 = _FogEffectStart * _FogTune;
        u_xlat21 = max(u_xlat21, u_xlat22);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat21 = u_xlat4.y * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat4.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat4.xy = u_xlat4.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat4.xy = u_xlat4.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat4.y * _FogEffectLimit;
        u_xlat22 = _FogEffectStart * _FogTune;
        u_xlat21 = max(u_xlat21, u_xlat22);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.x = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat4.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat4.x = u_xlat1.z;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.z = u_xlat0.x;
    vs_TEXCOORD2.xyz = u_xlat4.xyz;
    u_xlat4.x = u_xlat1.x;
    u_xlat4.y = u_xlat3.y;
    u_xlat4.z = u_xlat0.y;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    u_xlat0.x = u_xlat1.y;
    u_xlat0.y = u_xlat3.z;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCORRD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_13 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_13) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_13 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_13) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCORRD5.xyz, u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + vs_TEXCORRD5.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xy = u_xlat2.xy * u_xlat8.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _Color.xyz + vs_COLOR1.xyz;
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "MATCAP_ACCURATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCORRD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.yzx;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat3.xyz = u_xlat16_2.xyz * in_TANGENT0.www;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat6.xyz = u_xlat4.xyz * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat6.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-in_POSITION0.xyz);
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat5.xyz));
    u_xlat6.y = dot(u_xlat4.xyz, (-u_xlat5.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat5.xyz));
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCORRD5.xyz = vec3(u_xlat21) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat4.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat4.xy = u_xlat4.xy * (-u_xlat4.xy);
        u_xlat21 = u_xlat4.x * _FogTune;
        u_xlat21 = u_xlat21 * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat21 = (-u_xlat21) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat22 = _FogEffectStart * _FogTune;
        u_xlat21 = max(u_xlat21, u_xlat22);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat21 = u_xlat4.y * 1.44269502;
        u_xlat21 = exp2(u_xlat21);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat4.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat4.xy = u_xlat4.xy * vec2(500.0, 1000.0);
        u_xlat21 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat4.xy = u_xlat4.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat4.y * _FogEffectLimit;
        u_xlat22 = _FogEffectStart * _FogTune;
        u_xlat21 = max(u_xlat21, u_xlat22);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.x = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat4.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat4.x = u_xlat1.z;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.z = u_xlat0.x;
    vs_TEXCOORD2.xyz = u_xlat4.xyz;
    u_xlat4.x = u_xlat1.x;
    u_xlat4.y = u_xlat3.y;
    u_xlat4.z = u_xlat0.y;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    u_xlat0.x = u_xlat1.y;
    u_xlat0.y = u_xlat3.z;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCORRD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_13 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_13) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_13 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_13) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCORRD5.xyz, u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + vs_TEXCORRD5.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xy = u_xlat2.xy * u_xlat8.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _Color.xyz + vs_COLOR1.xyz;
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "MATCAP_ACCURATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCORRD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
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
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3.x = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat5 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yzx;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat2.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat4.y = u_xlat2.x;
    u_xlat4.x = u_xlat1.z;
    u_xlat4.z = u_xlat0.x;
    vs_TEXCOORD2.xyz = u_xlat4.xyz;
    u_xlat0.x = u_xlat1.y;
    u_xlat1.z = u_xlat0.y;
    u_xlat1.y = u_xlat2.y;
    u_xlat0.y = u_xlat2.z;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
    u_xlat15 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * in_TANGENT0.yzx;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat0.y = dot(u_xlat0.xyz, (-u_xlat1.xyz));
    u_xlat0.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat0.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCORRD5.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCORRD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_13 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_13) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_13 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_13) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCORRD5.xyz, u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + vs_TEXCORRD5.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xy = u_xlat2.xy * u_xlat8.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "MATCAP_ACCURATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCORRD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
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
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3.x = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat5 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yzx;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat2.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat4.y = u_xlat2.x;
    u_xlat4.x = u_xlat1.z;
    u_xlat4.z = u_xlat0.x;
    vs_TEXCOORD2.xyz = u_xlat4.xyz;
    u_xlat0.x = u_xlat1.y;
    u_xlat1.z = u_xlat0.y;
    u_xlat1.y = u_xlat2.y;
    u_xlat0.y = u_xlat2.z;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
    u_xlat15 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * in_TANGENT0.yzx;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat0.y = dot(u_xlat0.xyz, (-u_xlat1.xyz));
    u_xlat0.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat0.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCORRD5.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCORRD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_13 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_13) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_13 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_13) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCORRD5.xyz, u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + vs_TEXCORRD5.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xy = u_xlat2.xy * u_xlat8.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "MATCAP_ACCURATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCORRD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
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
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3.x = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat5 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yzx;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat2.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat4.y = u_xlat2.x;
    u_xlat4.x = u_xlat1.z;
    u_xlat4.z = u_xlat0.x;
    vs_TEXCOORD2.xyz = u_xlat4.xyz;
    u_xlat0.x = u_xlat1.y;
    u_xlat1.z = u_xlat0.y;
    u_xlat1.y = u_xlat2.y;
    u_xlat0.y = u_xlat2.z;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
    u_xlat15 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * in_TANGENT0.yzx;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat0.y = dot(u_xlat0.xyz, (-u_xlat1.xyz));
    u_xlat0.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat0.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCORRD5.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCORRD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_13 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_13) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_13 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_13) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCORRD5.xyz, u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + vs_TEXCORRD5.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xy = u_xlat2.xy * u_xlat8.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "MATCAP_ACCURATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCORRD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat18 = (u_xlatb2) ? u_xlat19 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat19 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat8.x = u_xlat19 * -1.44269502;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3 = (u_xlatb19) ? u_xlat8.x : 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat19 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat19) + 2.0;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat19 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_3 = u_xlat19 * u_xlat16_3;
    u_xlat19 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat8.x = (-u_xlat19) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat8.xxx;
    u_xlat3.w = u_xlat18 * u_xlat8.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat16_4.x = (-u_xlat6.x) + 2.0;
    u_xlat16_4.x = u_xlat6.x * u_xlat16_4.x;
    u_xlat1.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat8.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * u_xlat8.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb2) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_4.x = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat12 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_10 = (-u_xlat0.x) + 2.0;
    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
    u_xlat0.x = u_xlat16_10 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.w = u_xlat12 * u_xlat6.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat2.x;
    u_xlat5.x = u_xlat1.z;
    u_xlat5.z = u_xlat0.x;
    vs_TEXCOORD2.xyz = u_xlat5.xyz;
    u_xlat0.x = u_xlat1.y;
    u_xlat1.z = u_xlat0.y;
    u_xlat1.y = u_xlat2.y;
    u_xlat0.y = u_xlat2.z;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
    u_xlat18 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * in_TANGENT0.yzx;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat0.y = dot(u_xlat0.xyz, (-u_xlat1.xyz));
    u_xlat0.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat0.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCORRD5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCORRD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_13 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_13) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_13 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_13) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCORRD5.xyz, u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + vs_TEXCORRD5.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xy = u_xlat2.xy * u_xlat8.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "MATCAP_ACCURATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCORRD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat18 = (u_xlatb2) ? u_xlat19 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat19 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat8.x = u_xlat19 * -1.44269502;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3 = (u_xlatb19) ? u_xlat8.x : 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat19 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat19) + 2.0;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat19 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_3 = u_xlat19 * u_xlat16_3;
    u_xlat19 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat8.x = (-u_xlat19) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat8.xxx;
    u_xlat3.w = u_xlat18 * u_xlat8.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat16_4.x = (-u_xlat6.x) + 2.0;
    u_xlat16_4.x = u_xlat6.x * u_xlat16_4.x;
    u_xlat1.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat8.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * u_xlat8.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb2) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_4.x = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat12 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_10 = (-u_xlat0.x) + 2.0;
    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
    u_xlat0.x = u_xlat16_10 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.w = u_xlat12 * u_xlat6.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat2.x;
    u_xlat5.x = u_xlat1.z;
    u_xlat5.z = u_xlat0.x;
    vs_TEXCOORD2.xyz = u_xlat5.xyz;
    u_xlat0.x = u_xlat1.y;
    u_xlat1.z = u_xlat0.y;
    u_xlat1.y = u_xlat2.y;
    u_xlat0.y = u_xlat2.z;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
    u_xlat18 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * in_TANGENT0.yzx;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat0.y = dot(u_xlat0.xyz, (-u_xlat1.xyz));
    u_xlat0.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat0.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCORRD5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCORRD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_13 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_13) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_13 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_13) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCORRD5.xyz, u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + vs_TEXCORRD5.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xy = u_xlat2.xy * u_xlat8.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "MATCAP_ACCURATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCORRD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
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
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat18 = (u_xlatb2) ? u_xlat19 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat19 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat8.x = u_xlat19 * -1.44269502;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3 = (u_xlatb19) ? u_xlat8.x : 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat19 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat19) + 2.0;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat19 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_3 = u_xlat19 * u_xlat16_3;
    u_xlat19 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat8.x = (-u_xlat19) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat8.xxx;
    u_xlat3.w = u_xlat18 * u_xlat8.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat16_4.x = (-u_xlat6.x) + 2.0;
    u_xlat16_4.x = u_xlat6.x * u_xlat16_4.x;
    u_xlat1.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat8.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * u_xlat8.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb2) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_4.x = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat12 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_10 = (-u_xlat0.x) + 2.0;
    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
    u_xlat0.x = u_xlat16_10 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.w = u_xlat12 * u_xlat6.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat2.x;
    u_xlat5.x = u_xlat1.z;
    u_xlat5.z = u_xlat0.x;
    vs_TEXCOORD2.xyz = u_xlat5.xyz;
    u_xlat0.x = u_xlat1.y;
    u_xlat1.z = u_xlat0.y;
    u_xlat1.y = u_xlat2.y;
    u_xlat0.y = u_xlat2.z;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
    u_xlat18 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * in_TANGENT0.yzx;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat0.y = dot(u_xlat0.xyz, (-u_xlat1.xyz));
    u_xlat0.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat0.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCORRD5.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCORRD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_13 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_13) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_13 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_13) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCORRD5.xyz, u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + vs_TEXCORRD5.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xy = u_xlat2.xy * u_xlat8.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MatCap, u_xlat0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
Keywords { "MATCAP_ACCURATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MATCAP_ACCURATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MATCAP_ACCURATE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "MATCAP_ACCURATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "MATCAP_ACCURATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "MATCAP_ACCURATE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "MATCAP_ACCURATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "MATCAP_ACCURATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "MATCAP_ACCURATE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "MATCAP_ACCURATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "MATCAP_ACCURATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "MATCAP_ACCURATE" }
""
}
}
}
}
Fallback "VertexLit"
}