//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/AirEffect_LightMap_IceMelting" {
Properties {
[MHYHeaderBox(Ice)] _MainColor ("Ice Color", Color) = (1,1,1,1)
_MainTex ("Ice Tex (RGB)", 2D) = "white" { }
_ShadowTex ("Ice LightMap (RGB)", 2D) = "grey" { }
_LightMapIntensity ("Ice Light Map Intensity", Float) = 1
[MHYHeaderBox(Ice Melting)] _IceMelting ("Ice Melting", Range(0, 1)) = 0
_MeltY ("Ice Melt Height", Float) = 0
_MeltRange ("Ice Melt Range", Range(0.001, 1)) = 0.2
_MeltCurve ("Ice Melt Curve", Range(1, 10)) = 2
[MHYHeaderBox(Water)] _WaterColor ("Water Color(Alpha = Water Trasprent)", Color) = (1,1,1,1)
_Fresnel0 ("Water Fresnel", Range(0, 1)) = 0.4
_WaterNormal ("Water Normal", 2D) = "bump" { }
_WaterNormalScale ("Water Normal Scale", Range(0, 2)) = 1
_WaterRefTex ("Water Reflection Tex", Cube) = "white" { }
_WaterRefColor ("Water Reflection Color", Color) = (1,1,1,1)
_WaterRefScale ("Water Reflection Scale", Range(1, 10)) = 1
_WaterRefIntensity ("Water Reflection Intensity", Range(1, 3)) = 1
[MHYHeaderBox(Water Dynamic)] _Speed ("Water Speed", Range(0.001, 2)) = 0.5
_Frequency ("Water Frequency", Range(1, 100)) = 20
_Delta1 ("Water Delta1", Range(0, 0.1)) = 0.01
_Delta2 ("Water Delta2", Range(0, 0.1)) = 0.01
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 45404
Program "vp" {
SubProgram "gles3 hw_tier00 " {
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat9 = u_xlat0.y + (-_MeltY);
    u_xlat9 = u_xlat9 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat13 = log2(u_xlat9);
    u_xlat13 = u_xlat13 * _MeltCurve;
    u_xlat13 = exp2(u_xlat13);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat13) + u_xlat0.xz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.yyy + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat0;
    vs_TEXCOORD2 = u_xlat9;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat9 = u_xlat0.y + (-_MeltY);
    u_xlat9 = u_xlat9 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat13 = log2(u_xlat9);
    u_xlat13 = u_xlat13 * _MeltCurve;
    u_xlat13 = exp2(u_xlat13);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat13) + u_xlat0.xz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.yyy + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat0;
    vs_TEXCOORD2 = u_xlat9;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat9 = u_xlat0.y + (-_MeltY);
    u_xlat9 = u_xlat9 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat13 = log2(u_xlat9);
    u_xlat13 = u_xlat13 * _MeltCurve;
    u_xlat13 = exp2(u_xlat13);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat13) + u_xlat0.xz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.yyy + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat0;
    vs_TEXCOORD2 = u_xlat9;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat9 = u_xlat0.y + (-_MeltY);
    u_xlat9 = u_xlat9 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat13 = log2(u_xlat9);
    u_xlat13 = u_xlat13 * _MeltCurve;
    u_xlat13 = exp2(u_xlat13);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat13) + u_xlat0.xz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.yyy + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat0;
    vs_TEXCOORD2 = u_xlat9;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat9 = u_xlat0.y + (-_MeltY);
    u_xlat9 = u_xlat9 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat13 = log2(u_xlat9);
    u_xlat13 = u_xlat13 * _MeltCurve;
    u_xlat13 = exp2(u_xlat13);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat13) + u_xlat0.xz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.yyy + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat0;
    vs_TEXCOORD2 = u_xlat9;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat9 = u_xlat0.y + (-_MeltY);
    u_xlat9 = u_xlat9 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat13 = log2(u_xlat9);
    u_xlat13 = u_xlat13 * _MeltCurve;
    u_xlat13 = exp2(u_xlat13);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat13) + u_xlat0.xz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.yyy + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat0;
    vs_TEXCOORD2 = u_xlat9;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat8 = u_xlat1.y + (-_MeltY);
    u_xlat8 = u_xlat8 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = log2(u_xlat8);
    vs_TEXCOORD2 = u_xlat8;
    u_xlat8 = u_xlat12 * _MeltCurve;
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat8) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat8 = u_xlat0.z * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat1.x = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat5 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=u_xlat5);
#else
    u_xlatb5 = u_xlat0.x>=u_xlat5;
#endif
    u_xlat12 = (u_xlatb5) ? u_xlat1.x : u_xlat12;
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Mihoyo_FogColor.w;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = min(u_xlat12, _HeigtFogColBase.w);
    u_xlat16_3 = (-u_xlat4) + 2.0;
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat4 = u_xlat4 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat4 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat8 * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat12 : 1.0;
    u_xlat8 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat8 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat8 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat2.w = u_xlat8 * u_xlat4;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_COLOR2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat2.xyz * u_xlat16_4.xxx + vs_COLOR1.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat8 = u_xlat1.y + (-_MeltY);
    u_xlat8 = u_xlat8 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = log2(u_xlat8);
    vs_TEXCOORD2 = u_xlat8;
    u_xlat8 = u_xlat12 * _MeltCurve;
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat8) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat8 = u_xlat0.z * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat1.x = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat5 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=u_xlat5);
#else
    u_xlatb5 = u_xlat0.x>=u_xlat5;
#endif
    u_xlat12 = (u_xlatb5) ? u_xlat1.x : u_xlat12;
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Mihoyo_FogColor.w;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = min(u_xlat12, _HeigtFogColBase.w);
    u_xlat16_3 = (-u_xlat4) + 2.0;
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat4 = u_xlat4 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat4 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat8 * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat12 : 1.0;
    u_xlat8 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat8 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat8 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat2.w = u_xlat8 * u_xlat4;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_COLOR2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat2.xyz * u_xlat16_4.xxx + vs_COLOR1.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat8 = u_xlat1.y + (-_MeltY);
    u_xlat8 = u_xlat8 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = log2(u_xlat8);
    vs_TEXCOORD2 = u_xlat8;
    u_xlat8 = u_xlat12 * _MeltCurve;
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat8) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat8 = u_xlat0.z * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat1.x = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat5 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=u_xlat5);
#else
    u_xlatb5 = u_xlat0.x>=u_xlat5;
#endif
    u_xlat12 = (u_xlatb5) ? u_xlat1.x : u_xlat12;
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Mihoyo_FogColor.w;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = min(u_xlat12, _HeigtFogColBase.w);
    u_xlat16_3 = (-u_xlat4) + 2.0;
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat4 = u_xlat4 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat4 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat8 * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat12 : 1.0;
    u_xlat8 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat8 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat8 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat2.w = u_xlat8 * u_xlat4;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_COLOR2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat2.xyz * u_xlat16_4.xxx + vs_COLOR1.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat10 = u_xlat1.y + (-_MeltY);
    u_xlat10 = u_xlat10 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat15 = log2(u_xlat10);
    vs_TEXCOORD2 = u_xlat10;
    u_xlat10 = u_xlat15 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat6 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x>=u_xlat6);
#else
    u_xlatb6 = u_xlat0.x>=u_xlat6;
#endif
    u_xlat15 = (u_xlatb6) ? u_xlat1.x : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat1.x) + 2.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.xzw = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat17 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat1.xzw = vec3(u_xlat17) * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat1.xzw = vec3(u_xlat15) * u_xlat1.xzw;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat2.x = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7 = u_xlat2.x * -1.44269502;
    u_xlat7 = exp2(u_xlat7);
    u_xlat7 = (-u_xlat7) + 1.0;
    u_xlat7 = u_xlat7 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3 = (u_xlatb2) ? u_xlat7 : 1.0;
    u_xlat2.x = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat2.x = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat2.x) + 2.0;
    u_xlat16_8 = u_xlat2.x * u_xlat16_8;
    u_xlat2.x = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7 = (-u_xlat2.x) + 1.0;
    u_xlat1.xzw = u_xlat1.xzw * vec3(u_xlat7);
    u_xlat3.w = u_xlat15 * u_xlat7;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xzw;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xyz = (-u_xlat1.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat5.xxx * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb6) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xzw;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    vs_COLOR2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat2.xyz * u_xlat16_4.xxx + vs_COLOR1.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat10 = u_xlat1.y + (-_MeltY);
    u_xlat10 = u_xlat10 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat15 = log2(u_xlat10);
    vs_TEXCOORD2 = u_xlat10;
    u_xlat10 = u_xlat15 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat6 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x>=u_xlat6);
#else
    u_xlatb6 = u_xlat0.x>=u_xlat6;
#endif
    u_xlat15 = (u_xlatb6) ? u_xlat1.x : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat1.x) + 2.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.xzw = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat17 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat1.xzw = vec3(u_xlat17) * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat1.xzw = vec3(u_xlat15) * u_xlat1.xzw;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat2.x = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7 = u_xlat2.x * -1.44269502;
    u_xlat7 = exp2(u_xlat7);
    u_xlat7 = (-u_xlat7) + 1.0;
    u_xlat7 = u_xlat7 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3 = (u_xlatb2) ? u_xlat7 : 1.0;
    u_xlat2.x = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat2.x = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat2.x) + 2.0;
    u_xlat16_8 = u_xlat2.x * u_xlat16_8;
    u_xlat2.x = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7 = (-u_xlat2.x) + 1.0;
    u_xlat1.xzw = u_xlat1.xzw * vec3(u_xlat7);
    u_xlat3.w = u_xlat15 * u_xlat7;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xzw;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xyz = (-u_xlat1.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat5.xxx * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb6) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xzw;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    vs_COLOR2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat2.xyz * u_xlat16_4.xxx + vs_COLOR1.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat10 = u_xlat1.y + (-_MeltY);
    u_xlat10 = u_xlat10 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat15 = log2(u_xlat10);
    vs_TEXCOORD2 = u_xlat10;
    u_xlat10 = u_xlat15 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat6 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x>=u_xlat6);
#else
    u_xlatb6 = u_xlat0.x>=u_xlat6;
#endif
    u_xlat15 = (u_xlatb6) ? u_xlat1.x : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat1.x) + 2.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.xzw = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat17 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat1.xzw = vec3(u_xlat17) * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat1.xzw = vec3(u_xlat15) * u_xlat1.xzw;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat2.x = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7 = u_xlat2.x * -1.44269502;
    u_xlat7 = exp2(u_xlat7);
    u_xlat7 = (-u_xlat7) + 1.0;
    u_xlat7 = u_xlat7 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3 = (u_xlatb2) ? u_xlat7 : 1.0;
    u_xlat2.x = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat2.x = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat2.x) + 2.0;
    u_xlat16_8 = u_xlat2.x * u_xlat16_8;
    u_xlat2.x = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7 = (-u_xlat2.x) + 1.0;
    u_xlat1.xzw = u_xlat1.xzw * vec3(u_xlat7);
    u_xlat3.w = u_xlat15 * u_xlat7;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xzw;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xyz = (-u_xlat1.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat5.xxx * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb6) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xzw;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    vs_COLOR2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat2.xyz * u_xlat16_4.xxx + vs_COLOR1.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat10;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat2.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat2.xy;
    u_xlat0.x = u_xlat1.y + (-_MeltY);
    u_xlat0.x = u_xlat0.x / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10 = log2(u_xlat0.x);
    u_xlat10 = u_xlat10 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.yyy + u_xlat2.xzw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat1;
    vs_TEXCOORD2 = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat10;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat2.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat2.xy;
    u_xlat0.x = u_xlat1.y + (-_MeltY);
    u_xlat0.x = u_xlat0.x / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10 = log2(u_xlat0.x);
    u_xlat10 = u_xlat10 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.yyy + u_xlat2.xzw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat1;
    vs_TEXCOORD2 = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat10;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat2.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat2.xy;
    u_xlat0.x = u_xlat1.y + (-_MeltY);
    u_xlat0.x = u_xlat0.x / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10 = log2(u_xlat0.x);
    u_xlat10 = u_xlat10 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.yyy + u_xlat2.xzw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat1;
    vs_TEXCOORD2 = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat10;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat2.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat2.xy;
    u_xlat0.x = u_xlat1.y + (-_MeltY);
    u_xlat0.x = u_xlat0.x / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10 = log2(u_xlat0.x);
    u_xlat10 = u_xlat10 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.yyy + u_xlat2.xzw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat1;
    vs_TEXCOORD2 = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat10;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat2.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat2.xy;
    u_xlat0.x = u_xlat1.y + (-_MeltY);
    u_xlat0.x = u_xlat0.x / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10 = log2(u_xlat0.x);
    u_xlat10 = u_xlat10 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.yyy + u_xlat2.xzw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat1;
    vs_TEXCOORD2 = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat10;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat2.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat2.xy;
    u_xlat0.x = u_xlat1.y + (-_MeltY);
    u_xlat0.x = u_xlat0.x / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10 = log2(u_xlat0.x);
    u_xlat10 = u_xlat10 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.yyy + u_xlat2.xzw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat1;
    vs_TEXCOORD2 = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
float u_xlat16;
float u_xlat19;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat10 = u_xlat1.y + (-_MeltY);
    u_xlat10 = u_xlat10 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat15 = log2(u_xlat10);
    vs_TEXCOORD2 = u_xlat10;
    u_xlat10 = u_xlat15 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat2.x = u_xlat16 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat7.x * u_xlat2.x;
    u_xlat7.x = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16>=u_xlat12);
#else
    u_xlatb12 = u_xlat16>=u_xlat12;
#endif
    u_xlat2.x = (u_xlatb12) ? u_xlat7.x : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat7.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat7.x) + 2.0;
    u_xlat16_3 = u_xlat7.x * u_xlat16_3;
    u_xlat7.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat7.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat19 = u_xlat16 + (-_HeigtFogRamp.w);
    u_xlat19 = u_xlat19 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat6 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat1.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xz = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xz);
    u_xlat1.x = u_xlat6 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3 = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat16 * _HeigtFogParams.y;
    u_xlat6 = u_xlat16 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat6) + 2.0;
    u_xlat16_8 = u_xlat6 * u_xlat16_8;
    u_xlat1.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat1.x) + 1.0;
    u_xlat7.xyz = vec3(u_xlat6) * u_xlat7.xyz;
    u_xlat3.w = u_xlat6 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat1.xxx + u_xlat7.xyz;
    vs_COLOR1 = u_xlat3;
    vs_COLOR2 = in_COLOR0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
float u_xlat16;
float u_xlat19;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat10 = u_xlat1.y + (-_MeltY);
    u_xlat10 = u_xlat10 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat15 = log2(u_xlat10);
    vs_TEXCOORD2 = u_xlat10;
    u_xlat10 = u_xlat15 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat2.x = u_xlat16 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat7.x * u_xlat2.x;
    u_xlat7.x = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16>=u_xlat12);
#else
    u_xlatb12 = u_xlat16>=u_xlat12;
#endif
    u_xlat2.x = (u_xlatb12) ? u_xlat7.x : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat7.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat7.x) + 2.0;
    u_xlat16_3 = u_xlat7.x * u_xlat16_3;
    u_xlat7.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat7.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat19 = u_xlat16 + (-_HeigtFogRamp.w);
    u_xlat19 = u_xlat19 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat6 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat1.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xz = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xz);
    u_xlat1.x = u_xlat6 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3 = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat16 * _HeigtFogParams.y;
    u_xlat6 = u_xlat16 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat6) + 2.0;
    u_xlat16_8 = u_xlat6 * u_xlat16_8;
    u_xlat1.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat1.x) + 1.0;
    u_xlat7.xyz = vec3(u_xlat6) * u_xlat7.xyz;
    u_xlat3.w = u_xlat6 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat1.xxx + u_xlat7.xyz;
    vs_COLOR1 = u_xlat3;
    vs_COLOR2 = in_COLOR0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
float u_xlat16;
float u_xlat19;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat10 = u_xlat1.y + (-_MeltY);
    u_xlat10 = u_xlat10 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat15 = log2(u_xlat10);
    vs_TEXCOORD2 = u_xlat10;
    u_xlat10 = u_xlat15 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat2.x = u_xlat16 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat7.x * u_xlat2.x;
    u_xlat7.x = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16>=u_xlat12);
#else
    u_xlatb12 = u_xlat16>=u_xlat12;
#endif
    u_xlat2.x = (u_xlatb12) ? u_xlat7.x : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat7.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat7.x) + 2.0;
    u_xlat16_3 = u_xlat7.x * u_xlat16_3;
    u_xlat7.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat7.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat19 = u_xlat16 + (-_HeigtFogRamp.w);
    u_xlat19 = u_xlat19 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat6 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat1.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xz = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xz);
    u_xlat1.x = u_xlat6 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3 = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat16 * _HeigtFogParams.y;
    u_xlat6 = u_xlat16 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat6) + 2.0;
    u_xlat16_8 = u_xlat6 * u_xlat16_8;
    u_xlat1.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat1.x) + 1.0;
    u_xlat7.xyz = vec3(u_xlat6) * u_xlat7.xyz;
    u_xlat3.w = u_xlat6 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat1.xxx + u_xlat7.xyz;
    vs_COLOR1 = u_xlat3;
    vs_COLOR2 = in_COLOR0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_13;
float u_xlat14;
float u_xlat16;
bool u_xlatb16;
float u_xlat21;
float u_xlat22;
float u_xlat23;
float u_xlat25;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat14 = u_xlat1.y + (-_MeltY);
    u_xlat14 = u_xlat14 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat21 = log2(u_xlat14);
    vs_TEXCOORD2 = u_xlat14;
    u_xlat14 = u_xlat21 * _MeltCurve;
    u_xlat14 = exp2(u_xlat14);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat14) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat2.x = u_xlat22 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat9 * u_xlat2.x;
    u_xlat9 = u_xlat2.x * _HeigtFogColDelta3.w;
    u_xlat16 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat22>=u_xlat16);
#else
    u_xlatb16 = u_xlat22>=u_xlat16;
#endif
    u_xlat2.x = (u_xlatb16) ? u_xlat9 : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor3.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase3.w);
    u_xlat9 = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat9) + 2.0;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat4.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat9 = u_xlat22 + (-_HeigtFogRamp3.w);
    u_xlat9 = u_xlat9 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat9) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat9 = u_xlat1.y * _HeigtFogParams3.x;
    u_xlat23 = u_xlat9 * -1.44269502;
    u_xlat2.w = exp2(u_xlat23);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat23 = u_xlat2.w / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_3 = (u_xlatb9) ? u_xlat23 : 1.0;
    u_xlat9 = u_xlat22 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat9 = u_xlat22 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat9 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat23 = (-u_xlat9) + 1.0;
    u_xlat4.xyz = vec3(u_xlat23) * u_xlat4.xyz;
    u_xlat3.w = u_xlat23 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat9) + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyw = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyz = (-u_xlat2.xyw) + _HeigtFogRadialCol2.xyz;
    u_xlat25 = u_xlat22 + (-_HeigtFogRamp2.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyw = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyw;
    u_xlat4.x = u_xlat22 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat16 = (u_xlatb16) ? u_xlat11 : u_xlat4.x;
    u_xlat16 = log2(u_xlat16);
    u_xlat16 = u_xlat16 * _Mihoyo_FogColor2.w;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = min(u_xlat16, _HeigtFogColBase2.w);
    u_xlat2.xyw = vec3(u_xlat16) * u_xlat2.xyw;
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat8 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat1.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xz = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xz);
    u_xlat1.x = u_xlat8 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat8 = u_xlat22 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat1.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyw = vec3(u_xlat8) * u_xlat2.xyw;
    u_xlat4.w = u_xlat8 * u_xlat16;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat2.xyw;
    u_xlat1 = u_xlat3 + (-u_xlat4);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat4;
    vs_COLOR1 = u_xlat1;
    vs_COLOR2 = in_COLOR0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_13;
float u_xlat14;
float u_xlat16;
bool u_xlatb16;
float u_xlat21;
float u_xlat22;
float u_xlat23;
float u_xlat25;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat14 = u_xlat1.y + (-_MeltY);
    u_xlat14 = u_xlat14 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat21 = log2(u_xlat14);
    vs_TEXCOORD2 = u_xlat14;
    u_xlat14 = u_xlat21 * _MeltCurve;
    u_xlat14 = exp2(u_xlat14);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat14) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat2.x = u_xlat22 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat9 * u_xlat2.x;
    u_xlat9 = u_xlat2.x * _HeigtFogColDelta3.w;
    u_xlat16 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat22>=u_xlat16);
#else
    u_xlatb16 = u_xlat22>=u_xlat16;
#endif
    u_xlat2.x = (u_xlatb16) ? u_xlat9 : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor3.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase3.w);
    u_xlat9 = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat9) + 2.0;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat4.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat9 = u_xlat22 + (-_HeigtFogRamp3.w);
    u_xlat9 = u_xlat9 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat9) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat9 = u_xlat1.y * _HeigtFogParams3.x;
    u_xlat23 = u_xlat9 * -1.44269502;
    u_xlat2.w = exp2(u_xlat23);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat23 = u_xlat2.w / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_3 = (u_xlatb9) ? u_xlat23 : 1.0;
    u_xlat9 = u_xlat22 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat9 = u_xlat22 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat9 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat23 = (-u_xlat9) + 1.0;
    u_xlat4.xyz = vec3(u_xlat23) * u_xlat4.xyz;
    u_xlat3.w = u_xlat23 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat9) + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyw = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyz = (-u_xlat2.xyw) + _HeigtFogRadialCol2.xyz;
    u_xlat25 = u_xlat22 + (-_HeigtFogRamp2.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyw = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyw;
    u_xlat4.x = u_xlat22 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat16 = (u_xlatb16) ? u_xlat11 : u_xlat4.x;
    u_xlat16 = log2(u_xlat16);
    u_xlat16 = u_xlat16 * _Mihoyo_FogColor2.w;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = min(u_xlat16, _HeigtFogColBase2.w);
    u_xlat2.xyw = vec3(u_xlat16) * u_xlat2.xyw;
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat8 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat1.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xz = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xz);
    u_xlat1.x = u_xlat8 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat8 = u_xlat22 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat1.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyw = vec3(u_xlat8) * u_xlat2.xyw;
    u_xlat4.w = u_xlat8 * u_xlat16;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat2.xyw;
    u_xlat1 = u_xlat3 + (-u_xlat4);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat4;
    vs_COLOR1 = u_xlat1;
    vs_COLOR2 = in_COLOR0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_13;
float u_xlat14;
float u_xlat16;
bool u_xlatb16;
float u_xlat21;
float u_xlat22;
float u_xlat23;
float u_xlat25;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat14 = u_xlat1.y + (-_MeltY);
    u_xlat14 = u_xlat14 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat21 = log2(u_xlat14);
    vs_TEXCOORD2 = u_xlat14;
    u_xlat14 = u_xlat21 * _MeltCurve;
    u_xlat14 = exp2(u_xlat14);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat14) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat2.x = u_xlat22 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat9 * u_xlat2.x;
    u_xlat9 = u_xlat2.x * _HeigtFogColDelta3.w;
    u_xlat16 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat22>=u_xlat16);
#else
    u_xlatb16 = u_xlat22>=u_xlat16;
#endif
    u_xlat2.x = (u_xlatb16) ? u_xlat9 : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor3.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase3.w);
    u_xlat9 = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat9) + 2.0;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat4.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat9 = u_xlat22 + (-_HeigtFogRamp3.w);
    u_xlat9 = u_xlat9 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat9) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat9 = u_xlat1.y * _HeigtFogParams3.x;
    u_xlat23 = u_xlat9 * -1.44269502;
    u_xlat2.w = exp2(u_xlat23);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat23 = u_xlat2.w / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_3 = (u_xlatb9) ? u_xlat23 : 1.0;
    u_xlat9 = u_xlat22 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat9 = u_xlat22 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat9 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat23 = (-u_xlat9) + 1.0;
    u_xlat4.xyz = vec3(u_xlat23) * u_xlat4.xyz;
    u_xlat3.w = u_xlat23 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat9) + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyw = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyz = (-u_xlat2.xyw) + _HeigtFogRadialCol2.xyz;
    u_xlat25 = u_xlat22 + (-_HeigtFogRamp2.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyw = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyw;
    u_xlat4.x = u_xlat22 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat16 = (u_xlatb16) ? u_xlat11 : u_xlat4.x;
    u_xlat16 = log2(u_xlat16);
    u_xlat16 = u_xlat16 * _Mihoyo_FogColor2.w;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = min(u_xlat16, _HeigtFogColBase2.w);
    u_xlat2.xyw = vec3(u_xlat16) * u_xlat2.xyw;
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat8 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat1.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xz = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xz);
    u_xlat1.x = u_xlat8 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat8 = u_xlat22 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat1.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyw = vec3(u_xlat8) * u_xlat2.xyw;
    u_xlat4.w = u_xlat8 * u_xlat16;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat2.xyw;
    u_xlat1 = u_xlat3 + (-u_xlat4);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat4;
    vs_COLOR1 = u_xlat1;
    vs_COLOR2 = in_COLOR0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_1.w = 1.0;
    u_xlat2 = u_xlat16_1 * _MainColor;
    u_xlat1.w = (-u_xlat16_1.w) * _MainColor.w + _WaterColor.w;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat2.xyz);
    u_xlat0.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat9 = u_xlat0.y + (-_MeltY);
    u_xlat9 = u_xlat9 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat13 = log2(u_xlat9);
    u_xlat13 = u_xlat13 * _MeltCurve;
    u_xlat13 = exp2(u_xlat13);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat13) + u_xlat0.xz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.yyy + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat0;
    vs_TEXCOORD2 = u_xlat9;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_4.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat16_15 = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat9 = u_xlat0.y + (-_MeltY);
    u_xlat9 = u_xlat9 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat13 = log2(u_xlat9);
    u_xlat13 = u_xlat13 * _MeltCurve;
    u_xlat13 = exp2(u_xlat13);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat13) + u_xlat0.xz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.yyy + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat0;
    vs_TEXCOORD2 = u_xlat9;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_4.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat16_15 = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat9 = u_xlat0.y + (-_MeltY);
    u_xlat9 = u_xlat9 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat13 = log2(u_xlat9);
    u_xlat13 = u_xlat13 * _MeltCurve;
    u_xlat13 = exp2(u_xlat13);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat13) + u_xlat0.xz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.yyy + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat0;
    vs_TEXCOORD2 = u_xlat9;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_4.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat16_15 = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat9 = u_xlat0.y + (-_MeltY);
    u_xlat9 = u_xlat9 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat13 = log2(u_xlat9);
    u_xlat13 = u_xlat13 * _MeltCurve;
    u_xlat13 = exp2(u_xlat13);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat13) + u_xlat0.xz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.yyy + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat0;
    vs_TEXCOORD2 = u_xlat9;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_4.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat16_15 = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat9 = u_xlat0.y + (-_MeltY);
    u_xlat9 = u_xlat9 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat13 = log2(u_xlat9);
    u_xlat13 = u_xlat13 * _MeltCurve;
    u_xlat13 = exp2(u_xlat13);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat13) + u_xlat0.xz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.yyy + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat0;
    vs_TEXCOORD2 = u_xlat9;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_4.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat16_15 = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat9 = u_xlat0.y + (-_MeltY);
    u_xlat9 = u_xlat9 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat13 = log2(u_xlat9);
    u_xlat13 = u_xlat13 * _MeltCurve;
    u_xlat13 = exp2(u_xlat13);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat13) + u_xlat0.xz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.yyy + u_xlat2.xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat0;
    vs_TEXCOORD2 = u_xlat9;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_4.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat16_15 = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat8 = u_xlat1.y + (-_MeltY);
    u_xlat8 = u_xlat8 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = log2(u_xlat8);
    vs_TEXCOORD2 = u_xlat8;
    u_xlat8 = u_xlat12 * _MeltCurve;
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat8) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat8 = u_xlat0.z * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat1.x = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat5 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=u_xlat5);
#else
    u_xlatb5 = u_xlat0.x>=u_xlat5;
#endif
    u_xlat12 = (u_xlatb5) ? u_xlat1.x : u_xlat12;
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Mihoyo_FogColor.w;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = min(u_xlat12, _HeigtFogColBase.w);
    u_xlat16_3 = (-u_xlat4) + 2.0;
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat4 = u_xlat4 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat4 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat8 * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat12 : 1.0;
    u_xlat8 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat8 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat8 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat2.w = u_xlat8 * u_xlat4;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_COLOR2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat16_4.xxx + vs_COLOR1.xyz;
    u_xlat16_15 = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat8 = u_xlat1.y + (-_MeltY);
    u_xlat8 = u_xlat8 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = log2(u_xlat8);
    vs_TEXCOORD2 = u_xlat8;
    u_xlat8 = u_xlat12 * _MeltCurve;
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat8) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat8 = u_xlat0.z * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat1.x = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat5 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=u_xlat5);
#else
    u_xlatb5 = u_xlat0.x>=u_xlat5;
#endif
    u_xlat12 = (u_xlatb5) ? u_xlat1.x : u_xlat12;
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Mihoyo_FogColor.w;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = min(u_xlat12, _HeigtFogColBase.w);
    u_xlat16_3 = (-u_xlat4) + 2.0;
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat4 = u_xlat4 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat4 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat8 * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat12 : 1.0;
    u_xlat8 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat8 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat8 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat2.w = u_xlat8 * u_xlat4;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_COLOR2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat16_4.xxx + vs_COLOR1.xyz;
    u_xlat16_15 = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat8 = u_xlat1.y + (-_MeltY);
    u_xlat8 = u_xlat8 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = log2(u_xlat8);
    vs_TEXCOORD2 = u_xlat8;
    u_xlat8 = u_xlat12 * _MeltCurve;
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat8) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat8 = u_xlat0.z * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat1.x = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat5 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=u_xlat5);
#else
    u_xlatb5 = u_xlat0.x>=u_xlat5;
#endif
    u_xlat12 = (u_xlatb5) ? u_xlat1.x : u_xlat12;
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Mihoyo_FogColor.w;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = min(u_xlat12, _HeigtFogColBase.w);
    u_xlat16_3 = (-u_xlat4) + 2.0;
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat4 = u_xlat4 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat4 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat8 * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat12 : 1.0;
    u_xlat8 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat8 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat8 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat2.w = u_xlat8 * u_xlat4;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_COLOR2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat16_4.xxx + vs_COLOR1.xyz;
    u_xlat16_15 = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat10 = u_xlat1.y + (-_MeltY);
    u_xlat10 = u_xlat10 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat15 = log2(u_xlat10);
    vs_TEXCOORD2 = u_xlat10;
    u_xlat10 = u_xlat15 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat6 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x>=u_xlat6);
#else
    u_xlatb6 = u_xlat0.x>=u_xlat6;
#endif
    u_xlat15 = (u_xlatb6) ? u_xlat1.x : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat1.x) + 2.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.xzw = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat17 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat1.xzw = vec3(u_xlat17) * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat1.xzw = vec3(u_xlat15) * u_xlat1.xzw;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat2.x = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7 = u_xlat2.x * -1.44269502;
    u_xlat7 = exp2(u_xlat7);
    u_xlat7 = (-u_xlat7) + 1.0;
    u_xlat7 = u_xlat7 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3 = (u_xlatb2) ? u_xlat7 : 1.0;
    u_xlat2.x = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat2.x = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat2.x) + 2.0;
    u_xlat16_8 = u_xlat2.x * u_xlat16_8;
    u_xlat2.x = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7 = (-u_xlat2.x) + 1.0;
    u_xlat1.xzw = u_xlat1.xzw * vec3(u_xlat7);
    u_xlat3.w = u_xlat15 * u_xlat7;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xzw;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xyz = (-u_xlat1.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat5.xxx * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb6) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xzw;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    vs_COLOR2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat16_4.xxx + vs_COLOR1.xyz;
    u_xlat16_15 = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat10 = u_xlat1.y + (-_MeltY);
    u_xlat10 = u_xlat10 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat15 = log2(u_xlat10);
    vs_TEXCOORD2 = u_xlat10;
    u_xlat10 = u_xlat15 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat6 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x>=u_xlat6);
#else
    u_xlatb6 = u_xlat0.x>=u_xlat6;
#endif
    u_xlat15 = (u_xlatb6) ? u_xlat1.x : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat1.x) + 2.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.xzw = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat17 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat1.xzw = vec3(u_xlat17) * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat1.xzw = vec3(u_xlat15) * u_xlat1.xzw;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat2.x = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7 = u_xlat2.x * -1.44269502;
    u_xlat7 = exp2(u_xlat7);
    u_xlat7 = (-u_xlat7) + 1.0;
    u_xlat7 = u_xlat7 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3 = (u_xlatb2) ? u_xlat7 : 1.0;
    u_xlat2.x = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat2.x = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat2.x) + 2.0;
    u_xlat16_8 = u_xlat2.x * u_xlat16_8;
    u_xlat2.x = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7 = (-u_xlat2.x) + 1.0;
    u_xlat1.xzw = u_xlat1.xzw * vec3(u_xlat7);
    u_xlat3.w = u_xlat15 * u_xlat7;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xzw;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xyz = (-u_xlat1.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat5.xxx * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb6) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xzw;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    vs_COLOR2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat16_4.xxx + vs_COLOR1.xyz;
    u_xlat16_15 = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat10 = u_xlat1.y + (-_MeltY);
    u_xlat10 = u_xlat10 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat15 = log2(u_xlat10);
    vs_TEXCOORD2 = u_xlat10;
    u_xlat10 = u_xlat15 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat6 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x>=u_xlat6);
#else
    u_xlatb6 = u_xlat0.x>=u_xlat6;
#endif
    u_xlat15 = (u_xlatb6) ? u_xlat1.x : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat1.x) + 2.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.xzw = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat17 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat1.xzw = vec3(u_xlat17) * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat1.xzw = vec3(u_xlat15) * u_xlat1.xzw;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat2.x = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7 = u_xlat2.x * -1.44269502;
    u_xlat7 = exp2(u_xlat7);
    u_xlat7 = (-u_xlat7) + 1.0;
    u_xlat7 = u_xlat7 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3 = (u_xlatb2) ? u_xlat7 : 1.0;
    u_xlat2.x = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat2.x = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat2.x) + 2.0;
    u_xlat16_8 = u_xlat2.x * u_xlat16_8;
    u_xlat2.x = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7 = (-u_xlat2.x) + 1.0;
    u_xlat1.xzw = u_xlat1.xzw * vec3(u_xlat7);
    u_xlat3.w = u_xlat15 * u_xlat7;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xzw;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xyz = (-u_xlat1.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat5.xxx * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb6) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xzw;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    vs_COLOR2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat7;
float u_xlat15;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_1.www) + u_xlat16_4.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_LightMapIntensity);
    u_xlat16_4.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat16_4.xxx + vs_COLOR1.xyz;
    u_xlat16_15 = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat10;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat2.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat2.xy;
    u_xlat0.x = u_xlat1.y + (-_MeltY);
    u_xlat0.x = u_xlat0.x / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10 = log2(u_xlat0.x);
    u_xlat10 = u_xlat10 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.yyy + u_xlat2.xzw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat1;
    vs_TEXCOORD2 = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_15 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat10;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat2.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat2.xy;
    u_xlat0.x = u_xlat1.y + (-_MeltY);
    u_xlat0.x = u_xlat0.x / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10 = log2(u_xlat0.x);
    u_xlat10 = u_xlat10 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.yyy + u_xlat2.xzw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat1;
    vs_TEXCOORD2 = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_15 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat10;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat2.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat2.xy;
    u_xlat0.x = u_xlat1.y + (-_MeltY);
    u_xlat0.x = u_xlat0.x / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10 = log2(u_xlat0.x);
    u_xlat10 = u_xlat10 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.yyy + u_xlat2.xzw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat1;
    vs_TEXCOORD2 = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_15 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat10;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat2.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat2.xy;
    u_xlat0.x = u_xlat1.y + (-_MeltY);
    u_xlat0.x = u_xlat0.x / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10 = log2(u_xlat0.x);
    u_xlat10 = u_xlat10 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.yyy + u_xlat2.xzw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat1;
    vs_TEXCOORD2 = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_15 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat10;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat2.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat2.xy;
    u_xlat0.x = u_xlat1.y + (-_MeltY);
    u_xlat0.x = u_xlat0.x / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10 = log2(u_xlat0.x);
    u_xlat10 = u_xlat10 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.yyy + u_xlat2.xzw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat1;
    vs_TEXCOORD2 = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_15 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat10;
void main()
{
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
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat8, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
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
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat2.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat2.xy;
    u_xlat0.x = u_xlat1.y + (-_MeltY);
    u_xlat0.x = u_xlat0.x / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10 = log2(u_xlat0.x);
    u_xlat10 = u_xlat10 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.yyy + u_xlat2.xzw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR2 = in_COLOR0;
    vs_TEXCOORD3 = u_xlat1;
    vs_TEXCOORD2 = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_15 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
float u_xlat16;
float u_xlat19;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat10 = u_xlat1.y + (-_MeltY);
    u_xlat10 = u_xlat10 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat15 = log2(u_xlat10);
    vs_TEXCOORD2 = u_xlat10;
    u_xlat10 = u_xlat15 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat2.x = u_xlat16 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat7.x * u_xlat2.x;
    u_xlat7.x = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16>=u_xlat12);
#else
    u_xlatb12 = u_xlat16>=u_xlat12;
#endif
    u_xlat2.x = (u_xlatb12) ? u_xlat7.x : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat7.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat7.x) + 2.0;
    u_xlat16_3 = u_xlat7.x * u_xlat16_3;
    u_xlat7.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat7.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat19 = u_xlat16 + (-_HeigtFogRamp.w);
    u_xlat19 = u_xlat19 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat6 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat1.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xz = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xz);
    u_xlat1.x = u_xlat6 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3 = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat16 * _HeigtFogParams.y;
    u_xlat6 = u_xlat16 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat6) + 2.0;
    u_xlat16_8 = u_xlat6 * u_xlat16_8;
    u_xlat1.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat1.x) + 1.0;
    u_xlat7.xyz = vec3(u_xlat6) * u_xlat7.xyz;
    u_xlat3.w = u_xlat6 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat1.xxx + u_xlat7.xyz;
    vs_COLOR1 = u_xlat3;
    vs_COLOR2 = in_COLOR0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_15 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
float u_xlat16;
float u_xlat19;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat10 = u_xlat1.y + (-_MeltY);
    u_xlat10 = u_xlat10 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat15 = log2(u_xlat10);
    vs_TEXCOORD2 = u_xlat10;
    u_xlat10 = u_xlat15 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat2.x = u_xlat16 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat7.x * u_xlat2.x;
    u_xlat7.x = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16>=u_xlat12);
#else
    u_xlatb12 = u_xlat16>=u_xlat12;
#endif
    u_xlat2.x = (u_xlatb12) ? u_xlat7.x : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat7.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat7.x) + 2.0;
    u_xlat16_3 = u_xlat7.x * u_xlat16_3;
    u_xlat7.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat7.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat19 = u_xlat16 + (-_HeigtFogRamp.w);
    u_xlat19 = u_xlat19 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat6 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat1.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xz = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xz);
    u_xlat1.x = u_xlat6 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3 = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat16 * _HeigtFogParams.y;
    u_xlat6 = u_xlat16 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat6) + 2.0;
    u_xlat16_8 = u_xlat6 * u_xlat16_8;
    u_xlat1.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat1.x) + 1.0;
    u_xlat7.xyz = vec3(u_xlat6) * u_xlat7.xyz;
    u_xlat3.w = u_xlat6 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat1.xxx + u_xlat7.xyz;
    vs_COLOR1 = u_xlat3;
    vs_COLOR2 = in_COLOR0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_15 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
float u_xlat16;
float u_xlat19;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat10 = u_xlat1.y + (-_MeltY);
    u_xlat10 = u_xlat10 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat15 = log2(u_xlat10);
    vs_TEXCOORD2 = u_xlat10;
    u_xlat10 = u_xlat15 * _MeltCurve;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat2.x = u_xlat16 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat7.x * u_xlat2.x;
    u_xlat7.x = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16>=u_xlat12);
#else
    u_xlatb12 = u_xlat16>=u_xlat12;
#endif
    u_xlat2.x = (u_xlatb12) ? u_xlat7.x : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat7.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat7.x) + 2.0;
    u_xlat16_3 = u_xlat7.x * u_xlat16_3;
    u_xlat7.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat7.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat19 = u_xlat16 + (-_HeigtFogRamp.w);
    u_xlat19 = u_xlat19 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat6 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat1.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xz = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xz);
    u_xlat1.x = u_xlat6 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3 = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat16 * _HeigtFogParams.y;
    u_xlat6 = u_xlat16 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat6) + 2.0;
    u_xlat16_8 = u_xlat6 * u_xlat16_8;
    u_xlat1.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat1.x) + 1.0;
    u_xlat7.xyz = vec3(u_xlat6) * u_xlat7.xyz;
    u_xlat3.w = u_xlat6 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat1.xxx + u_xlat7.xyz;
    vs_COLOR1 = u_xlat3;
    vs_COLOR2 = in_COLOR0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_15 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_13;
float u_xlat14;
float u_xlat16;
bool u_xlatb16;
float u_xlat21;
float u_xlat22;
float u_xlat23;
float u_xlat25;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat14 = u_xlat1.y + (-_MeltY);
    u_xlat14 = u_xlat14 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat21 = log2(u_xlat14);
    vs_TEXCOORD2 = u_xlat14;
    u_xlat14 = u_xlat21 * _MeltCurve;
    u_xlat14 = exp2(u_xlat14);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat14) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat2.x = u_xlat22 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat9 * u_xlat2.x;
    u_xlat9 = u_xlat2.x * _HeigtFogColDelta3.w;
    u_xlat16 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat22>=u_xlat16);
#else
    u_xlatb16 = u_xlat22>=u_xlat16;
#endif
    u_xlat2.x = (u_xlatb16) ? u_xlat9 : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor3.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase3.w);
    u_xlat9 = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat9) + 2.0;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat4.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat9 = u_xlat22 + (-_HeigtFogRamp3.w);
    u_xlat9 = u_xlat9 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat9) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat9 = u_xlat1.y * _HeigtFogParams3.x;
    u_xlat23 = u_xlat9 * -1.44269502;
    u_xlat2.w = exp2(u_xlat23);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat23 = u_xlat2.w / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_3 = (u_xlatb9) ? u_xlat23 : 1.0;
    u_xlat9 = u_xlat22 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat9 = u_xlat22 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat9 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat23 = (-u_xlat9) + 1.0;
    u_xlat4.xyz = vec3(u_xlat23) * u_xlat4.xyz;
    u_xlat3.w = u_xlat23 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat9) + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyw = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyz = (-u_xlat2.xyw) + _HeigtFogRadialCol2.xyz;
    u_xlat25 = u_xlat22 + (-_HeigtFogRamp2.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyw = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyw;
    u_xlat4.x = u_xlat22 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat16 = (u_xlatb16) ? u_xlat11 : u_xlat4.x;
    u_xlat16 = log2(u_xlat16);
    u_xlat16 = u_xlat16 * _Mihoyo_FogColor2.w;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = min(u_xlat16, _HeigtFogColBase2.w);
    u_xlat2.xyw = vec3(u_xlat16) * u_xlat2.xyw;
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat8 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat1.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xz = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xz);
    u_xlat1.x = u_xlat8 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat8 = u_xlat22 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat1.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyw = vec3(u_xlat8) * u_xlat2.xyw;
    u_xlat4.w = u_xlat8 * u_xlat16;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat2.xyw;
    u_xlat1 = u_xlat3 + (-u_xlat4);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat4;
    vs_COLOR1 = u_xlat1;
    vs_COLOR2 = in_COLOR0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_15 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_13;
float u_xlat14;
float u_xlat16;
bool u_xlatb16;
float u_xlat21;
float u_xlat22;
float u_xlat23;
float u_xlat25;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat14 = u_xlat1.y + (-_MeltY);
    u_xlat14 = u_xlat14 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat21 = log2(u_xlat14);
    vs_TEXCOORD2 = u_xlat14;
    u_xlat14 = u_xlat21 * _MeltCurve;
    u_xlat14 = exp2(u_xlat14);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat14) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat2.x = u_xlat22 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat9 * u_xlat2.x;
    u_xlat9 = u_xlat2.x * _HeigtFogColDelta3.w;
    u_xlat16 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat22>=u_xlat16);
#else
    u_xlatb16 = u_xlat22>=u_xlat16;
#endif
    u_xlat2.x = (u_xlatb16) ? u_xlat9 : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor3.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase3.w);
    u_xlat9 = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat9) + 2.0;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat4.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat9 = u_xlat22 + (-_HeigtFogRamp3.w);
    u_xlat9 = u_xlat9 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat9) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat9 = u_xlat1.y * _HeigtFogParams3.x;
    u_xlat23 = u_xlat9 * -1.44269502;
    u_xlat2.w = exp2(u_xlat23);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat23 = u_xlat2.w / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_3 = (u_xlatb9) ? u_xlat23 : 1.0;
    u_xlat9 = u_xlat22 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat9 = u_xlat22 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat9 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat23 = (-u_xlat9) + 1.0;
    u_xlat4.xyz = vec3(u_xlat23) * u_xlat4.xyz;
    u_xlat3.w = u_xlat23 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat9) + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyw = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyz = (-u_xlat2.xyw) + _HeigtFogRadialCol2.xyz;
    u_xlat25 = u_xlat22 + (-_HeigtFogRamp2.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyw = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyw;
    u_xlat4.x = u_xlat22 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat16 = (u_xlatb16) ? u_xlat11 : u_xlat4.x;
    u_xlat16 = log2(u_xlat16);
    u_xlat16 = u_xlat16 * _Mihoyo_FogColor2.w;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = min(u_xlat16, _HeigtFogColBase2.w);
    u_xlat2.xyw = vec3(u_xlat16) * u_xlat2.xyw;
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat8 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat1.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xz = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xz);
    u_xlat1.x = u_xlat8 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat8 = u_xlat22 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat1.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyw = vec3(u_xlat8) * u_xlat2.xyw;
    u_xlat4.w = u_xlat8 * u_xlat16;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat2.xyw;
    u_xlat1 = u_xlat3 + (-u_xlat4);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat4;
    vs_COLOR1 = u_xlat1;
    vs_COLOR2 = in_COLOR0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_15 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump float _MeltY;
uniform 	mediump float _MeltRange;
uniform 	mediump float _MeltCurve;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump vec4 vs_COLOR2;
out highp float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_13;
float u_xlat14;
float u_xlat16;
bool u_xlatb16;
float u_xlat21;
float u_xlat22;
float u_xlat23;
float u_xlat25;
void main()
{
    u_xlat0.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat14 = u_xlat1.y + (-_MeltY);
    u_xlat14 = u_xlat14 / _MeltRange;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat21 = log2(u_xlat14);
    vs_TEXCOORD2 = u_xlat14;
    u_xlat14 = u_xlat21 * _MeltCurve;
    u_xlat14 = exp2(u_xlat14);
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat14) + u_xlat1.xz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat2.x = u_xlat22 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat9 * u_xlat2.x;
    u_xlat9 = u_xlat2.x * _HeigtFogColDelta3.w;
    u_xlat16 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat22>=u_xlat16);
#else
    u_xlatb16 = u_xlat22>=u_xlat16;
#endif
    u_xlat2.x = (u_xlatb16) ? u_xlat9 : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor3.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase3.w);
    u_xlat9 = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat9) + 2.0;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat4.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat9 = u_xlat22 + (-_HeigtFogRamp3.w);
    u_xlat9 = u_xlat9 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat9) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat9 = u_xlat1.y * _HeigtFogParams3.x;
    u_xlat23 = u_xlat9 * -1.44269502;
    u_xlat2.w = exp2(u_xlat23);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat23 = u_xlat2.w / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_3 = (u_xlatb9) ? u_xlat23 : 1.0;
    u_xlat9 = u_xlat22 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat9 = u_xlat22 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3 = u_xlat9 * u_xlat16_3;
    u_xlat9 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat23 = (-u_xlat9) + 1.0;
    u_xlat4.xyz = vec3(u_xlat23) * u_xlat4.xyz;
    u_xlat3.w = u_xlat23 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat9) + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyw = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyz = (-u_xlat2.xyw) + _HeigtFogRadialCol2.xyz;
    u_xlat25 = u_xlat22 + (-_HeigtFogRamp2.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyw = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyw;
    u_xlat4.x = u_xlat22 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat16 = (u_xlatb16) ? u_xlat11 : u_xlat4.x;
    u_xlat16 = log2(u_xlat16);
    u_xlat16 = u_xlat16 * _Mihoyo_FogColor2.w;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = min(u_xlat16, _HeigtFogColBase2.w);
    u_xlat2.xyw = vec3(u_xlat16) * u_xlat2.xyw;
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat8 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat1.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xz = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xz);
    u_xlat1.x = u_xlat8 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat8 = u_xlat22 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat1.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyw = vec3(u_xlat8) * u_xlat2.xyw;
    u_xlat4.w = u_xlat8 * u_xlat16;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat2.xyw;
    u_xlat1 = u_xlat3 + (-u_xlat4);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat4;
    vs_COLOR1 = u_xlat1;
    vs_COLOR2 = in_COLOR0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _MainColor;
uniform 	float _LightMapIntensity;
uniform 	float _IceMelting;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta1;
uniform 	float _Delta2;
uniform 	vec4 _WaterColor;
uniform 	mediump float _Fresnel0;
uniform 	float _WaterNormalScale;
uniform 	float _WaterRefScale;
uniform 	float _WaterRefIntensity;
uniform 	vec4 _WaterRefColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _WaterNormal;
uniform lowp samplerCube _WaterRefTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
void main()
{
    u_xlat10_0.xyz = texture(_WaterNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xz = u_xlat16_1.xz * vec2(_WaterNormalScale);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot((-u_xlat2.xyz), u_xlat16_0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_0.xyz * (-vec3(u_xlat15)) + (-u_xlat2.xyz);
    u_xlat15 = -abs(u_xlat2.y) + 1.0;
    u_xlat2.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Frequency, _Frequency));
    u_xlat2.xy = cos(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _Delta1;
    u_xlat3.y = u_xlat2.y * _Delta2;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefScale, _WaterRefScale, _WaterRefScale));
    u_xlat10_0.xyz = texture(_WaterRefTex, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _WaterRefColor.xyz;
    u_xlat2.x = u_xlat15 * u_xlat15;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat15 = (-u_xlat2.x) * u_xlat15 + 1.0;
    u_xlat15 = _Fresnel0 * u_xlat15 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * _WaterColor.xyz;
    u_xlat15 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat2.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat15 = u_xlat15 / u_xlat2.x;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.x = (-u_xlat15) * _UWHeightRatio + 1.0;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.y;
    u_xlat2.x = max(u_xlat2.x, _UWCriticalRange);
    u_xlat2.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb7 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_1.x = (u_xlatb7) ? u_xlat2.x : vs_TEXCOORD4.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_6.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat10_2.www) + u_xlat16_6.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat10_2.xyz;
    u_xlat2.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity) + (-u_xlat2.xyz);
    u_xlat4.xyz = u_xlat16_6.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat3.x = u_xlat15 * _UWFogColorHLIntensity;
    u_xlat15 = (-_UWHeightFogDensity) * u_xlat15 + 1.0;
    u_xlat15 = u_xlat15 * _UWHeightFogEffectLimit;
    u_xlat15 = max(u_xlat15, _UWHeightFogEffectStart);
    u_xlat15 = min(u_xlat15, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb15 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : u_xlat4.xyz;
    u_xlat16_15 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(u_xlat16_15);
    u_xlat16_2.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WaterRefIntensity, _WaterRefIntensity, _WaterRefIntensity)) + (-u_xlat1.xyz);
    u_xlat2.x = vs_TEXCOORD2 * _IceMelting;
    u_xlat1.w = _MainColor.w;
    u_xlat0.w = (-u_xlat1.w) + _WaterColor.w;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
}
}
}
Fallback "Diffuse"
}