//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/Scene_Air_LightMap_Matcap_Sand_Displacement" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
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
[MHYHeaderBox(Blink)] _LightPosition ("LightPosition", Vector) = (0,0,0,0)
_SandShineTex ("SandShineTex", 2D) = "white" { }
_SecondTexColor ("SecondTexColor", Color) = (1,1,1,0)
_SecondTexIntensity ("SecondTexIntensity", Float) = -0.15
_HeiLightGlass ("HeiLightGlass", Float) = 1
_HeiLightTexSpeed ("HeiLightTexSpeed", Vector) = (0,0,0,0)
_HeiLightTexTilling ("HeiLightTexTilling", Vector) = (1,1,0,0)
_HeiLightInvertColor ("HeiLightInvertColor", Color) = (0,0,0,0)
_HeiLightInvertIntensity ("HeiLightInvertIntensity", Float) = 1
_HeiLightPointColor ("HeiLightPointColor", Color) = (1,1,1,0)
_HeiLightPointIntensity ("HeiLightPointIntensity", Float) = 1
_HeiLightPointStep ("HeiLightPointStep", Float) = 0.53
_HeiLightPointStepWidth ("HeiLightPointStepWidth", Float) = 0
_HeiLightPointTilling ("HeiLightPointTilling", Vector) = (1,1,0,0)
[MHYHeaderBox(Displacement)] _DisplacementMap ("_Displacement Map", 2D) = "black" { }
_MaxHeight ("Max Height", Range(0, 2)) = 1
_GroundHeight ("Ground Height", Float) = 0
_BlendStrengthen ("Blend Strengthen", Range(1, 20)) = 1
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 23824
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat16;
vec2 u_xlat17;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat8.x = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat8.x = u_xlat8.x * _MaxHeight;
    u_xlat16 = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat1.x = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat2.y = u_xlat16 * _MaxHeight + (-u_xlat8.x);
    u_xlat2.x = -0.00999999978;
    u_xlat8.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xz = u_xlat8.xx * vec2(0.0, -0.00999999978);
    u_xlat3.y = u_xlat8.x * u_xlat2.y;
    u_xlat1.z = u_xlat1.x * _MaxHeight + (-u_xlat24);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(-0.00999999978);
    u_xlat1.w = float(0.0);
    u_xlat8.x = dot(u_xlat1.yz, u_xlat1.yz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat8.xyz * u_xlat3.xyz;
    u_xlat8.xyz = u_xlat3.zxy * u_xlat8.yzx + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat8.xyz = u_xlat8.yzx * u_xlat1.xxx;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1 = vec4(u_xlat0) * u_xlat1;
    u_xlat1 = u_xlat1 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat2.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.zxy * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat0 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat5.xyz = vec3(u_xlat0) * in_NORMAL0.zxy;
    u_xlat0 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat6.xyz = vec3(u_xlat0) * in_TANGENT0.yzx;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.zxy * u_xlat6.yzx + (-u_xlat7.xyz);
    u_xlat5.xyz = u_xlat5.xyz * in_TANGENT0.www;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat6.xyz;
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat6.y = dot(u_xlat5.xyz, (-u_xlat1.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat0 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD5.xyz = vec3(u_xlat0) * u_xlat6.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat5.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * (-u_xlat17.xy);
        u_xlat0 = u_xlat17.x * _FogTune;
        u_xlat0 = u_xlat0 * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat0 = (-u_xlat0) + 1.0;
        u_xlat0 = u_xlat0 * _FogEffectLimit;
        u_xlat17.x = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat17.x);
        u_xlat5.w = min(u_xlat0, _FogEffectLimit);
        u_xlat0 = u_xlat17.y * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat0) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * vec2(500.0, 1000.0);
        u_xlat0 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.100000001);
        u_xlat17.xy = u_xlat17.yx / vec2(u_xlat0);
        u_xlat0 = u_xlat17.y * _FogEffectLimit;
        u_xlat25 = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat25);
        u_xlat2.w = min(u_xlat0, _FogEffectLimit);
        u_xlat17.x = u_xlat17.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat17.x = min(max(u_xlat17.x, 0.0), 1.0);
#else
        u_xlat17.x = clamp(u_xlat17.x, 0.0, 1.0);
#endif
        u_xlat0 = (-u_xlat17.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat0) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat2.x = u_xlat3.z;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat8.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat2.x = u_xlat3.x;
    u_xlat2.y = u_xlat4.y;
    u_xlat2.z = u_xlat8.y;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat8.x = u_xlat3.y;
    u_xlat8.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat8.xyz;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_0.x = texture(_SandShineTex, u_xlat0.xy).x;
    u_xlat0.xyz = u_xlat10_0.xxx * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SecondTexIntensity) + u_xlat16_3.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat16;
vec2 u_xlat17;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat8.x = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat8.x = u_xlat8.x * _MaxHeight;
    u_xlat16 = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat1.x = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat2.y = u_xlat16 * _MaxHeight + (-u_xlat8.x);
    u_xlat2.x = -0.00999999978;
    u_xlat8.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xz = u_xlat8.xx * vec2(0.0, -0.00999999978);
    u_xlat3.y = u_xlat8.x * u_xlat2.y;
    u_xlat1.z = u_xlat1.x * _MaxHeight + (-u_xlat24);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(-0.00999999978);
    u_xlat1.w = float(0.0);
    u_xlat8.x = dot(u_xlat1.yz, u_xlat1.yz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat8.xyz * u_xlat3.xyz;
    u_xlat8.xyz = u_xlat3.zxy * u_xlat8.yzx + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat8.xyz = u_xlat8.yzx * u_xlat1.xxx;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1 = vec4(u_xlat0) * u_xlat1;
    u_xlat1 = u_xlat1 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat2.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.zxy * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat0 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat5.xyz = vec3(u_xlat0) * in_NORMAL0.zxy;
    u_xlat0 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat6.xyz = vec3(u_xlat0) * in_TANGENT0.yzx;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.zxy * u_xlat6.yzx + (-u_xlat7.xyz);
    u_xlat5.xyz = u_xlat5.xyz * in_TANGENT0.www;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat6.xyz;
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat6.y = dot(u_xlat5.xyz, (-u_xlat1.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat0 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD5.xyz = vec3(u_xlat0) * u_xlat6.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat5.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * (-u_xlat17.xy);
        u_xlat0 = u_xlat17.x * _FogTune;
        u_xlat0 = u_xlat0 * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat0 = (-u_xlat0) + 1.0;
        u_xlat0 = u_xlat0 * _FogEffectLimit;
        u_xlat17.x = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat17.x);
        u_xlat5.w = min(u_xlat0, _FogEffectLimit);
        u_xlat0 = u_xlat17.y * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat0) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * vec2(500.0, 1000.0);
        u_xlat0 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.100000001);
        u_xlat17.xy = u_xlat17.yx / vec2(u_xlat0);
        u_xlat0 = u_xlat17.y * _FogEffectLimit;
        u_xlat25 = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat25);
        u_xlat2.w = min(u_xlat0, _FogEffectLimit);
        u_xlat17.x = u_xlat17.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat17.x = min(max(u_xlat17.x, 0.0), 1.0);
#else
        u_xlat17.x = clamp(u_xlat17.x, 0.0, 1.0);
#endif
        u_xlat0 = (-u_xlat17.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat0) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat2.x = u_xlat3.z;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat8.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat2.x = u_xlat3.x;
    u_xlat2.y = u_xlat4.y;
    u_xlat2.z = u_xlat8.y;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat8.x = u_xlat3.y;
    u_xlat8.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat8.xyz;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_0.x = texture(_SandShineTex, u_xlat0.xy).x;
    u_xlat0.xyz = u_xlat10_0.xxx * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SecondTexIntensity) + u_xlat16_3.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat16;
vec2 u_xlat17;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat8.x = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat8.x = u_xlat8.x * _MaxHeight;
    u_xlat16 = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat1.x = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat2.y = u_xlat16 * _MaxHeight + (-u_xlat8.x);
    u_xlat2.x = -0.00999999978;
    u_xlat8.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xz = u_xlat8.xx * vec2(0.0, -0.00999999978);
    u_xlat3.y = u_xlat8.x * u_xlat2.y;
    u_xlat1.z = u_xlat1.x * _MaxHeight + (-u_xlat24);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(-0.00999999978);
    u_xlat1.w = float(0.0);
    u_xlat8.x = dot(u_xlat1.yz, u_xlat1.yz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat8.xyz * u_xlat3.xyz;
    u_xlat8.xyz = u_xlat3.zxy * u_xlat8.yzx + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat8.xyz = u_xlat8.yzx * u_xlat1.xxx;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1 = vec4(u_xlat0) * u_xlat1;
    u_xlat1 = u_xlat1 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat2.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.zxy * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat0 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat5.xyz = vec3(u_xlat0) * in_NORMAL0.zxy;
    u_xlat0 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat6.xyz = vec3(u_xlat0) * in_TANGENT0.yzx;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.zxy * u_xlat6.yzx + (-u_xlat7.xyz);
    u_xlat5.xyz = u_xlat5.xyz * in_TANGENT0.www;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat6.xyz;
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat6.y = dot(u_xlat5.xyz, (-u_xlat1.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat0 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD5.xyz = vec3(u_xlat0) * u_xlat6.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat5.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * (-u_xlat17.xy);
        u_xlat0 = u_xlat17.x * _FogTune;
        u_xlat0 = u_xlat0 * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat0 = (-u_xlat0) + 1.0;
        u_xlat0 = u_xlat0 * _FogEffectLimit;
        u_xlat17.x = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat17.x);
        u_xlat5.w = min(u_xlat0, _FogEffectLimit);
        u_xlat0 = u_xlat17.y * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat0) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * vec2(500.0, 1000.0);
        u_xlat0 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.100000001);
        u_xlat17.xy = u_xlat17.yx / vec2(u_xlat0);
        u_xlat0 = u_xlat17.y * _FogEffectLimit;
        u_xlat25 = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat25);
        u_xlat2.w = min(u_xlat0, _FogEffectLimit);
        u_xlat17.x = u_xlat17.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat17.x = min(max(u_xlat17.x, 0.0), 1.0);
#else
        u_xlat17.x = clamp(u_xlat17.x, 0.0, 1.0);
#endif
        u_xlat0 = (-u_xlat17.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat0) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat2.x = u_xlat3.z;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat8.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat2.x = u_xlat3.x;
    u_xlat2.y = u_xlat4.y;
    u_xlat2.z = u_xlat8.y;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat8.x = u_xlat3.y;
    u_xlat8.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat8.xyz;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_0.x = texture(_SandShineTex, u_xlat0.xy).x;
    u_xlat0.xyz = u_xlat10_0.xxx * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SecondTexIntensity) + u_xlat16_3.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 _WorldSpaceLightPos0;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat16;
vec2 u_xlat17;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat8.x = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat8.x = u_xlat8.x * _MaxHeight;
    u_xlat16 = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat1.x = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat2.y = u_xlat16 * _MaxHeight + (-u_xlat8.x);
    u_xlat2.x = -0.00999999978;
    u_xlat8.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xz = u_xlat8.xx * vec2(0.0, -0.00999999978);
    u_xlat3.y = u_xlat8.x * u_xlat2.y;
    u_xlat1.z = u_xlat1.x * _MaxHeight + (-u_xlat24);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(-0.00999999978);
    u_xlat1.w = float(0.0);
    u_xlat8.x = dot(u_xlat1.yz, u_xlat1.yz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat8.xyz * u_xlat3.xyz;
    u_xlat8.xyz = u_xlat3.zxy * u_xlat8.yzx + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat8.xyz = u_xlat8.yzx * u_xlat1.xxx;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1 = vec4(u_xlat0) * u_xlat1;
    u_xlat1 = u_xlat1 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat2.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.zxy * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat0 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat5.xyz = vec3(u_xlat0) * in_NORMAL0.zxy;
    u_xlat0 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat6.xyz = vec3(u_xlat0) * in_TANGENT0.yzx;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.zxy * u_xlat6.yzx + (-u_xlat7.xyz);
    u_xlat5.xyz = u_xlat5.xyz * in_TANGENT0.www;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat6.xyz;
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat6.y = dot(u_xlat5.xyz, (-u_xlat1.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat0 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD5.xyz = vec3(u_xlat0) * u_xlat6.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat5.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * (-u_xlat17.xy);
        u_xlat0 = u_xlat17.x * _FogTune;
        u_xlat0 = u_xlat0 * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat0 = (-u_xlat0) + 1.0;
        u_xlat0 = u_xlat0 * _FogEffectLimit;
        u_xlat17.x = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat17.x);
        u_xlat5.w = min(u_xlat0, _FogEffectLimit);
        u_xlat0 = u_xlat17.y * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat0) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * vec2(500.0, 1000.0);
        u_xlat0 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.100000001);
        u_xlat17.xy = u_xlat17.yx / vec2(u_xlat0);
        u_xlat0 = u_xlat17.y * _FogEffectLimit;
        u_xlat25 = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat25);
        u_xlat2.w = min(u_xlat0, _FogEffectLimit);
        u_xlat17.x = u_xlat17.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat17.x = min(max(u_xlat17.x, 0.0), 1.0);
#else
        u_xlat17.x = clamp(u_xlat17.x, 0.0, 1.0);
#endif
        u_xlat0 = (-u_xlat17.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat0) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat2.x = u_xlat3.z;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat8.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat2.x = u_xlat3.x;
    u_xlat2.y = u_xlat4.y;
    u_xlat2.z = u_xlat8.y;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat8.x = u_xlat3.y;
    u_xlat8.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat8.xyz;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_0.x = texture(_SandShineTex, u_xlat0.xy).x;
    u_xlat0.xyz = u_xlat10_0.xxx * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SecondTexIntensity) + u_xlat16_3.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 _WorldSpaceLightPos0;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat16;
vec2 u_xlat17;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat8.x = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat8.x = u_xlat8.x * _MaxHeight;
    u_xlat16 = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat1.x = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat2.y = u_xlat16 * _MaxHeight + (-u_xlat8.x);
    u_xlat2.x = -0.00999999978;
    u_xlat8.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xz = u_xlat8.xx * vec2(0.0, -0.00999999978);
    u_xlat3.y = u_xlat8.x * u_xlat2.y;
    u_xlat1.z = u_xlat1.x * _MaxHeight + (-u_xlat24);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(-0.00999999978);
    u_xlat1.w = float(0.0);
    u_xlat8.x = dot(u_xlat1.yz, u_xlat1.yz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat8.xyz * u_xlat3.xyz;
    u_xlat8.xyz = u_xlat3.zxy * u_xlat8.yzx + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat8.xyz = u_xlat8.yzx * u_xlat1.xxx;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1 = vec4(u_xlat0) * u_xlat1;
    u_xlat1 = u_xlat1 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat2.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.zxy * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat0 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat5.xyz = vec3(u_xlat0) * in_NORMAL0.zxy;
    u_xlat0 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat6.xyz = vec3(u_xlat0) * in_TANGENT0.yzx;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.zxy * u_xlat6.yzx + (-u_xlat7.xyz);
    u_xlat5.xyz = u_xlat5.xyz * in_TANGENT0.www;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat6.xyz;
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat6.y = dot(u_xlat5.xyz, (-u_xlat1.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat0 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD5.xyz = vec3(u_xlat0) * u_xlat6.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat5.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * (-u_xlat17.xy);
        u_xlat0 = u_xlat17.x * _FogTune;
        u_xlat0 = u_xlat0 * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat0 = (-u_xlat0) + 1.0;
        u_xlat0 = u_xlat0 * _FogEffectLimit;
        u_xlat17.x = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat17.x);
        u_xlat5.w = min(u_xlat0, _FogEffectLimit);
        u_xlat0 = u_xlat17.y * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat0) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * vec2(500.0, 1000.0);
        u_xlat0 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.100000001);
        u_xlat17.xy = u_xlat17.yx / vec2(u_xlat0);
        u_xlat0 = u_xlat17.y * _FogEffectLimit;
        u_xlat25 = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat25);
        u_xlat2.w = min(u_xlat0, _FogEffectLimit);
        u_xlat17.x = u_xlat17.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat17.x = min(max(u_xlat17.x, 0.0), 1.0);
#else
        u_xlat17.x = clamp(u_xlat17.x, 0.0, 1.0);
#endif
        u_xlat0 = (-u_xlat17.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat0) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat2.x = u_xlat3.z;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat8.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat2.x = u_xlat3.x;
    u_xlat2.y = u_xlat4.y;
    u_xlat2.z = u_xlat8.y;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat8.x = u_xlat3.y;
    u_xlat8.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat8.xyz;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_0.x = texture(_SandShineTex, u_xlat0.xy).x;
    u_xlat0.xyz = u_xlat10_0.xxx * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SecondTexIntensity) + u_xlat16_3.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 _WorldSpaceLightPos0;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat16;
vec2 u_xlat17;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat8.x = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat8.x = u_xlat8.x * _MaxHeight;
    u_xlat16 = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat1.x = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat2.y = u_xlat16 * _MaxHeight + (-u_xlat8.x);
    u_xlat2.x = -0.00999999978;
    u_xlat8.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xz = u_xlat8.xx * vec2(0.0, -0.00999999978);
    u_xlat3.y = u_xlat8.x * u_xlat2.y;
    u_xlat1.z = u_xlat1.x * _MaxHeight + (-u_xlat24);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(-0.00999999978);
    u_xlat1.w = float(0.0);
    u_xlat8.x = dot(u_xlat1.yz, u_xlat1.yz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat8.xyz * u_xlat3.xyz;
    u_xlat8.xyz = u_xlat3.zxy * u_xlat8.yzx + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat8.xyz = u_xlat8.yzx * u_xlat1.xxx;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1 = vec4(u_xlat0) * u_xlat1;
    u_xlat1 = u_xlat1 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat2.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.zxy * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat0 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat5.xyz = vec3(u_xlat0) * in_NORMAL0.zxy;
    u_xlat0 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat6.xyz = vec3(u_xlat0) * in_TANGENT0.yzx;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.zxy * u_xlat6.yzx + (-u_xlat7.xyz);
    u_xlat5.xyz = u_xlat5.xyz * in_TANGENT0.www;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat6.xyz;
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat6.y = dot(u_xlat5.xyz, (-u_xlat1.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat0 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD5.xyz = vec3(u_xlat0) * u_xlat6.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat5.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * (-u_xlat17.xy);
        u_xlat0 = u_xlat17.x * _FogTune;
        u_xlat0 = u_xlat0 * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat0 = (-u_xlat0) + 1.0;
        u_xlat0 = u_xlat0 * _FogEffectLimit;
        u_xlat17.x = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat17.x);
        u_xlat5.w = min(u_xlat0, _FogEffectLimit);
        u_xlat0 = u_xlat17.y * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat0) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * vec2(500.0, 1000.0);
        u_xlat0 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.100000001);
        u_xlat17.xy = u_xlat17.yx / vec2(u_xlat0);
        u_xlat0 = u_xlat17.y * _FogEffectLimit;
        u_xlat25 = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat25);
        u_xlat2.w = min(u_xlat0, _FogEffectLimit);
        u_xlat17.x = u_xlat17.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat17.x = min(max(u_xlat17.x, 0.0), 1.0);
#else
        u_xlat17.x = clamp(u_xlat17.x, 0.0, 1.0);
#endif
        u_xlat0 = (-u_xlat17.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat0) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat2.x = u_xlat3.z;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat8.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat2.x = u_xlat3.x;
    u_xlat2.y = u_xlat4.y;
    u_xlat2.z = u_xlat8.y;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat8.x = u_xlat3.y;
    u_xlat8.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat8.xyz;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_0.x = texture(_SandShineTex, u_xlat0.xy).x;
    u_xlat0.xyz = u_xlat10_0.xxx * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SecondTexIntensity) + u_xlat16_3.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
void main()
{
    u_xlat0.x = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat21 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat21) + 2.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat2.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat23 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(u_xlat21>=u_xlat23);
#else
    u_xlatb23 = u_xlat21>=u_xlat23;
#endif
    u_xlat3.x = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat3.x) + 2.0;
    u_xlat3.x = u_xlat10 * u_xlat3.x;
    u_xlat10 = u_xlat3.x * _HeigtFogColDelta.w;
    u_xlat23 = (u_xlatb23) ? u_xlat10 : u_xlat3.x;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat3.x = u_xlat22 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_4 = (u_xlatb22) ? u_xlat3.x : 1.0;
    u_xlat22 = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat22 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat22 = (-u_xlat21) + 1.0;
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.w = u_xlat22 * u_xlat23;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat21 = textureLod(_DisplacementMap, u_xlat2.xy, 0.0).x;
    u_xlat22 = textureLod(_DisplacementMap, u_xlat2.zw, 0.0).x;
    u_xlat21 = u_xlat21 * _MaxHeight;
    u_xlat2.z = u_xlat22 * _MaxHeight + (-u_xlat21);
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(-0.00999999978);
    u_xlat21 = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat21 = textureLod(_DisplacementMap, u_xlat3.xy, 0.0).x;
    u_xlat22 = textureLod(_DisplacementMap, u_xlat3.zw, 0.0).x;
    u_xlat21 = u_xlat21 * _MaxHeight;
    u_xlat3.y = u_xlat22 * _MaxHeight + (-u_xlat21);
    u_xlat3.x = -0.00999999978;
    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.y = u_xlat21 * u_xlat3.y;
    u_xlat3.xz = vec2(u_xlat21) * vec2(0.0, -0.00999999978);
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.z = u_xlat2.y;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.yxz;
    u_xlat6.xyz = u_xlat2.xyz * u_xlat5.yxz;
    u_xlat6.xyz = u_xlat2.zxy * u_xlat5.xzy + (-u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz * in_TANGENT0.www;
    u_xlat3.y = u_xlat6.x;
    u_xlat3.x = u_xlat5.z;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat5.z = u_xlat2.x;
    u_xlat2.x = u_xlat5.y;
    u_xlat2.y = u_xlat6.y;
    u_xlat5.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat3.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(in_TANGENT0.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(in_NORMAL0.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_0.x = texture(_SandShineTex, u_xlat0.xy).x;
    u_xlat0.xyz = u_xlat10_0.xxx * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SecondTexIntensity) + u_xlat16_3.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
void main()
{
    u_xlat0.x = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat21 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat21) + 2.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat2.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat23 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(u_xlat21>=u_xlat23);
#else
    u_xlatb23 = u_xlat21>=u_xlat23;
#endif
    u_xlat3.x = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat3.x) + 2.0;
    u_xlat3.x = u_xlat10 * u_xlat3.x;
    u_xlat10 = u_xlat3.x * _HeigtFogColDelta.w;
    u_xlat23 = (u_xlatb23) ? u_xlat10 : u_xlat3.x;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat3.x = u_xlat22 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_4 = (u_xlatb22) ? u_xlat3.x : 1.0;
    u_xlat22 = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat22 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat22 = (-u_xlat21) + 1.0;
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.w = u_xlat22 * u_xlat23;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat21 = textureLod(_DisplacementMap, u_xlat2.xy, 0.0).x;
    u_xlat22 = textureLod(_DisplacementMap, u_xlat2.zw, 0.0).x;
    u_xlat21 = u_xlat21 * _MaxHeight;
    u_xlat2.z = u_xlat22 * _MaxHeight + (-u_xlat21);
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(-0.00999999978);
    u_xlat21 = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat21 = textureLod(_DisplacementMap, u_xlat3.xy, 0.0).x;
    u_xlat22 = textureLod(_DisplacementMap, u_xlat3.zw, 0.0).x;
    u_xlat21 = u_xlat21 * _MaxHeight;
    u_xlat3.y = u_xlat22 * _MaxHeight + (-u_xlat21);
    u_xlat3.x = -0.00999999978;
    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.y = u_xlat21 * u_xlat3.y;
    u_xlat3.xz = vec2(u_xlat21) * vec2(0.0, -0.00999999978);
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.z = u_xlat2.y;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.yxz;
    u_xlat6.xyz = u_xlat2.xyz * u_xlat5.yxz;
    u_xlat6.xyz = u_xlat2.zxy * u_xlat5.xzy + (-u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz * in_TANGENT0.www;
    u_xlat3.y = u_xlat6.x;
    u_xlat3.x = u_xlat5.z;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat5.z = u_xlat2.x;
    u_xlat2.x = u_xlat5.y;
    u_xlat2.y = u_xlat6.y;
    u_xlat5.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat3.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(in_TANGENT0.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(in_NORMAL0.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_0.x = texture(_SandShineTex, u_xlat0.xy).x;
    u_xlat0.xyz = u_xlat10_0.xxx * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SecondTexIntensity) + u_xlat16_3.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
void main()
{
    u_xlat0.x = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat21 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat21) + 2.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat2.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat23 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(u_xlat21>=u_xlat23);
#else
    u_xlatb23 = u_xlat21>=u_xlat23;
#endif
    u_xlat3.x = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat3.x) + 2.0;
    u_xlat3.x = u_xlat10 * u_xlat3.x;
    u_xlat10 = u_xlat3.x * _HeigtFogColDelta.w;
    u_xlat23 = (u_xlatb23) ? u_xlat10 : u_xlat3.x;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat3.x = u_xlat22 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_4 = (u_xlatb22) ? u_xlat3.x : 1.0;
    u_xlat22 = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat22 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat22 = (-u_xlat21) + 1.0;
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.w = u_xlat22 * u_xlat23;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat21 = textureLod(_DisplacementMap, u_xlat2.xy, 0.0).x;
    u_xlat22 = textureLod(_DisplacementMap, u_xlat2.zw, 0.0).x;
    u_xlat21 = u_xlat21 * _MaxHeight;
    u_xlat2.z = u_xlat22 * _MaxHeight + (-u_xlat21);
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(-0.00999999978);
    u_xlat21 = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat21 = textureLod(_DisplacementMap, u_xlat3.xy, 0.0).x;
    u_xlat22 = textureLod(_DisplacementMap, u_xlat3.zw, 0.0).x;
    u_xlat21 = u_xlat21 * _MaxHeight;
    u_xlat3.y = u_xlat22 * _MaxHeight + (-u_xlat21);
    u_xlat3.x = -0.00999999978;
    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.y = u_xlat21 * u_xlat3.y;
    u_xlat3.xz = vec2(u_xlat21) * vec2(0.0, -0.00999999978);
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.z = u_xlat2.y;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.yxz;
    u_xlat6.xyz = u_xlat2.xyz * u_xlat5.yxz;
    u_xlat6.xyz = u_xlat2.zxy * u_xlat5.xzy + (-u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz * in_TANGENT0.www;
    u_xlat3.y = u_xlat6.x;
    u_xlat3.x = u_xlat5.z;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat5.z = u_xlat2.x;
    u_xlat2.x = u_xlat5.y;
    u_xlat2.y = u_xlat6.y;
    u_xlat5.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat3.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(in_TANGENT0.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(in_NORMAL0.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_0.x = texture(_SandShineTex, u_xlat0.xy).x;
    u_xlat0.xyz = u_xlat10_0.xxx * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SecondTexIntensity) + u_xlat16_3.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat11;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
float u_xlat19;
float u_xlat24;
float u_xlat25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.x = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat24 = u_xlat1.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat24) + 2.0;
    u_xlat16_4 = u_xlat24 * u_xlat16_4;
    u_xlat2.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat25 = u_xlat24 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat25 = u_xlat24 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat25) + 2.0;
    u_xlat25 = u_xlat25 * u_xlat26;
    u_xlat26 = u_xlat25 * _HeigtFogColDelta3.w;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat24>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat24>=u_xlat3.x;
#endif
    u_xlat25 = (u_xlatb3) ? u_xlat26 : u_xlat25;
    u_xlat25 = log2(u_xlat25);
    u_xlat25 = u_xlat25 * _Mihoyo_FogColor3.w;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = min(u_xlat25, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat26 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat19 = u_xlat26 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4 = (u_xlatb26) ? u_xlat19 : 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat26 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat26) + 2.0;
    u_xlat16_12 = u_xlat26 * u_xlat16_12;
    u_xlat26 = u_xlat16_12 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_4 = u_xlat26 * u_xlat16_4;
    u_xlat26 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat19 = (-u_xlat26) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat19);
    u_xlat4.w = u_xlat25 * u_xlat19;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat26) + u_xlat2.xyz;
    u_xlat25 = u_xlat1.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat25) + 2.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat25 = u_xlat24 + (-_HeigtFogRamp2.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat25 = u_xlat24 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat25) + 2.0;
    u_xlat25 = u_xlat25 * u_xlat26;
    u_xlat26 = u_xlat25 * _HeigtFogColDelta2.w;
    u_xlat25 = (u_xlatb3) ? u_xlat26 : u_xlat25;
    u_xlat25 = log2(u_xlat25);
    u_xlat25 = u_xlat25 * _Mihoyo_FogColor2.w;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = min(u_xlat25, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat26 = u_xlat11 * -1.44269502;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat26 = u_xlat26 / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat26 : 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat24 = u_xlat24 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat26 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14 = (-u_xlat24) + 2.0;
    u_xlat16_14 = u_xlat24 * u_xlat16_14;
    u_xlat24 = u_xlat16_14 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat24 = u_xlat24 + 1.0;
    u_xlat16_6 = u_xlat24 * u_xlat16_6;
    u_xlat24 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat26 = (-u_xlat24) + 1.0;
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.w = u_xlat25 * u_xlat26;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat24) + u_xlat2.xyz;
    u_xlat2 = (-u_xlat3) + u_xlat4;
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat3;
    vs_COLOR1 = u_xlat2;
    u_xlat2 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat2.xy, 0.0).x;
    u_xlat25 = textureLod(_DisplacementMap, u_xlat2.zw, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat2.z = u_xlat25 * _MaxHeight + (-u_xlat24);
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(-0.00999999978);
    u_xlat24 = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat3.xy, 0.0).x;
    u_xlat25 = textureLod(_DisplacementMap, u_xlat3.zw, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat3.y = u_xlat25 * _MaxHeight + (-u_xlat24);
    u_xlat3.x = -0.00999999978;
    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.y = u_xlat24 * u_xlat3.y;
    u_xlat3.xz = vec2(u_xlat24) * vec2(0.0, -0.00999999978);
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = u_xlat2.y;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.yxz;
    u_xlat7.xyz = u_xlat2.xyz * u_xlat5.yxz;
    u_xlat7.xyz = u_xlat2.zxy * u_xlat5.xzy + (-u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat3.y = u_xlat7.x;
    u_xlat3.x = u_xlat5.z;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat5.z = u_xlat2.x;
    u_xlat2.x = u_xlat5.y;
    u_xlat2.y = u_xlat7.y;
    u_xlat5.y = u_xlat7.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat24 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * in_NORMAL0.zxy;
    u_xlat24 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * in_TANGENT0.yzx;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat3.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(in_TANGENT0.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(in_NORMAL0.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_0.x = texture(_SandShineTex, u_xlat0.xy).x;
    u_xlat0.xyz = u_xlat10_0.xxx * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SecondTexIntensity) + u_xlat16_3.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat11;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
float u_xlat19;
float u_xlat24;
float u_xlat25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.x = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat24 = u_xlat1.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat24) + 2.0;
    u_xlat16_4 = u_xlat24 * u_xlat16_4;
    u_xlat2.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat25 = u_xlat24 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat25 = u_xlat24 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat25) + 2.0;
    u_xlat25 = u_xlat25 * u_xlat26;
    u_xlat26 = u_xlat25 * _HeigtFogColDelta3.w;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat24>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat24>=u_xlat3.x;
#endif
    u_xlat25 = (u_xlatb3) ? u_xlat26 : u_xlat25;
    u_xlat25 = log2(u_xlat25);
    u_xlat25 = u_xlat25 * _Mihoyo_FogColor3.w;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = min(u_xlat25, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat26 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat19 = u_xlat26 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4 = (u_xlatb26) ? u_xlat19 : 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat26 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat26) + 2.0;
    u_xlat16_12 = u_xlat26 * u_xlat16_12;
    u_xlat26 = u_xlat16_12 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_4 = u_xlat26 * u_xlat16_4;
    u_xlat26 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat19 = (-u_xlat26) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat19);
    u_xlat4.w = u_xlat25 * u_xlat19;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat26) + u_xlat2.xyz;
    u_xlat25 = u_xlat1.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat25) + 2.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat25 = u_xlat24 + (-_HeigtFogRamp2.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat25 = u_xlat24 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat25) + 2.0;
    u_xlat25 = u_xlat25 * u_xlat26;
    u_xlat26 = u_xlat25 * _HeigtFogColDelta2.w;
    u_xlat25 = (u_xlatb3) ? u_xlat26 : u_xlat25;
    u_xlat25 = log2(u_xlat25);
    u_xlat25 = u_xlat25 * _Mihoyo_FogColor2.w;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = min(u_xlat25, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat26 = u_xlat11 * -1.44269502;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat26 = u_xlat26 / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat26 : 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat24 = u_xlat24 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat26 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14 = (-u_xlat24) + 2.0;
    u_xlat16_14 = u_xlat24 * u_xlat16_14;
    u_xlat24 = u_xlat16_14 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat24 = u_xlat24 + 1.0;
    u_xlat16_6 = u_xlat24 * u_xlat16_6;
    u_xlat24 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat26 = (-u_xlat24) + 1.0;
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.w = u_xlat25 * u_xlat26;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat24) + u_xlat2.xyz;
    u_xlat2 = (-u_xlat3) + u_xlat4;
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat3;
    vs_COLOR1 = u_xlat2;
    u_xlat2 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat2.xy, 0.0).x;
    u_xlat25 = textureLod(_DisplacementMap, u_xlat2.zw, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat2.z = u_xlat25 * _MaxHeight + (-u_xlat24);
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(-0.00999999978);
    u_xlat24 = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat3.xy, 0.0).x;
    u_xlat25 = textureLod(_DisplacementMap, u_xlat3.zw, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat3.y = u_xlat25 * _MaxHeight + (-u_xlat24);
    u_xlat3.x = -0.00999999978;
    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.y = u_xlat24 * u_xlat3.y;
    u_xlat3.xz = vec2(u_xlat24) * vec2(0.0, -0.00999999978);
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = u_xlat2.y;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.yxz;
    u_xlat7.xyz = u_xlat2.xyz * u_xlat5.yxz;
    u_xlat7.xyz = u_xlat2.zxy * u_xlat5.xzy + (-u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat3.y = u_xlat7.x;
    u_xlat3.x = u_xlat5.z;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat5.z = u_xlat2.x;
    u_xlat2.x = u_xlat5.y;
    u_xlat2.y = u_xlat7.y;
    u_xlat5.y = u_xlat7.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat24 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * in_NORMAL0.zxy;
    u_xlat24 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * in_TANGENT0.yzx;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat3.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(in_TANGENT0.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(in_NORMAL0.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_0.x = texture(_SandShineTex, u_xlat0.xy).x;
    u_xlat0.xyz = u_xlat10_0.xxx * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SecondTexIntensity) + u_xlat16_3.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat11;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
float u_xlat19;
float u_xlat24;
float u_xlat25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.x = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat24 = u_xlat1.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat24) + 2.0;
    u_xlat16_4 = u_xlat24 * u_xlat16_4;
    u_xlat2.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat25 = u_xlat24 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat25 = u_xlat24 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat25) + 2.0;
    u_xlat25 = u_xlat25 * u_xlat26;
    u_xlat26 = u_xlat25 * _HeigtFogColDelta3.w;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat24>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat24>=u_xlat3.x;
#endif
    u_xlat25 = (u_xlatb3) ? u_xlat26 : u_xlat25;
    u_xlat25 = log2(u_xlat25);
    u_xlat25 = u_xlat25 * _Mihoyo_FogColor3.w;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = min(u_xlat25, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat26 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat19 = u_xlat26 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4 = (u_xlatb26) ? u_xlat19 : 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat26 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat26) + 2.0;
    u_xlat16_12 = u_xlat26 * u_xlat16_12;
    u_xlat26 = u_xlat16_12 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_4 = u_xlat26 * u_xlat16_4;
    u_xlat26 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat19 = (-u_xlat26) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat19);
    u_xlat4.w = u_xlat25 * u_xlat19;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat26) + u_xlat2.xyz;
    u_xlat25 = u_xlat1.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat25) + 2.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat25 = u_xlat24 + (-_HeigtFogRamp2.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat25 = u_xlat24 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat25) + 2.0;
    u_xlat25 = u_xlat25 * u_xlat26;
    u_xlat26 = u_xlat25 * _HeigtFogColDelta2.w;
    u_xlat25 = (u_xlatb3) ? u_xlat26 : u_xlat25;
    u_xlat25 = log2(u_xlat25);
    u_xlat25 = u_xlat25 * _Mihoyo_FogColor2.w;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = min(u_xlat25, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat26 = u_xlat11 * -1.44269502;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat26 = u_xlat26 / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat26 : 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat24 = u_xlat24 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat26 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14 = (-u_xlat24) + 2.0;
    u_xlat16_14 = u_xlat24 * u_xlat16_14;
    u_xlat24 = u_xlat16_14 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat24 = u_xlat24 + 1.0;
    u_xlat16_6 = u_xlat24 * u_xlat16_6;
    u_xlat24 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat26 = (-u_xlat24) + 1.0;
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.w = u_xlat25 * u_xlat26;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat24) + u_xlat2.xyz;
    u_xlat2 = (-u_xlat3) + u_xlat4;
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat3;
    vs_COLOR1 = u_xlat2;
    u_xlat2 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat2.xy, 0.0).x;
    u_xlat25 = textureLod(_DisplacementMap, u_xlat2.zw, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat2.z = u_xlat25 * _MaxHeight + (-u_xlat24);
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(-0.00999999978);
    u_xlat24 = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat3.xy, 0.0).x;
    u_xlat25 = textureLod(_DisplacementMap, u_xlat3.zw, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat3.y = u_xlat25 * _MaxHeight + (-u_xlat24);
    u_xlat3.x = -0.00999999978;
    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.y = u_xlat24 * u_xlat3.y;
    u_xlat3.xz = vec2(u_xlat24) * vec2(0.0, -0.00999999978);
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = u_xlat2.y;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.yxz;
    u_xlat7.xyz = u_xlat2.xyz * u_xlat5.yxz;
    u_xlat7.xyz = u_xlat2.zxy * u_xlat5.xzy + (-u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat3.y = u_xlat7.x;
    u_xlat3.x = u_xlat5.z;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat5.z = u_xlat2.x;
    u_xlat2.x = u_xlat5.y;
    u_xlat2.y = u_xlat7.y;
    u_xlat5.y = u_xlat7.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat24 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * in_NORMAL0.zxy;
    u_xlat24 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * in_TANGENT0.yzx;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat3.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(in_TANGENT0.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(in_NORMAL0.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_0.x = texture(_SandShineTex, u_xlat0.xy).x;
    u_xlat0.xyz = u_xlat10_0.xxx * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SecondTexIntensity) + u_xlat16_3.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat16;
vec2 u_xlat17;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat8.x = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat8.x = u_xlat8.x * _MaxHeight;
    u_xlat16 = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat1.x = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat2.y = u_xlat16 * _MaxHeight + (-u_xlat8.x);
    u_xlat2.x = -0.00999999978;
    u_xlat8.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xz = u_xlat8.xx * vec2(0.0, -0.00999999978);
    u_xlat3.y = u_xlat8.x * u_xlat2.y;
    u_xlat1.z = u_xlat1.x * _MaxHeight + (-u_xlat24);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(-0.00999999978);
    u_xlat1.w = float(0.0);
    u_xlat8.x = dot(u_xlat1.yz, u_xlat1.yz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat8.xyz * u_xlat3.xyz;
    u_xlat8.xyz = u_xlat3.zxy * u_xlat8.yzx + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat8.xyz = u_xlat8.yzx * u_xlat1.xxx;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1 = vec4(u_xlat0) * u_xlat1;
    u_xlat1 = u_xlat1 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat2.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.zxy * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat0 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat5.xyz = vec3(u_xlat0) * in_NORMAL0.zxy;
    u_xlat0 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat6.xyz = vec3(u_xlat0) * in_TANGENT0.yzx;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.zxy * u_xlat6.yzx + (-u_xlat7.xyz);
    u_xlat5.xyz = u_xlat5.xyz * in_TANGENT0.www;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat6.xyz;
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat6.y = dot(u_xlat5.xyz, (-u_xlat1.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat0 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD5.xyz = vec3(u_xlat0) * u_xlat6.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat5.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * (-u_xlat17.xy);
        u_xlat0 = u_xlat17.x * _FogTune;
        u_xlat0 = u_xlat0 * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat0 = (-u_xlat0) + 1.0;
        u_xlat0 = u_xlat0 * _FogEffectLimit;
        u_xlat17.x = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat17.x);
        u_xlat5.w = min(u_xlat0, _FogEffectLimit);
        u_xlat0 = u_xlat17.y * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat0) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * vec2(500.0, 1000.0);
        u_xlat0 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.100000001);
        u_xlat17.xy = u_xlat17.yx / vec2(u_xlat0);
        u_xlat0 = u_xlat17.y * _FogEffectLimit;
        u_xlat25 = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat25);
        u_xlat2.w = min(u_xlat0, _FogEffectLimit);
        u_xlat17.x = u_xlat17.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat17.x = min(max(u_xlat17.x, 0.0), 1.0);
#else
        u_xlat17.x = clamp(u_xlat17.x, 0.0, 1.0);
#endif
        u_xlat0 = (-u_xlat17.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat0) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat2.x = u_xlat3.z;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat8.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat2.x = u_xlat3.x;
    u_xlat2.y = u_xlat4.y;
    u_xlat2.z = u_xlat8.y;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat8.x = u_xlat3.y;
    u_xlat8.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat8.xyz;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat4.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_18 = texture(_SandShineTex, u_xlat4.xy).x;
    u_xlat4.xyz = vec3(u_xlat10_18) * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SecondTexIntensity) + u_xlat16_0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat16;
vec2 u_xlat17;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat8.x = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat8.x = u_xlat8.x * _MaxHeight;
    u_xlat16 = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat1.x = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat2.y = u_xlat16 * _MaxHeight + (-u_xlat8.x);
    u_xlat2.x = -0.00999999978;
    u_xlat8.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xz = u_xlat8.xx * vec2(0.0, -0.00999999978);
    u_xlat3.y = u_xlat8.x * u_xlat2.y;
    u_xlat1.z = u_xlat1.x * _MaxHeight + (-u_xlat24);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(-0.00999999978);
    u_xlat1.w = float(0.0);
    u_xlat8.x = dot(u_xlat1.yz, u_xlat1.yz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat8.xyz * u_xlat3.xyz;
    u_xlat8.xyz = u_xlat3.zxy * u_xlat8.yzx + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat8.xyz = u_xlat8.yzx * u_xlat1.xxx;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1 = vec4(u_xlat0) * u_xlat1;
    u_xlat1 = u_xlat1 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat2.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.zxy * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat0 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat5.xyz = vec3(u_xlat0) * in_NORMAL0.zxy;
    u_xlat0 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat6.xyz = vec3(u_xlat0) * in_TANGENT0.yzx;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.zxy * u_xlat6.yzx + (-u_xlat7.xyz);
    u_xlat5.xyz = u_xlat5.xyz * in_TANGENT0.www;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat6.xyz;
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat6.y = dot(u_xlat5.xyz, (-u_xlat1.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat0 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD5.xyz = vec3(u_xlat0) * u_xlat6.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat5.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * (-u_xlat17.xy);
        u_xlat0 = u_xlat17.x * _FogTune;
        u_xlat0 = u_xlat0 * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat0 = (-u_xlat0) + 1.0;
        u_xlat0 = u_xlat0 * _FogEffectLimit;
        u_xlat17.x = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat17.x);
        u_xlat5.w = min(u_xlat0, _FogEffectLimit);
        u_xlat0 = u_xlat17.y * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat0) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * vec2(500.0, 1000.0);
        u_xlat0 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.100000001);
        u_xlat17.xy = u_xlat17.yx / vec2(u_xlat0);
        u_xlat0 = u_xlat17.y * _FogEffectLimit;
        u_xlat25 = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat25);
        u_xlat2.w = min(u_xlat0, _FogEffectLimit);
        u_xlat17.x = u_xlat17.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat17.x = min(max(u_xlat17.x, 0.0), 1.0);
#else
        u_xlat17.x = clamp(u_xlat17.x, 0.0, 1.0);
#endif
        u_xlat0 = (-u_xlat17.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat0) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat2.x = u_xlat3.z;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat8.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat2.x = u_xlat3.x;
    u_xlat2.y = u_xlat4.y;
    u_xlat2.z = u_xlat8.y;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat8.x = u_xlat3.y;
    u_xlat8.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat8.xyz;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat4.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_18 = texture(_SandShineTex, u_xlat4.xy).x;
    u_xlat4.xyz = vec3(u_xlat10_18) * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SecondTexIntensity) + u_xlat16_0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat16;
vec2 u_xlat17;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat8.x = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat8.x = u_xlat8.x * _MaxHeight;
    u_xlat16 = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat1.x = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat2.y = u_xlat16 * _MaxHeight + (-u_xlat8.x);
    u_xlat2.x = -0.00999999978;
    u_xlat8.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xz = u_xlat8.xx * vec2(0.0, -0.00999999978);
    u_xlat3.y = u_xlat8.x * u_xlat2.y;
    u_xlat1.z = u_xlat1.x * _MaxHeight + (-u_xlat24);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(-0.00999999978);
    u_xlat1.w = float(0.0);
    u_xlat8.x = dot(u_xlat1.yz, u_xlat1.yz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat8.xyz * u_xlat3.xyz;
    u_xlat8.xyz = u_xlat3.zxy * u_xlat8.yzx + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat8.xyz = u_xlat8.yzx * u_xlat1.xxx;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1 = vec4(u_xlat0) * u_xlat1;
    u_xlat1 = u_xlat1 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat2.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.zxy * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat0 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat5.xyz = vec3(u_xlat0) * in_NORMAL0.zxy;
    u_xlat0 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat6.xyz = vec3(u_xlat0) * in_TANGENT0.yzx;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.zxy * u_xlat6.yzx + (-u_xlat7.xyz);
    u_xlat5.xyz = u_xlat5.xyz * in_TANGENT0.www;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat6.xyz;
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat6.y = dot(u_xlat5.xyz, (-u_xlat1.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat0 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD5.xyz = vec3(u_xlat0) * u_xlat6.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat5.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * (-u_xlat17.xy);
        u_xlat0 = u_xlat17.x * _FogTune;
        u_xlat0 = u_xlat0 * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat0 = (-u_xlat0) + 1.0;
        u_xlat0 = u_xlat0 * _FogEffectLimit;
        u_xlat17.x = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat17.x);
        u_xlat5.w = min(u_xlat0, _FogEffectLimit);
        u_xlat0 = u_xlat17.y * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat0) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * vec2(500.0, 1000.0);
        u_xlat0 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.100000001);
        u_xlat17.xy = u_xlat17.yx / vec2(u_xlat0);
        u_xlat0 = u_xlat17.y * _FogEffectLimit;
        u_xlat25 = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat25);
        u_xlat2.w = min(u_xlat0, _FogEffectLimit);
        u_xlat17.x = u_xlat17.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat17.x = min(max(u_xlat17.x, 0.0), 1.0);
#else
        u_xlat17.x = clamp(u_xlat17.x, 0.0, 1.0);
#endif
        u_xlat0 = (-u_xlat17.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat0) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat2.x = u_xlat3.z;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat8.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat2.x = u_xlat3.x;
    u_xlat2.y = u_xlat4.y;
    u_xlat2.z = u_xlat8.y;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat8.x = u_xlat3.y;
    u_xlat8.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat8.xyz;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat4.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_18 = texture(_SandShineTex, u_xlat4.xy).x;
    u_xlat4.xyz = vec3(u_xlat10_18) * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SecondTexIntensity) + u_xlat16_0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 _WorldSpaceLightPos0;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat16;
vec2 u_xlat17;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat8.x = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat8.x = u_xlat8.x * _MaxHeight;
    u_xlat16 = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat1.x = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat2.y = u_xlat16 * _MaxHeight + (-u_xlat8.x);
    u_xlat2.x = -0.00999999978;
    u_xlat8.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xz = u_xlat8.xx * vec2(0.0, -0.00999999978);
    u_xlat3.y = u_xlat8.x * u_xlat2.y;
    u_xlat1.z = u_xlat1.x * _MaxHeight + (-u_xlat24);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(-0.00999999978);
    u_xlat1.w = float(0.0);
    u_xlat8.x = dot(u_xlat1.yz, u_xlat1.yz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat8.xyz * u_xlat3.xyz;
    u_xlat8.xyz = u_xlat3.zxy * u_xlat8.yzx + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat8.xyz = u_xlat8.yzx * u_xlat1.xxx;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1 = vec4(u_xlat0) * u_xlat1;
    u_xlat1 = u_xlat1 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat2.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.zxy * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat0 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat5.xyz = vec3(u_xlat0) * in_NORMAL0.zxy;
    u_xlat0 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat6.xyz = vec3(u_xlat0) * in_TANGENT0.yzx;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.zxy * u_xlat6.yzx + (-u_xlat7.xyz);
    u_xlat5.xyz = u_xlat5.xyz * in_TANGENT0.www;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat6.xyz;
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat6.y = dot(u_xlat5.xyz, (-u_xlat1.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat0 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD5.xyz = vec3(u_xlat0) * u_xlat6.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat5.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * (-u_xlat17.xy);
        u_xlat0 = u_xlat17.x * _FogTune;
        u_xlat0 = u_xlat0 * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat0 = (-u_xlat0) + 1.0;
        u_xlat0 = u_xlat0 * _FogEffectLimit;
        u_xlat17.x = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat17.x);
        u_xlat5.w = min(u_xlat0, _FogEffectLimit);
        u_xlat0 = u_xlat17.y * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat0) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * vec2(500.0, 1000.0);
        u_xlat0 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.100000001);
        u_xlat17.xy = u_xlat17.yx / vec2(u_xlat0);
        u_xlat0 = u_xlat17.y * _FogEffectLimit;
        u_xlat25 = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat25);
        u_xlat2.w = min(u_xlat0, _FogEffectLimit);
        u_xlat17.x = u_xlat17.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat17.x = min(max(u_xlat17.x, 0.0), 1.0);
#else
        u_xlat17.x = clamp(u_xlat17.x, 0.0, 1.0);
#endif
        u_xlat0 = (-u_xlat17.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat0) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat2.x = u_xlat3.z;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat8.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat2.x = u_xlat3.x;
    u_xlat2.y = u_xlat4.y;
    u_xlat2.z = u_xlat8.y;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat8.x = u_xlat3.y;
    u_xlat8.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat8.xyz;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat4.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_18 = texture(_SandShineTex, u_xlat4.xy).x;
    u_xlat4.xyz = vec3(u_xlat10_18) * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SecondTexIntensity) + u_xlat16_0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 _WorldSpaceLightPos0;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat16;
vec2 u_xlat17;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat8.x = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat8.x = u_xlat8.x * _MaxHeight;
    u_xlat16 = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat1.x = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat2.y = u_xlat16 * _MaxHeight + (-u_xlat8.x);
    u_xlat2.x = -0.00999999978;
    u_xlat8.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xz = u_xlat8.xx * vec2(0.0, -0.00999999978);
    u_xlat3.y = u_xlat8.x * u_xlat2.y;
    u_xlat1.z = u_xlat1.x * _MaxHeight + (-u_xlat24);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(-0.00999999978);
    u_xlat1.w = float(0.0);
    u_xlat8.x = dot(u_xlat1.yz, u_xlat1.yz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat8.xyz * u_xlat3.xyz;
    u_xlat8.xyz = u_xlat3.zxy * u_xlat8.yzx + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat8.xyz = u_xlat8.yzx * u_xlat1.xxx;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1 = vec4(u_xlat0) * u_xlat1;
    u_xlat1 = u_xlat1 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat2.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.zxy * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat0 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat5.xyz = vec3(u_xlat0) * in_NORMAL0.zxy;
    u_xlat0 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat6.xyz = vec3(u_xlat0) * in_TANGENT0.yzx;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.zxy * u_xlat6.yzx + (-u_xlat7.xyz);
    u_xlat5.xyz = u_xlat5.xyz * in_TANGENT0.www;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat6.xyz;
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat6.y = dot(u_xlat5.xyz, (-u_xlat1.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat0 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD5.xyz = vec3(u_xlat0) * u_xlat6.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat5.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * (-u_xlat17.xy);
        u_xlat0 = u_xlat17.x * _FogTune;
        u_xlat0 = u_xlat0 * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat0 = (-u_xlat0) + 1.0;
        u_xlat0 = u_xlat0 * _FogEffectLimit;
        u_xlat17.x = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat17.x);
        u_xlat5.w = min(u_xlat0, _FogEffectLimit);
        u_xlat0 = u_xlat17.y * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat0) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * vec2(500.0, 1000.0);
        u_xlat0 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.100000001);
        u_xlat17.xy = u_xlat17.yx / vec2(u_xlat0);
        u_xlat0 = u_xlat17.y * _FogEffectLimit;
        u_xlat25 = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat25);
        u_xlat2.w = min(u_xlat0, _FogEffectLimit);
        u_xlat17.x = u_xlat17.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat17.x = min(max(u_xlat17.x, 0.0), 1.0);
#else
        u_xlat17.x = clamp(u_xlat17.x, 0.0, 1.0);
#endif
        u_xlat0 = (-u_xlat17.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat0) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat2.x = u_xlat3.z;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat8.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat2.x = u_xlat3.x;
    u_xlat2.y = u_xlat4.y;
    u_xlat2.z = u_xlat8.y;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat8.x = u_xlat3.y;
    u_xlat8.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat8.xyz;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat4.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_18 = texture(_SandShineTex, u_xlat4.xy).x;
    u_xlat4.xyz = vec3(u_xlat10_18) * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SecondTexIntensity) + u_xlat16_0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 _WorldSpaceLightPos0;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat16;
vec2 u_xlat17;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat8.x = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat8.x = u_xlat8.x * _MaxHeight;
    u_xlat16 = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat1 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat1.xy, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat1.x = textureLod(_DisplacementMap, u_xlat1.zw, 0.0).x;
    u_xlat2.y = u_xlat16 * _MaxHeight + (-u_xlat8.x);
    u_xlat2.x = -0.00999999978;
    u_xlat8.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xz = u_xlat8.xx * vec2(0.0, -0.00999999978);
    u_xlat3.y = u_xlat8.x * u_xlat2.y;
    u_xlat1.z = u_xlat1.x * _MaxHeight + (-u_xlat24);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(-0.00999999978);
    u_xlat1.w = float(0.0);
    u_xlat8.x = dot(u_xlat1.yz, u_xlat1.yz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat8.xyz * u_xlat3.xyz;
    u_xlat8.xyz = u_xlat3.zxy * u_xlat8.yzx + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat8.xyz = u_xlat8.yzx * u_xlat1.xxx;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1 = vec4(u_xlat0) * u_xlat1;
    u_xlat1 = u_xlat1 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat2.xyz;
    vs_TEXCOORD7.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.zxy * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat8.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * in_TANGENT0.www;
    u_xlat0 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat5.xyz = vec3(u_xlat0) * in_NORMAL0.zxy;
    u_xlat0 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat6.xyz = vec3(u_xlat0) * in_TANGENT0.yzx;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.zxy * u_xlat6.yzx + (-u_xlat7.xyz);
    u_xlat5.xyz = u_xlat5.xyz * in_TANGENT0.www;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat6.xyz;
    u_xlat6.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat6.y = dot(u_xlat5.xyz, (-u_xlat1.xyz));
    u_xlat6.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat0 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD5.xyz = vec3(u_xlat0) * u_xlat6.xyz;
    u_xlat1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb0 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb0){
        u_xlat5.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * (-u_xlat17.xy);
        u_xlat0 = u_xlat17.x * _FogTune;
        u_xlat0 = u_xlat0 * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat0 = (-u_xlat0) + 1.0;
        u_xlat0 = u_xlat0 * _FogEffectLimit;
        u_xlat17.x = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat17.x);
        u_xlat5.w = min(u_xlat0, _FogEffectLimit);
        u_xlat0 = u_xlat17.y * 1.44269502;
        u_xlat0 = exp2(u_xlat0);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat0) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlat17.xy = vec2(u_xlat0) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat17.xy = u_xlat17.xy * vec2(500.0, 1000.0);
        u_xlat0 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat0 = max(u_xlat0, 0.100000001);
        u_xlat17.xy = u_xlat17.yx / vec2(u_xlat0);
        u_xlat0 = u_xlat17.y * _FogEffectLimit;
        u_xlat25 = _FogEffectStart * _FogTune;
        u_xlat0 = max(u_xlat0, u_xlat25);
        u_xlat2.w = min(u_xlat0, _FogEffectLimit);
        u_xlat17.x = u_xlat17.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat17.x = min(max(u_xlat17.x, 0.0), 1.0);
#else
        u_xlat17.x = clamp(u_xlat17.x, 0.0, 1.0);
#endif
        u_xlat0 = (-u_xlat17.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat0) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat2.x = u_xlat3.z;
    u_xlat2.y = u_xlat4.x;
    u_xlat2.z = u_xlat8.x;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat2.x = u_xlat3.x;
    u_xlat2.y = u_xlat4.y;
    u_xlat2.z = u_xlat8.y;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat8.x = u_xlat3.y;
    u_xlat8.y = u_xlat4.z;
    vs_TEXCOORD4.xyz = u_xlat8.xyz;
    vs_TEXCOORD6.xy = u_xlat1.xy;
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat4.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_18 = texture(_SandShineTex, u_xlat4.xy).x;
    u_xlat4.xyz = vec3(u_xlat10_18) * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SecondTexIntensity) + u_xlat16_0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
void main()
{
    u_xlat0.x = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat21 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat21) + 2.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat2.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat23 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(u_xlat21>=u_xlat23);
#else
    u_xlatb23 = u_xlat21>=u_xlat23;
#endif
    u_xlat3.x = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat3.x) + 2.0;
    u_xlat3.x = u_xlat10 * u_xlat3.x;
    u_xlat10 = u_xlat3.x * _HeigtFogColDelta.w;
    u_xlat23 = (u_xlatb23) ? u_xlat10 : u_xlat3.x;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat3.x = u_xlat22 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_4 = (u_xlatb22) ? u_xlat3.x : 1.0;
    u_xlat22 = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat22 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat22 = (-u_xlat21) + 1.0;
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.w = u_xlat22 * u_xlat23;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat21 = textureLod(_DisplacementMap, u_xlat2.xy, 0.0).x;
    u_xlat22 = textureLod(_DisplacementMap, u_xlat2.zw, 0.0).x;
    u_xlat21 = u_xlat21 * _MaxHeight;
    u_xlat2.z = u_xlat22 * _MaxHeight + (-u_xlat21);
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(-0.00999999978);
    u_xlat21 = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat21 = textureLod(_DisplacementMap, u_xlat3.xy, 0.0).x;
    u_xlat22 = textureLod(_DisplacementMap, u_xlat3.zw, 0.0).x;
    u_xlat21 = u_xlat21 * _MaxHeight;
    u_xlat3.y = u_xlat22 * _MaxHeight + (-u_xlat21);
    u_xlat3.x = -0.00999999978;
    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.y = u_xlat21 * u_xlat3.y;
    u_xlat3.xz = vec2(u_xlat21) * vec2(0.0, -0.00999999978);
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.z = u_xlat2.y;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.yxz;
    u_xlat6.xyz = u_xlat2.xyz * u_xlat5.yxz;
    u_xlat6.xyz = u_xlat2.zxy * u_xlat5.xzy + (-u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz * in_TANGENT0.www;
    u_xlat3.y = u_xlat6.x;
    u_xlat3.x = u_xlat5.z;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat5.z = u_xlat2.x;
    u_xlat2.x = u_xlat5.y;
    u_xlat2.y = u_xlat6.y;
    u_xlat5.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat3.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(in_TANGENT0.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(in_NORMAL0.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat4.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_18 = texture(_SandShineTex, u_xlat4.xy).x;
    u_xlat4.xyz = vec3(u_xlat10_18) * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SecondTexIntensity) + u_xlat16_0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
void main()
{
    u_xlat0.x = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat21 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat21) + 2.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat2.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat23 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(u_xlat21>=u_xlat23);
#else
    u_xlatb23 = u_xlat21>=u_xlat23;
#endif
    u_xlat3.x = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat3.x) + 2.0;
    u_xlat3.x = u_xlat10 * u_xlat3.x;
    u_xlat10 = u_xlat3.x * _HeigtFogColDelta.w;
    u_xlat23 = (u_xlatb23) ? u_xlat10 : u_xlat3.x;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat3.x = u_xlat22 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_4 = (u_xlatb22) ? u_xlat3.x : 1.0;
    u_xlat22 = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat22 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat22 = (-u_xlat21) + 1.0;
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.w = u_xlat22 * u_xlat23;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat21 = textureLod(_DisplacementMap, u_xlat2.xy, 0.0).x;
    u_xlat22 = textureLod(_DisplacementMap, u_xlat2.zw, 0.0).x;
    u_xlat21 = u_xlat21 * _MaxHeight;
    u_xlat2.z = u_xlat22 * _MaxHeight + (-u_xlat21);
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(-0.00999999978);
    u_xlat21 = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat21 = textureLod(_DisplacementMap, u_xlat3.xy, 0.0).x;
    u_xlat22 = textureLod(_DisplacementMap, u_xlat3.zw, 0.0).x;
    u_xlat21 = u_xlat21 * _MaxHeight;
    u_xlat3.y = u_xlat22 * _MaxHeight + (-u_xlat21);
    u_xlat3.x = -0.00999999978;
    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.y = u_xlat21 * u_xlat3.y;
    u_xlat3.xz = vec2(u_xlat21) * vec2(0.0, -0.00999999978);
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.z = u_xlat2.y;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.yxz;
    u_xlat6.xyz = u_xlat2.xyz * u_xlat5.yxz;
    u_xlat6.xyz = u_xlat2.zxy * u_xlat5.xzy + (-u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz * in_TANGENT0.www;
    u_xlat3.y = u_xlat6.x;
    u_xlat3.x = u_xlat5.z;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat5.z = u_xlat2.x;
    u_xlat2.x = u_xlat5.y;
    u_xlat2.y = u_xlat6.y;
    u_xlat5.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat3.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(in_TANGENT0.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(in_NORMAL0.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat4.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_18 = texture(_SandShineTex, u_xlat4.xy).x;
    u_xlat4.xyz = vec3(u_xlat10_18) * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SecondTexIntensity) + u_xlat16_0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
void main()
{
    u_xlat0.x = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat21 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat21) + 2.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat2.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat23 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(u_xlat21>=u_xlat23);
#else
    u_xlatb23 = u_xlat21>=u_xlat23;
#endif
    u_xlat3.x = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat3.x) + 2.0;
    u_xlat3.x = u_xlat10 * u_xlat3.x;
    u_xlat10 = u_xlat3.x * _HeigtFogColDelta.w;
    u_xlat23 = (u_xlatb23) ? u_xlat10 : u_xlat3.x;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat3.x = u_xlat22 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_4 = (u_xlatb22) ? u_xlat3.x : 1.0;
    u_xlat22 = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat22 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat22 = (-u_xlat21) + 1.0;
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.w = u_xlat22 * u_xlat23;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat21 = textureLod(_DisplacementMap, u_xlat2.xy, 0.0).x;
    u_xlat22 = textureLod(_DisplacementMap, u_xlat2.zw, 0.0).x;
    u_xlat21 = u_xlat21 * _MaxHeight;
    u_xlat2.z = u_xlat22 * _MaxHeight + (-u_xlat21);
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(-0.00999999978);
    u_xlat21 = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat21 = textureLod(_DisplacementMap, u_xlat3.xy, 0.0).x;
    u_xlat22 = textureLod(_DisplacementMap, u_xlat3.zw, 0.0).x;
    u_xlat21 = u_xlat21 * _MaxHeight;
    u_xlat3.y = u_xlat22 * _MaxHeight + (-u_xlat21);
    u_xlat3.x = -0.00999999978;
    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.y = u_xlat21 * u_xlat3.y;
    u_xlat3.xz = vec2(u_xlat21) * vec2(0.0, -0.00999999978);
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.z = u_xlat2.y;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.yxz;
    u_xlat6.xyz = u_xlat2.xyz * u_xlat5.yxz;
    u_xlat6.xyz = u_xlat2.zxy * u_xlat5.xzy + (-u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz * in_TANGENT0.www;
    u_xlat3.y = u_xlat6.x;
    u_xlat3.x = u_xlat5.z;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat5.z = u_xlat2.x;
    u_xlat2.x = u_xlat5.y;
    u_xlat2.y = u_xlat6.y;
    u_xlat5.y = u_xlat6.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat3.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(in_TANGENT0.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(in_NORMAL0.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat4.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_18 = texture(_SandShineTex, u_xlat4.xy).x;
    u_xlat4.xyz = vec3(u_xlat10_18) * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SecondTexIntensity) + u_xlat16_0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat11;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
float u_xlat19;
float u_xlat24;
float u_xlat25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.x = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat24 = u_xlat1.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat24) + 2.0;
    u_xlat16_4 = u_xlat24 * u_xlat16_4;
    u_xlat2.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat25 = u_xlat24 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat25 = u_xlat24 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat25) + 2.0;
    u_xlat25 = u_xlat25 * u_xlat26;
    u_xlat26 = u_xlat25 * _HeigtFogColDelta3.w;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat24>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat24>=u_xlat3.x;
#endif
    u_xlat25 = (u_xlatb3) ? u_xlat26 : u_xlat25;
    u_xlat25 = log2(u_xlat25);
    u_xlat25 = u_xlat25 * _Mihoyo_FogColor3.w;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = min(u_xlat25, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat26 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat19 = u_xlat26 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4 = (u_xlatb26) ? u_xlat19 : 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat26 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat26) + 2.0;
    u_xlat16_12 = u_xlat26 * u_xlat16_12;
    u_xlat26 = u_xlat16_12 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_4 = u_xlat26 * u_xlat16_4;
    u_xlat26 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat19 = (-u_xlat26) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat19);
    u_xlat4.w = u_xlat25 * u_xlat19;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat26) + u_xlat2.xyz;
    u_xlat25 = u_xlat1.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat25) + 2.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat25 = u_xlat24 + (-_HeigtFogRamp2.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat25 = u_xlat24 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat25) + 2.0;
    u_xlat25 = u_xlat25 * u_xlat26;
    u_xlat26 = u_xlat25 * _HeigtFogColDelta2.w;
    u_xlat25 = (u_xlatb3) ? u_xlat26 : u_xlat25;
    u_xlat25 = log2(u_xlat25);
    u_xlat25 = u_xlat25 * _Mihoyo_FogColor2.w;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = min(u_xlat25, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat26 = u_xlat11 * -1.44269502;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat26 = u_xlat26 / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat26 : 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat24 = u_xlat24 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat26 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14 = (-u_xlat24) + 2.0;
    u_xlat16_14 = u_xlat24 * u_xlat16_14;
    u_xlat24 = u_xlat16_14 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat24 = u_xlat24 + 1.0;
    u_xlat16_6 = u_xlat24 * u_xlat16_6;
    u_xlat24 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat26 = (-u_xlat24) + 1.0;
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.w = u_xlat25 * u_xlat26;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat24) + u_xlat2.xyz;
    u_xlat2 = (-u_xlat3) + u_xlat4;
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat3;
    vs_COLOR1 = u_xlat2;
    u_xlat2 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat2.xy, 0.0).x;
    u_xlat25 = textureLod(_DisplacementMap, u_xlat2.zw, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat2.z = u_xlat25 * _MaxHeight + (-u_xlat24);
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(-0.00999999978);
    u_xlat24 = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat3.xy, 0.0).x;
    u_xlat25 = textureLod(_DisplacementMap, u_xlat3.zw, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat3.y = u_xlat25 * _MaxHeight + (-u_xlat24);
    u_xlat3.x = -0.00999999978;
    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.y = u_xlat24 * u_xlat3.y;
    u_xlat3.xz = vec2(u_xlat24) * vec2(0.0, -0.00999999978);
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = u_xlat2.y;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.yxz;
    u_xlat7.xyz = u_xlat2.xyz * u_xlat5.yxz;
    u_xlat7.xyz = u_xlat2.zxy * u_xlat5.xzy + (-u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat3.y = u_xlat7.x;
    u_xlat3.x = u_xlat5.z;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat5.z = u_xlat2.x;
    u_xlat2.x = u_xlat5.y;
    u_xlat2.y = u_xlat7.y;
    u_xlat5.y = u_xlat7.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat24 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * in_NORMAL0.zxy;
    u_xlat24 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * in_TANGENT0.yzx;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat3.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(in_TANGENT0.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(in_NORMAL0.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat4.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_18 = texture(_SandShineTex, u_xlat4.xy).x;
    u_xlat4.xyz = vec3(u_xlat10_18) * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SecondTexIntensity) + u_xlat16_0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat11;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
float u_xlat19;
float u_xlat24;
float u_xlat25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.x = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat24 = u_xlat1.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat24) + 2.0;
    u_xlat16_4 = u_xlat24 * u_xlat16_4;
    u_xlat2.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat25 = u_xlat24 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat25 = u_xlat24 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat25) + 2.0;
    u_xlat25 = u_xlat25 * u_xlat26;
    u_xlat26 = u_xlat25 * _HeigtFogColDelta3.w;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat24>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat24>=u_xlat3.x;
#endif
    u_xlat25 = (u_xlatb3) ? u_xlat26 : u_xlat25;
    u_xlat25 = log2(u_xlat25);
    u_xlat25 = u_xlat25 * _Mihoyo_FogColor3.w;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = min(u_xlat25, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat26 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat19 = u_xlat26 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4 = (u_xlatb26) ? u_xlat19 : 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat26 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat26) + 2.0;
    u_xlat16_12 = u_xlat26 * u_xlat16_12;
    u_xlat26 = u_xlat16_12 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_4 = u_xlat26 * u_xlat16_4;
    u_xlat26 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat19 = (-u_xlat26) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat19);
    u_xlat4.w = u_xlat25 * u_xlat19;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat26) + u_xlat2.xyz;
    u_xlat25 = u_xlat1.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat25) + 2.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat25 = u_xlat24 + (-_HeigtFogRamp2.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat25 = u_xlat24 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat25) + 2.0;
    u_xlat25 = u_xlat25 * u_xlat26;
    u_xlat26 = u_xlat25 * _HeigtFogColDelta2.w;
    u_xlat25 = (u_xlatb3) ? u_xlat26 : u_xlat25;
    u_xlat25 = log2(u_xlat25);
    u_xlat25 = u_xlat25 * _Mihoyo_FogColor2.w;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = min(u_xlat25, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat26 = u_xlat11 * -1.44269502;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat26 = u_xlat26 / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat26 : 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat24 = u_xlat24 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat26 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14 = (-u_xlat24) + 2.0;
    u_xlat16_14 = u_xlat24 * u_xlat16_14;
    u_xlat24 = u_xlat16_14 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat24 = u_xlat24 + 1.0;
    u_xlat16_6 = u_xlat24 * u_xlat16_6;
    u_xlat24 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat26 = (-u_xlat24) + 1.0;
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.w = u_xlat25 * u_xlat26;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat24) + u_xlat2.xyz;
    u_xlat2 = (-u_xlat3) + u_xlat4;
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat3;
    vs_COLOR1 = u_xlat2;
    u_xlat2 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat2.xy, 0.0).x;
    u_xlat25 = textureLod(_DisplacementMap, u_xlat2.zw, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat2.z = u_xlat25 * _MaxHeight + (-u_xlat24);
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(-0.00999999978);
    u_xlat24 = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat3.xy, 0.0).x;
    u_xlat25 = textureLod(_DisplacementMap, u_xlat3.zw, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat3.y = u_xlat25 * _MaxHeight + (-u_xlat24);
    u_xlat3.x = -0.00999999978;
    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.y = u_xlat24 * u_xlat3.y;
    u_xlat3.xz = vec2(u_xlat24) * vec2(0.0, -0.00999999978);
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = u_xlat2.y;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.yxz;
    u_xlat7.xyz = u_xlat2.xyz * u_xlat5.yxz;
    u_xlat7.xyz = u_xlat2.zxy * u_xlat5.xzy + (-u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat3.y = u_xlat7.x;
    u_xlat3.x = u_xlat5.z;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat5.z = u_xlat2.x;
    u_xlat2.x = u_xlat5.y;
    u_xlat2.y = u_xlat7.y;
    u_xlat5.y = u_xlat7.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat24 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * in_NORMAL0.zxy;
    u_xlat24 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * in_TANGENT0.yzx;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat3.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(in_TANGENT0.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(in_NORMAL0.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat4.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_18 = texture(_SandShineTex, u_xlat4.xy).x;
    u_xlat4.xyz = vec3(u_xlat10_18) * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SecondTexIntensity) + u_xlat16_0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _MaxHeight;
uniform lowp sampler2D _DisplacementMap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
out highp vec4 vs_TEXCOORD11;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat11;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
float u_xlat19;
float u_xlat24;
float u_xlat25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.x = textureLod(_DisplacementMap, in_TEXCOORD1.xy, 0.0).x;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(_MaxHeight) + in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat24 = u_xlat1.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat24) + 2.0;
    u_xlat16_4 = u_xlat24 * u_xlat16_4;
    u_xlat2.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat25 = u_xlat24 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat25 = u_xlat24 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat25) + 2.0;
    u_xlat25 = u_xlat25 * u_xlat26;
    u_xlat26 = u_xlat25 * _HeigtFogColDelta3.w;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat24>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat24>=u_xlat3.x;
#endif
    u_xlat25 = (u_xlatb3) ? u_xlat26 : u_xlat25;
    u_xlat25 = log2(u_xlat25);
    u_xlat25 = u_xlat25 * _Mihoyo_FogColor3.w;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = min(u_xlat25, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat26 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat19 = u_xlat26 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4 = (u_xlatb26) ? u_xlat19 : 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat26 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat26) + 2.0;
    u_xlat16_12 = u_xlat26 * u_xlat16_12;
    u_xlat26 = u_xlat16_12 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_4 = u_xlat26 * u_xlat16_4;
    u_xlat26 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat19 = (-u_xlat26) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat19);
    u_xlat4.w = u_xlat25 * u_xlat19;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat26) + u_xlat2.xyz;
    u_xlat25 = u_xlat1.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat25) + 2.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat25 = u_xlat24 + (-_HeigtFogRamp2.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat25 = u_xlat24 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat25) + 2.0;
    u_xlat25 = u_xlat25 * u_xlat26;
    u_xlat26 = u_xlat25 * _HeigtFogColDelta2.w;
    u_xlat25 = (u_xlatb3) ? u_xlat26 : u_xlat25;
    u_xlat25 = log2(u_xlat25);
    u_xlat25 = u_xlat25 * _Mihoyo_FogColor2.w;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = min(u_xlat25, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat26 = u_xlat11 * -1.44269502;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat26 = u_xlat26 / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat26 : 1.0;
    u_xlat26 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat24 = u_xlat24 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat26 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14 = (-u_xlat24) + 2.0;
    u_xlat16_14 = u_xlat24 * u_xlat16_14;
    u_xlat24 = u_xlat16_14 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat24 = u_xlat24 + 1.0;
    u_xlat16_6 = u_xlat24 * u_xlat16_6;
    u_xlat24 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat26 = (-u_xlat24) + 1.0;
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.w = u_xlat25 * u_xlat26;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat24) + u_xlat2.xyz;
    u_xlat2 = (-u_xlat3) + u_xlat4;
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat3;
    vs_COLOR1 = u_xlat2;
    u_xlat2 = in_TEXCOORD1.xyxy + vec4(0.0, 0.00999999978, -0.0, -0.00999999978);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat2.xy, 0.0).x;
    u_xlat25 = textureLod(_DisplacementMap, u_xlat2.zw, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat2.z = u_xlat25 * _MaxHeight + (-u_xlat24);
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(-0.00999999978);
    u_xlat24 = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3 = in_TEXCOORD1.xyxy + vec4(0.00999999978, 0.0, -0.00999999978, -0.0);
    u_xlat24 = textureLod(_DisplacementMap, u_xlat3.xy, 0.0).x;
    u_xlat25 = textureLod(_DisplacementMap, u_xlat3.zw, 0.0).x;
    u_xlat24 = u_xlat24 * _MaxHeight;
    u_xlat3.y = u_xlat25 * _MaxHeight + (-u_xlat24);
    u_xlat3.x = -0.00999999978;
    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.y = u_xlat24 * u_xlat3.y;
    u_xlat3.xz = vec2(u_xlat24) * vec2(0.0, -0.00999999978);
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat2.yzx + (-u_xlat5.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = u_xlat2.y;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.yxz;
    u_xlat7.xyz = u_xlat2.xyz * u_xlat5.yxz;
    u_xlat7.xyz = u_xlat2.zxy * u_xlat5.xzy + (-u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * in_TANGENT0.www;
    u_xlat3.y = u_xlat7.x;
    u_xlat3.x = u_xlat5.z;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat5.z = u_xlat2.x;
    u_xlat2.x = u_xlat5.y;
    u_xlat2.y = u_xlat7.y;
    u_xlat5.y = u_xlat7.z;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat24 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * in_NORMAL0.zxy;
    u_xlat24 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * in_TANGENT0.yzx;
    u_xlat5.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat5.xyz);
    u_xlat2.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat3.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat2.xyz, (-u_xlat0.xyz));
    u_xlat2.x = dot(in_TANGENT0.xyz, (-u_xlat0.xyz));
    u_xlat2.z = dot(in_NORMAL0.xyz, (-u_xlat0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD7.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD9.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD8.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD8.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD10 = in_TEXCOORD2;
    vs_TEXCOORD11 = in_TEXCOORD3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform 	float _fresnelBaseA;
uniform 	float _fresnelScaleA;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelColA;
uniform 	float _HeiLightGlass;
uniform 	float _HeiLightInvertIntensity;
uniform 	vec4 _HeiLightInvertColor;
uniform 	vec4 _SandShineTex_ST;
uniform 	vec2 _HeiLightTexSpeed;
uniform 	vec2 _HeiLightTexTilling;
uniform 	float _HeiLightPointStep;
uniform 	float _HeiLightPointStepWidth;
uniform 	vec2 _HeiLightPointTilling;
uniform 	vec4 _HeiLightPointColor;
uniform 	float _HeiLightPointIntensity;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec4 _LightPosition;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _MatcapMaskMap;
uniform lowp sampler2D _MatCap;
uniform lowp sampler2D _SandShineTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
in highp vec4 vs_TEXCOORD11;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat10;
vec2 u_xlat12;
float u_xlat14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_19 = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(u_xlat16_19) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat16_19 = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vec3(u_xlat16_19) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat2.xy * u_xlat12.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat12.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat10_18 = texture(_MatcapMaskMap, vs_TEXCOORD0.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_18) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD6.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_1.www) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat18 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD8.xyz;
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat5.xyz = vs_TEXCOORD9.xyz * vec3(u_xlat18) + _LightPosition.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat18 = (-u_xlat18) + 1.00100005;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _fresnelIndensity;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = _fresnelScaleA * u_xlat18 + _fresnelBaseA;
    u_xlat4.xyz = vec3(u_xlat18) * _fresnelColA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_LightMapIntensity) + u_xlat4.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat4.xy = vs_TEXCOORD10.xy * _SandShineTex_ST.xy + _SandShineTex_ST.zw;
    u_xlat10_18 = texture(_SandShineTex, u_xlat4.xy).x;
    u_xlat4.xyz = vec3(u_xlat10_18) * _SecondTexColor.xyz;
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SecondTexIntensity) + u_xlat16_0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _HeiLightGlass;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.x = u_xlat18 * _HeiLightInvertIntensity;
    u_xlat8.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightTexTilling.x), vs_TEXCOORD11.y * float(_HeiLightTexTilling.y));
    u_xlat8.xy = _Time.yy * _HeiLightTexSpeed.xy + u_xlat8.xy;
    u_xlat8.x = texture(_SandShineTex, u_xlat8.xy).y;
    u_xlat14 = u_xlat8.x + -1.0;
    u_xlat14 = u_xlat14 * 3.33333397;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat8.z = u_xlat14 * -2.0 + 3.0;
    u_xlat8.y = u_xlat14 * u_xlat14;
    u_xlat8.xy = u_xlat8.xy * u_xlat8.xz;
    u_xlat14 = u_xlat18 * u_xlat8.y;
    u_xlat18 = u_xlat18 * _HeiLightPointIntensity;
    u_xlat2.xzw = u_xlat2.xxx * _HeiLightInvertColor.xyz + vec3(u_xlat14);
    u_xlat4.xy = vec2(vs_TEXCOORD11.x * float(_HeiLightPointTilling.x), vs_TEXCOORD11.y * float(_HeiLightPointTilling.y));
    u_xlat10_4 = texture(_SandShineTex, u_xlat4.xy).z;
    u_xlat4.x = (-_HeiLightPointStep) * 0.100000001 + u_xlat10_4;
    u_xlat10 = float(1.0) / _HeiLightPointStepWidth;
    u_xlat4.x = u_xlat10 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat10;
    u_xlat18 = u_xlat18 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat18) * _HeiLightPointColor.xyz;
    u_xlat2.xyz = u_xlat8.xxx * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
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
}
Fallback "VertexLit"
}